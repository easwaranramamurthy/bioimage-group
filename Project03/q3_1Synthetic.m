function [ outputImage ] = q3_1Synthetic( maxes, lambda, numAp, pixelSize, avgBG, stdBG )

sigma = 0.61*lambda/(3*pixelSize*numAp);

kernelSize = 6*round(sigma);

hsize = [kernelSize kernelSize];

%Creating a two-dimensional Gaussian filter h.
h = fspecial('gaussian', hsize , sigma);

%Convolving the 2D image with the gaussian filter.
outputImage = conv2(double(maxes),double(h), 'same');
maxVal = 2535 / max(max(outputImage));
outputImage = outputImage * maxVal;
background = randn(size(maxes));
background = (background*stdBG)+avgBG;
outputImage = outputImage + background;
outputImage = uint16(outputImage);

end

