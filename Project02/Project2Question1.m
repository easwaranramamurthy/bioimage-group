% Implementation of a Gaussian Filter.

%Reading Image.
I = imread('image1.tiff');

%Asking user for input of sigma.
sigma = input('Please Enter the value of sigma:');

%Assuming size of gaussain matrix as 15 by 15.
hsize = [15 15];

%Creating a two-dimensional Gaussian filter h.
h = fspecial('gaussian', hsize , sigma);

%Convolving the 2D image with the gaussian filter.
I2 = conv2(I,h);

% Displaying the original image, then after getting sigma input, displaying
% filtered image.
figure, imshow(I, [])
figure, imshow(I2, [])

%Comments below
% Gaussian filter is essentially a low-pass filter. Thus, it removes noise
% but also removes detail.
% Large sigma means a wider Gaussain filter means greater smoothening
% Thus as sigma goes from 1 to 7 , we see a greater blur of the image as
% greater amount of detail is removed.