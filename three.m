clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

img = im2double(imread("Image3.bmp"));
imshow(img);
title("Original Image");

disp(size(img));

i_med = medfilt2(img, [3 3]);
figure;
imshow(i_med);

i_gauss = imgaussfilt(img, 1);
figure;
imshow(i_gauss);

i_bil = imbilatfilt(img, 0.1, 10);
figure;
imshow(i_bil);

techs = ["sobel", "prewitt", "roberts", "log", "canny", "canny_old", "zerocross", "approxcanny"];

for index = 1:size(techs, 2)
    BW = edge(i_bil, techs(index));
    % Convert grayscale image to RGB
    rgb_img = repmat(i_bil, [1 1 3]);

    % Create red overlay
    red = rgb_img(:,:,1);
    green = rgb_img(:,:,2);
    blue = rgb_img(:,:,3);

    red(BW) = 1;
    green(BW) = 0;
    blue(BW) = 0;

    overlay = cat(3, red, green, blue);

    figure;

    subplot(1,2,1);
    imshow(BW);
    title(techs(index) + " Edge Mask");

    subplot(1,2,2);
    imshow(overlay);
    title(techs(index) + " Overlay");
end

% Histogram comparison
figure;
subplot(1,2,1);
imhist(img);
title("Original")
subplot(1,2,2);
imhist(i_bil);
title("Enhanced")

% PSNR
[peaksnr, ~] = psnr(uint8(i_bil), uint8(img));
disp("PSNR: " + peaksnr);

% Contrast 
contrast_original = std2(img);
contrast_enhanced = std2(i_bil);
disp("Contrast: " + contrast_original);
disp("Enhanced Contrast: " + contrast_enhanced);

%% --------------------------------------------------------------------

if ~exist("output", "dir")
    mkdir("output")    
end


imwrite(i_bil, fullfile("output", "Image3.BMP"))