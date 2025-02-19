function img_output = integral_image_adaptive_threshold_modified(input_image, window_size, threshold_sensitivity, num_iter)
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
    half_s = floor(window_size / 2);
    img_output = false(rows, cols);

    total_time = 0;
    for k = 1:num_iter
        tic;
        integral_image = cumsum(cumsum(input_image, 1), 2);

        for i = 1:rows
            for j = 1:cols
                
                x1 = max(i - half_s, 1);
                x2 = min(i + half_s, rows);
                y1 = max(j - half_s, 1);
                y2 = min(j + half_s, cols);
                sum_window = integral_image(x2, y2);
                if x1 > 1
                    sum_window = sum_window - integral_image(x1 - 1, y2);
                end
                if y1 > 1
                    sum_window = sum_window - integral_image(x2, y1 - 1);
                end
                if x1 > 1 && y1 > 1
                    sum_window = sum_window + integral_image(x1 - 1, y1 - 1);
                end
    
                count = (x2 - x1 + 1) * (y2 - y1 + 1);
                avg = sum_window / count;
                img_output(i, j) = input_image(i, j) > (avg * (1 - threshold_sensitivity / 100));
            end
        end
        img_output = bwareaopen(img_output, 10); 
        total_time = total_time + toc;
    end
    avg_time = total_time / num_iter;
    fprintf('Tempo médio de execução (Integral Image Modified): %.6f s\n', avg_time);
    fprintf('Tempo médio de execução (Integral Image Modified): %.6f ms\n', avg_time*1000);
end

