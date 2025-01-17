function [  ] = q2background( input_folder_name, output_folder_name )
%exclude the last 5 images which are the calibration scale images at
%different magnifications
num_images = 218;
noise = [];
all_means = zeros(num_images,1);
stddev = zeros(num_images,1);

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
    %output image path with the image name
    S = sprintf([output_folder_name,'/', sprintf('background%0.3d.tif',k)]);
    linearizedImage = double(I(:));
    %scale the image
    linearizedImage = 255*(linearizedImage-min(linearizedImage))/(max(linearizedImage)-min(linearizedImage));
    %noise variable
    noise = [noise;linearizedImage];
    all_means(k) = mean(linearizedImage);
    stddev(k) = std(linearizedImage);
    %write the image to the output
    imwrite(uint8(255*mat2gray(I)),S,'Compression','none');
end
[pxx,w] = periodogram(noise);
%plot the power spectrum density estimate
figure, plot(w,10*log10(pxx))
%fitting a line to the power spectrum and checking the slope (should be close to 0)
coeffs = polyfit(w,10*log10(pxx),1);
fprintf('slope of the power spectrum : %f\n',coeffs(1));
xAxis= linspace(1,num_images,num_images);
%plot the histogram and fit it with a normal distibution
figure,histfit(noise,num_images,'normal');
%plot the normplot of the noise
figure,normplot(noise);
%plot the change over time for the mean and standard deviation
figure,plot(xAxis,all_means), xlabel('Total Number of Images'), ylabel('means of noise of all images'), title('Mean vs. num of Images'), ylim([0 255])
figure,plot(xAxis,stddev), xlabel('Total Number of Images'), ylabel('std of noise of all images'), title('Standard Deviation vs. num of Images'), ylim([0 255])
end
