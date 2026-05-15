clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

img = imread("Image4.jpg");
imshow(img);
title("Original Image");

lab = rgb2lab(img);

L = lab(:,:,1) / 100;

L2 = adapthisteq(L, 'NumTiles', [8 8], 'ClipLimit', 0.005);
L2 = imadjust(L2,[0 1],[0 0.9]);
lab(:,:,1) = L2 * 100;

i_enhanced = lab2rgb(lab);
i_filtered = imbilatfilt(i_enhanced, 0.01);
HSV = rgb2hsv(i_filtered);

S = HSV(:,:,2);
V = HSV(:,:,3);
S = S * 0.85;
HSV(:,:,2) = S;

V = min(V, 0.7);
HSV(:,:,3) = V;

i_final = hsv2rgb(HSV);
i_brightened = imlocalbrighten(i_final);
i_brightened = imbilatfilt(i_brightened, 0.01, 10);

figure;

subplot(1,2,1);
imshow(img);
title('Original');

subplot(1,2,2);
imshow(i_brightened);
title('Final Result');

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
imhist(i_brightened(:,:,1));
subplot(1,3,2);
imhist(i_brightened(:,:,2));
subplot(1,3,3);
imhist(i_brightened(:,:,3));

% PSNR
[peaksnr, ~] = psnr(uint8(i_brightened), uint8(img));
disp("PSNR: " + peaksnr);

% Contrast 
contrast_original = std2(rgb2gray(img));
contrast_enhanced = std2(rgb2gray(i_brightened));
disp("Contrast: " + contrast_original);
disp("Enhanced Contrast: " + contrast_enhanced);

%% --------------------------------------------------------------------

if ~exist("output", "dir")
    mkdir("output")    
end

imwrite(i_brightened, fullfile("output", "Image4.jpg"))