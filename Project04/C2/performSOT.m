function [ segmentedImage ] = performSOT( I, numHistograms )
%function to call matitk function on a given image object given the number
%of histograms parameter
imgSize = size(I);

%creating new 2 image layers
I2 = zeros(imgSize(1), imgSize(2),2);
I2(1:imgSize(1),1:imgSize(2),1) = I(1:imgSize(1),1:imgSize(2));
I2(1:imgSize(1),1:imgSize(2),2) = I(1:imgSize(1),1:imgSize(2));

%calling the matitk function
segmentedImage = matitk('SOT', numHistograms, double(I2));

%converting back to 1 image layer
segmentedImage = squeeze(segmentedImage(:,:,1));

end

