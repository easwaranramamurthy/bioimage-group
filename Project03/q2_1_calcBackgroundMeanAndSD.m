function [ avg, stddev ] = q2_1_calcBackgroundMeanAndSD( input_folder_name )
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

% calculate average and standard deviation of noise
avg = mean(noise);
stddev = std(noise);
end
