clc; 
clear; 
close all;

input_image = imread('Test_2.jpg');

% Convert to grayscale if necessary
if size(input_image, 3) == 3
    input_image = rgb2gray(input_image);
end

original_image = input_image;
 
img_output_median = matlab_adaptive_threshold(input_image, 0.75, 'median', 1);
img_output_median = uint8(img_output_median * 255);

img_output_mean = matlab_adaptive_threshold(input_image, 0.8, 'mean', 50);
img_output_mean = uint8(img_output_mean * 255);

img_output_gaussian = matlab_adaptive_threshold(input_image, 1, 'gaussian', 50);
img_output_gaussian = uint8(img_output_gaussian * 255);


img_output_wellner = wellner_adaptive_threshold(input_image, round(size(input_image, 2) / 8), 30, 50);
img_output_wellner = uint8(img_output_wellner*255);


img_output_integral = integral_image_adaptive_threshold(input_image, round(size(input_image, 2) / 8), 15, 50);
img_output_integral = uint8(img_output_integral*255);

img_output_integral_modified = integral_image_adaptive_threshold_modified(input_image, round(size(input_image, 2) / 8), 25, 50);
img_output_integral_modified = uint8(img_output_integral_modified*255);



figure;
subplot(2,2,1); imshow(original_image);                 title('Imagem original');
subplot(2,2,2); imshow(img_output_mean);                title('Método Matlab mean');
subplot(2,2,3); imshow(img_output_median);              title('Método Matlab median');
subplot(2,2,4); imshow(img_output_gaussian);            title('Método Matlab gaussian');

figure;
subplot(2,2,1); imshow(original_image);                 title('Imagem original');
subplot(2,2,2); imshow(img_output_wellner);             title('Método Wellner');
subplot(2,2,3); imshow(img_output_integral);            title('Método integral image');
subplot(2,2,4); imshow(img_output_integral_modified);   title('Método modified integral image');

figure;
subplot(2,3,1); imshow(img_output_mean);                title('Método Matlab mean');
subplot(2,3,2); imshow(img_output_median);              title('Método Matlab median');
subplot(2,3,3); imshow(img_output_gaussian);            title('Método Matlab gaussian');
subplot(2,3,4); imshow(img_output_wellner);             title('Método Wellner');
subplot(2,3,5); imshow(img_output_integral);            title('Método integral image');
subplot(2,3,6); imshow(img_output_integral_modified);   title('Método modified integral image');


