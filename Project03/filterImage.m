function [ filteredImage ] = filterImage( I, lambda, numAp )

sigma = 0.61*lambda/(65*numAp);

kernelSize = 6*round(sigma);

hsize = [kernelSize kernelSize];

%Creating a two-dimensional Gaussian filter h.
h = fspecial('gaussian', hsize , sigma);

%Convolving the 2D image with the gaussian filter.
filteredImage = conv2(double(I),double(h), 'same');
filteredImage = double(filteredImage);

end

