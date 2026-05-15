clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

vid = VideoReader("video2.avi");
outputFolder = "output";
if ~exist(outputFolder, "dir")
    mkdir(outputFolder);
end

vid.CurrentTime = (14-1)/15;
% img = readFrame(vid);
% img = im2double(img);

% lab = rgb2lab(img);
% l = lab(:,:,1) / 100;

% l = adapthisteq(l);

% lab(:,:,1) = l * 100;

% img = lab2rgb(lab);

% im_filtered = imbilatfilt(img, 0.01, 3);
% im_filtered = imsharpen(im_filtered);

% figure;

% subplot(1,2,1);
% imshow(img);
% title("Original");

% subplot(1,2,2);
% imshow(im_filtered);
% title("Enhanced");

vidOutput = VideoWriter(fullfile(outputFolder, "video2.avi"));
vidOutput.FrameRate = vid.FrameRate;
open(vidOutput);

while hasFrame(vid)
    frame = readFrame(vid);
    img = im2double(frame);
    lab = rgb2lab(img);
    l = lab(:,:,1) / 100;

    l = adapthisteq(l);

    lab(:,:,1) = l * 100;

    img = lab2rgb(lab);

    im_filtered = imbilatfilt(img, 0.01, 1);
    im_filtered = imsharpen(im_filtered);

    im_filtered = max(min(im_filtered,1),0);
    
    writeVideo(vidOutput, im_filtered);
end

close(vidOutput);    



