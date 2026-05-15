clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

vid = VideoReader("video2.avi");
imshow(vid);
title("Original Image");
%% --------------------------------------------------------------------

if ~exist("output", "dir")
    mkdir("output")    
end


% imwrite(img_enhanced, fullfile("output", "V"))