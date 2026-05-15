clear; clc; close all;
addpath("C:\Users\acer\Desktop\Matlab Final\Coursework Image Video");

%% --------------------------------------------------------------------

vid = VideoReader("video1.avi");
vidOutput = VideoWriter("output\video1.avi");
open(vidOutput);



%% --------------------------------------------------------------------

if ~exist("output", "dir")
    mkdir("output")    
end


% imwrite(vid, fullfile("output", "video1.avi"))