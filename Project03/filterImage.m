function [ filteredImage ] = filterImage( I, lambda, numAp, pixelSize )

% use lambda, pixelSize and numAp to calculate sigma
sigma = 0.61*lambda/(3*pixelSize*numAp);
%used a kernel size of 6 sigma i.e. 3 sigma on both sides.
kernelSize = 6*round(sigma);

hsize = [kernelSize kernelSize];

%Creating a two-dimensional Gaussian filter h.
h = fspecial('gaussian', hsize , sigma);

%Convolving the 2D image with the gaussian filter.
filteredImage = conv2(double(I),double(h), 'same');
filteredImage = double(filteredImage);
filteredImage = 255*mat2gray(filteredImage);

end