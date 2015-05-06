function [ segmentedImage ] = performSSDLS( I, settings )

imgSize = size(I);

I2 = zeros(imgSize(1), imgSize(2),2);

I2(1:imgSize(1),1:imgSize(2),1) = I(1:imgSize(1),1:imgSize(2));
I2(1:imgSize(1),1:imgSize(2),2) = I(1:imgSize(1),1:imgSize(2));

segmentedImage = matitk('SSDLS', settings , double(I2), double(gradient(I2)),[]);

segmentedImage = squeeze(segmentedImage(:,:,1));

end