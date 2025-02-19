function img_output = matlab_adaptive_threshold(input_image, threshold_sensitivity, statistic_mode, num_iter)
    % MATLAB_ADAPTIVE_THRESHOLD - Adaptive thresholding using MATLAB's built-in function
    %
    % Parameters:
    % input_image - Grayscale input image (uint8)
    % threshold_sensitivity - Sensitivity percentage for adaptive thresholding
    % statistic_mode - Statistical method used (e.g., 'mean', 'median', 'gaussian')
    % num_iter - Number of iterations for benchmarking execution time
    %
    % Return:
    % img_output - Binary output image (logical)    
    total_time = 0; 
    for i = 1:num_iter
        tic;
        img_output = adaptthresh(input_image, threshold_sensitivity, 'Statistic', statistic_mode);
        img_output = imbinarize(input_image, img_output);
        total_time = total_time + toc;
    end
    avg_time = total_time / num_iter;
    fprintf('Tempo médio de execução (%s): %.6f s\n', statistic_mode, avg_time);
    fprintf('Tempo médio de execução (%s): %.6f ms\n', statistic_mode, avg_time*1000);

end

