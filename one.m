clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

img = imread("Image1.jpg");

hsvImg =  rgb2hsv(img);
% figure;
% imshow(hsvImg);
% title("HSV Image");

H = hsvImg(:,:,1);
S = hsvImg(:,:,2);
V = hsvImg(:,:,3);

greenMask = (H > 0.20) & (H < 0.45) & (S > 0.2);

% figure;
% imshow(greenMask);
% title('Detected Green Regions');

S(greenMask) = S(greenMask) * 0.3;
V(greenMask) = V(greenMask) * 0.95;

hsvImg(:,:,2) = S;
hsvImg(:,:,3) = V;

imgProcessed = hsv2rgb(hsvImg);
% figure;
% imshow(imgProcessed);
% title('Green Effect Reduced');

imgBrightAdjusted = imlocalbrighten(imgProcessed);
% figure;
% imshow(imgBrightAdjusted);
% title("Brightness Equalized");

img_enhanced = imbilatfilt(imgBrightAdjusted, 0.01, 10);
img_enhanced = histeq(img_enhanced);
figure;
subplot(1,2,1);
imshow(img);
title("Original Image");
subplot(1,2,2);
imshow(imgBrightAdjusted);
title("Brightness Noise Filtered");

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
[peaksnr, ~] = psnr(uint8(img_enhanced), uint8(img));
disp("PSNR: " + peaksnr);

% Contrast 
contrast_original = std2(rgb2gray(img));
contrast_enhanced = std2(rgb2gray(img_enhanced));
disp("Contrast: " + contrast_original);
disp("Enhanced Contrast: " + contrast_enhanced);

%% --------------------------------------------------------------------

if ~exist("output", "dir")
    mkdir("output")    
end


imwrite(img_enhanced, fullfile("output", "Image1.jpg"))