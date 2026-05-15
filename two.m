clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

img = imread("Image2.JPG");

img = im2double(img);

sharp = imsharpen(img, "Radius", 2, "Amount", 1.2);
lab = rgb2lab(sharp);

L = lab(:,:,1) / 100;

L = adapthisteq(L);

lab(:,:,1) = L * 100;

enhanced = lab2rgb(lab);
final = imbilatfilt(enhanced, 0.03, 5);

figure;
subplot(1,2,1);
imshow(img);
title("Original Image");
subplot(1,2,2);
imshow(final);
title("Enhanced Image");

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
imhist(final(:,:,1));
subplot(1,3,2);
imhist(final(:,:,2));
subplot(1,3,3);
imhist(final(:,:,3));

% PSNR
[peaksnr, ~] = psnr(uint8(final), uint8(img));
disp("PSNR: " + peaksnr);

% Contrast 
contrast_original = std2(rgb2gray(img));
contrast_enhanced = std2(rgb2gray(final));
disp("Contrast: " + contrast_original);
disp("Enhanced Contrast: " + contrast_enhanced);

%% --------------------------------------------------------------------

if ~exist("output", "dir")
    mkdir("output")    
end


imwrite(final, fullfile("output", "Image2.JPG"))