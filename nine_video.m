clear; clc; close all;
basePath = "C:\Users\acer\Desktop\Matlab Final\Coursework Image Video";
addpath(basePath);

folder = fullfile(basePath, 'FrameSeq1');

outputVideo = VideoWriter('video3.avi', 'Uncompressed AVI');
outputVideo.FrameRate = 24;
open(outputVideo);

for i = 1:240
    filename = fullfile(folder, sprintf('vespa%03d.jpg', i));
    img = imread(filename);
    writeVideo(outputVideo, img);
end

close(outputVideo);