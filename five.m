clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

img = imread("Image5.jpg");
imshow(img);
title("Original Image");

figure;
imshow(img);
title('Original');

grayimg = im2gray(img);

BW = edge(grayimg, "roberts");
BW = imdilate(BW, strel("disk", 3));
BW = bwareaopen(BW, 50);

overlay = im2double(img);

overlay(:,:,1) = max(overlay(:,:,1), BW);
overlay(:,:,2) = overlay(:,:,2) .* ~BW;
overlay(:,:,3) = overlay(:,:,3) .* ~BW;

figure;

subplot(1,2,1);
imshow(BW);
title("Roberts Edge Mask");

subplot(1,2,2);
imshow(overlay);
title("Roberts Overlay");


% techs = ["sobel", "prewitt", "roberts", "log", "canny", "zerocross", "approxcanny"];

% for index = 1:length(techs)

%     BW = edge(grayimg, techs(index));
%     BW = imdilate(BW, strel("disk", 3));

%     overlay = im2double(img);

%     overlay(:,:,1) = max(overlay(:,:,1), BW);
%     overlay(:,:,2) = overlay(:,:,2) .* ~BW;
%     overlay(:,:,3) = overlay(:,:,3) .* ~BW;

    % figure;

    % subplot(1,2,1);
    % imshow(BW);
    % title(techs(index) + " Edge Mask");

    % subplot(1,2,2);
    % imshow(overlay);
    % title(techs(index) + " Overlay");

% end

%% --------------------------------------------------------------------

if ~exist("output", "dir")
    mkdir("output")    
end


% imwrite(img_enhanced, fullfile("output", "Image5.jpg"))