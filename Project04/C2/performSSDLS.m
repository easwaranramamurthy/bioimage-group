function [ segmentedImage ] = performSSDLS( I )
%function to perform SSDLS on a given image object.

%creating 2 image layers
imgSize = size(I);
I2 = zeros(imgSize(1), imgSize(2),2);
I2(1:imgSize(1),1:imgSize(2),1) = I(1:imgSize(1),1:imgSize(2));
I2(1:imgSize(1),1:imgSize(2),2) = I(1:imgSize(1),1:imgSize(2));

%calling the matitk function with default parameters - the parameters were
%chosen to be default because tuning the parameters resulted in almost the
%same output most of the time.
segmentedImage = matitk('SSDLS', [1 1 0.02 800] , double(I2), double(gradient(I2)),[]);

%squeezing the image back into 1 layer.
segmentedImage = squeeze(segmentedImage(:,:,1));

%converting image to binary image
segmentedImage = (segmentedImage==max(segmentedImage(:)));

%filtering out noisy hits that are less than 4 pixels in size
segmentedImage = bwareaopen(segmentedImage, 4);

end