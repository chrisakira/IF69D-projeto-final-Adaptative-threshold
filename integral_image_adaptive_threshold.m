function img_output = integral_image_adaptive_threshold(input_image, window_size, threshold_sensitivity, num_iter)
    % INTEGRAL_IMAGE_ADAPTIVE_THRESHOLD - Adaptive thresholding using an integral image
    %   
    % Parameters:
    % input_image - Grayscale input image (uint8)
    % window_size - Local window size (in pixels)
    % threshold_sensitivity - Threshold percentage (e.g., 15 for 15%)
    % num_iter - Number of iterations for benchmarking execution time
    %
    % Return:
    % img_output - Binary output image (logical)

    input_image = double(input_image);
    input_image = imgaussfilt(input_image, 1);
    [rows, cols] = size(input_image);
    img_output = zeros(rows, cols, 'uint8');

    integral_image = zeros(rows, cols);
    
    total_time = 0;
    for k = 1:num_iter
        tic; 
        for i = 1:cols
            sum_col = 0;
            for j = 1:rows
                sum_col = sum_col + input_image(j, i);
                if i == 1
                    integral_image(j, i) = sum_col;
                else
                    integral_image(j, i) = integral_image(j, i - 1) + sum_col;
                end
            end
        end
        
        half_s = floor(window_size / 2);
        for i = 1:cols
            for j = 1:rows
                x1 = max(i - half_s, 1);
                x2 = min(i + half_s, cols);
                y1 = max(j - half_s, 1);
                y2 = min(j + half_s, rows);
                
                count = (x2 - x1 + 1) * (y2 - y1 + 1);
                sum_window = integral_image(y2, x2);
        
                if x1 > 1
                    sum_window = sum_window - integral_image(y2, x1 - 1);
                end
                if y1 > 1
                    sum_window = sum_window - integral_image(y1 - 1, x2);
                end
                if x1 > 1 && y1 > 1
                    sum_window = sum_window + integral_image(y1 - 1, x1 - 1);
                end
                
                if input_image(j, i) * count <= (sum_window * (100 - threshold_sensitivity) / 100)
                    img_output(j, i) = 0;
                else
                    img_output(j, i) = 255;
                end
            end
        end
        img_output = bwareaopen(img_output, 10); 
        total_time = total_time + toc;
    end
    avg_time = total_time / num_iter;
    fprintf('Tempo médio de execução (Integral Image): %.6f s\n', avg_time);
    fprintf('Tempo médio de execução (Integral Image): %.6f ms\n', avg_time*1000);
end
