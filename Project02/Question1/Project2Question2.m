% Implementation of a Gaussian Filter.

%Reading Image.
I = imread('image1.tiff');

%Asking user for input of sigma.
sigma = input('Please Enter the value of sigma:');

%Assuming size of gaussain matrix as 15 by 15.
hsize = [15 15];

%Creating a two-dimensional Gaussian filter h.
h = fspecial('gaussian', hsize , sigma);

%hx is gradient along x-axis direction and hy is gradient along y-axis
%direction
[hx,hy] = gradient(h);

%Convolving the 2D image with the gaussian filter in the x direction.
I2 = conv2(double(I),double(hx));
I2 = double(I2);

%Convolving the 2D image with the gaussian filter in the y direction.
I3 = conv2(double(I),double(hy));
I3 = double(I3);

%Displaying original image, followed by derivative images.
figure, imshow(I,[])
figure, imshow(I2,[])
figure, imshow(I3,[]);