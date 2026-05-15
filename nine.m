clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

img = imread("Image4.jpg");
imshow(img);
title("Original Image");
%% --------------------------------------------------------------------

if ~exist("output", "dir")
    mkdir("output")    
end


% imwrite(img_enhanced, fullfile("output", "Image4.jpg"))