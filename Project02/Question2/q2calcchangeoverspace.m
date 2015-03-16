function [ ] = q2calcchangeoverspace( input_folder_name )
imagefiles = dir([input_folder_name,'/*.tif']);
num_images = 218;
numTimes = 10;
all_means = zeros(numTimes,1);
all_std = zeros(numTimes,1);
[maxheight,maxwidth,~] = size(imread([input_folder_name,'/',imagefiles(1).name]));
width = round(maxwidth/numTimes)-2;
height = 20;
position = [0    0  width   height];
for j = 1:numTimes
    noise = q2backgroundnoise(input_folder_name,imagefiles,num_images,position);
    if (position(4) > 80) 
        position(4) = 20;
    end
    position(1) = position(3);
    position(2) = position(4);
    position(3) = position(3) + width;
    position(4) = position(4) + height;
    
    all_means(j) = mean(noise);
    all_std(j) = std(noise);
end
xAxis = linspace(1,numTimes, numTimes);
figure,plot(xAxis,all_means), xlabel('Number of times'), ylabel('mean of the noise in each position'), title('Mean vs. number of times')
figure,plot(xAxis,all_std), xlabel('Number of times'), ylabel('standard deviation of the noise in each position'), title('Std vs. number of times')
end

function [ noise ] = q2backgroundnoise( input_folder_name,imagefiles,num_images,position )
noise = [];
%read the series of images.
for k = 1:num_images
    %extract the file name
    currentfilename = imagefiles(k).name;
    %read the current file
    A = imread([input_folder_name,'/',currentfilename]);
    %get the initial position for cropping the image
    %crop the region
    I = imcrop(A,position);
    %scale the image
    normalizedImage = uint8(255*mat2gray(I));
    normalizedImage = double(normalizedImage(:));
    %noise variable
    noise = [noise;normalizedImage];
end
end

