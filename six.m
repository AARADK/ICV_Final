clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

img = imread("Image6.jpg");
imshow(img);
title("Original Image");

lab = rgb2lab(img);

l = lab(:,:,1) / 100;
a = lab(:,:,2);
b = lab(:,:,3);

a = a - mean(a(:));
b = b - mean(b(:));

lab(:,:,2) = a;
lab(:,:,3) = b;

i_rgb = lab2rgb(lab);
i_hsv = rgb2hsv(i_rgb);
S = i_hsv(:,:,2);
S = min(S * 1.6, 1);
i_hsv(:,:,2) = S;
i_rgb = hsv2rgb(i_hsv);

imgProcessed = im2double(i_rgb);
imgProcessed = imbilatfilt(imgProcessed, 0.04);
imgProcessed = im2uint8(imgProcessed);

figure;

subplot(1,2,1);
imshow(img);
title("Original");

subplot(1,2,2);
imshow(imgProcessed);
title("Corrected");

% Histogram comparison
figure;
subplot(1,3,1);
imhist(img(:,:,1));
subplot(1,3,2);
imhist(img(:,:,2));
subplot(1,3,3);
imhist(img(:,:,3));

figure;
subplot(1,3,1);
imhist(imgProcessed(:,:,1));
subplot(1,3,2);
imhist(imgProcessed(:,:,2));
subplot(1,3,3);
imhist(imgProcessed(:,:,3));

% PSNR
[peaksnr, ~] = psnr(uint8(imgProcessed), uint8(img));
disp("PSNR: " + peaksnr);

% Contrast 
contrast_original = std2(rgb2gray(img));
contrast_enhanced = std2(rgb2gray(imgProcessed));
disp("Contrast: " + contrast_original);
disp("Enhanced Contrast: " + contrast_enhanced);


%% --------------------------------------------------------------------

if ~exist("output", "dir")
    mkdir("output")    
end


imwrite(imgProcessed, fullfile("output", "Image6.jpg"))