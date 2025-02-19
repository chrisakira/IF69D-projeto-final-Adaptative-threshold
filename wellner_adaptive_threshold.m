function img_output = wellner_adaptive_threshold(input_image, window_size, threshold_sensitivity, num_iter)
    % WELLNER_ADAPTIVE_THRESHOLD - Adaptive thresholding using Wellner's method
    %
    % Parameters:
    % input_image - Grayscale input image (uint8)
    % window_size - Size of the local region for thresholding (recommended: 1/8th of image width)
    % threshold_sensitivity - Sensitivity percentage (e.g., 15 for 15%)
    % num_iter - Number of iterations for benchmarking execution time
    %
    % Return:
    % img_output - Binary output image (logical)
    
    input_image = double(input_image);
    input_image = imgaussfilt(input_image, 1);

    [rows, cols] = size(input_image);
    img_output = false(rows, cols);
    total_time = 0; 
    for k = 1:num_iter
        tic;
        moving_avg = 127 * window_size; 
        for i = 1:rows
            for j = 1:cols
                moving_avg = moving_avg - (moving_avg / window_size) + input_image(i, j);
                threshold = (moving_avg / window_size) * (100 - threshold_sensitivity) / 100;
    
                if input_image(i, j) < threshold
                    img_output(i, j) = false; 
                else
                    img_output(i, j) = true;
                end
            end
        end
        img_output = bwareaopen(img_output, 10); 
        total_time = total_time + toc;
    end
    avg_time = total_time / num_iter;
    fprintf('Tempo médio de execução (Wellner): %.6f s\n', avg_time);
    fprintf('Tempo médio de execução (Wellner): %.6f ms\n', avg_time*1000);
end
 