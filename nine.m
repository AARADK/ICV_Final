clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

vid = VideoReader("video3.avi");
outputFolder = "output";
if ~exist(outputFolder, "dir")
    mkdir(outputFolder);
end

vidOutput = VideoWriter(fullfile(outputFolder, "video3.avi"));
vidOutput.FrameRate = vid.FrameRate;
open(vidOutput);

while hasFrame(vid)
    frame = readFrame(vid);
    img = im2double(frame);

    img = img .^ 0.6;

    for c = 1:3
        img(:,:,c) = imadjust(img(:,:,c), [0.02, 0.95], [0, 1]);
    end

    img = imbilatfilt(img, 0.08, 5);

    gray = rgb2gray(img);
    gray = imsharpen(gray, "Radius", 1.5, "Amount", 0.6);

    BW = edge(gray, "canny", [0.04 0.12]);
    BW = bwareaopen(BW, 150);
    BW = imdilate(BW, strel("disk", 1));

    out = im2uint8(img);

    red = out(:,:,1);
    green = out(:,:,2);
    blue = out(:,:,3);

    red(BW) = 255;
    green(BW) = 0;
    blue(BW) = 0;

    overlay = cat(3, red, green, blue);

    writeVideo(vidOutput, overlay);
end

close(vidOutput);
