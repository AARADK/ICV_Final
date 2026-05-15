clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

vid = VideoReader("video1.avi");
outputFolder = "output";
if ~exist(outputFolder, "dir")
    mkdir(outputFolder);
end

% vid.CurrentTime = (14-1)/7;
% img = readFrame(vid);
% imshow(img);
% grayImg = rgb2gray(im2double(img));

% img = imbilatfilt(img, 0.05, 20);
% BW = edge(grayImg, "canny");
% BW = bwareaopen(BW, 150);

% overlay = img;
% red = overlay(:,:,1);
% green = overlay(:,:,2);
% blue = overlay(:,:,3);

% red(BW) = 255;      
% green(BW) = 0;      
% blue(BW) = 0;       

% overlay = cat(3, red, green, blue);

% figure;
% subplot(1,2,1);
% imshow(BW);
% title('Canny Edge Mask');

% subplot(1,2,2);
% imshow(overlay);
% title('Canny Overlay on Frame');


vidOutput = VideoWriter(fullfile(outputFolder, "video1.avi"));
vidOutput.FrameRate = vid.FrameRate;
open(vidOutput);

while hasFrame(vid)
    frame = readFrame(vid);
    grayFrame = rgb2gray(im2double(frame));

    frame = imbilatfilt(frame, 0.05, 20);
    
    BW = edge(grayFrame, "canny");
    BW = bwareaopen(BW, 150);

    overlay = frame;
    red = overlay(:,:,1);
    green = overlay(:,:,2);
    blue = overlay(:,:,3);

    red(BW) = 255;      
    green(BW) = 0;      
    blue(BW) = 0;       

    overlay = cat(3, red, green, blue);
    
    writeVideo(vidOutput, overlay);
end

close(vidOutput);
