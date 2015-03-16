function [  ] = q2background( input_folder_name, output_folder_name )
imagefiles = dir([input_folder_name,'/*.tif']);
num_images = length(imagefiles) - 5;
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
        %close the window after double clicking the spot
        %to get the position
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
    %imwrite(uint8(255*mat2gray(I)),S,'Compression','none');
end
[pxx,w] = periodogram(noise);
figure, plot(w,10*log10(pxx))
coeffs = polyfit(w,10*log10(pxx),1);
xAxis= linspace(1,num_images,num_images);
figure,histfit(noise,num_images,'normal');
figure,normplot(noise);
%fprintf('jbtest results: %d\n',jbtest(noise));
%fprintf('kstest results: %d\n',kstest(noise));
%fprintf('lillietest results: %d\n',lillietest(noise));
%fprintf('adtest results: %d\n',adtest(noise));
figure,plot(xAxis,all_means), xlabel('Total Number of Images'), ylabel('means of all images'), title('Mean vs. num of Images')
figure,plot(xAxis,stddev), xlabel('Total Number of Images'), ylabel('std of all images'), title('Standard Deviation vs. num of Images')
end
