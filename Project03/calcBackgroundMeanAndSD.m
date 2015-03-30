function [ avg, stddev ] = calcBackgroundMeanAndSD( input_folder_name )
%exclude the last 5 images which are the calibration scale images at
%different magnifications
num_images = 218;
noise = [];

%read the series of images.
for k = 1:num_images
    %extract the file name
    currentfilename = sprintf('001_a5_002_t%0.3d.tif',k);
    %read the current file
    A = imread([input_folder_name,'/',currentfilename]);
    %get the initial position for cropping the image
    if k == 1
        figure
        imshow(A,[]);
        position = getrect;
    end
    %crop the region
    I = imcrop(A,position);
    linearizedImage = double(I(:));
    %noise variable
    noise = [noise;linearizedImage];
end

avg = mean(noise);
stddev = std(noise);
end