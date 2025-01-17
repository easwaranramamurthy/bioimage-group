function [ ] = q2calcchangeoverspace( input_folder_name )
%read all the image files into a variable
imagefiles = dir([input_folder_name,'/*.tif']);
%exclude the last 5 images which are the calibration scale images at
%different magnifications
num_images = 218;
%number of times to select different regions
numTimes = 100;
%initializing the mean and standard deviation
all_means = zeros(numTimes,1);
all_std = zeros(numTimes,1);
[~,maxwidth,~] = size(imread([input_folder_name,'/',imagefiles(1).name]));
maxheight = 50;
width = randi(maxwidth-2,1);
height = randi(maxheight,1);
position = zeros(1,4);

for j = 1:numTimes
    %calculating the noise in the sequence of images
    %selecting different regions
    x1 = randi(maxwidth-2,1);
    y1 = randi(maxheight,1);
    x2 = randi(maxwidth-2,1);
    y2 = randi(maxheight,1);
    
    position(1) = min(x1,x2);
    position(2) = min(y1,y2);
    position(3) = abs(x1-x2);
    position(4) = abs(y1-y2);
    
    noise = q2backgroundnoise(input_folder_name,imagefiles,num_images,position);
    
    all_means(j) = mean(noise);
    all_std(j) = std(noise);
end

xAxis = linspace(1,numTimes, numTimes);
figure,plot(xAxis,all_means), xlabel('Iteration number'), ylabel('mean of the noise in each position'), title('Mean vs. number of times'), ylim([0 255])
figure,plot(xAxis,all_std), xlabel('Iteration number'), ylabel('standard deviation of the noise in each position'), title('Std vs. number of times'), ylim([0 255]) 
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

