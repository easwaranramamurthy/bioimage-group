function [ outputImage ] = q3_1Synthetic( I, lambda, numAp, pixelSize, avgBG, stdBG )

sigma = 0.61*lambda/(pixelSize*numAp);

kernelSize = 6*round(sigma);

hsize = [kernelSize kernelSize];

%Creating a two-dimensional Gaussian filter h.
h = fspecial('gaussian', hsize , sigma);

%Convolving the 2D image with the gaussian filter.
outputImage = conv2(double(I),double(h), 'same');
maxVal = max(max(I)) / max(max(outputImage))
outputImage = outputImage * maxVal;
background = randn(size(I));
background = (background*stdBG)+avgBG;
outputImage = outputImage + background;
outputImage = uint16(outputImage);

end

