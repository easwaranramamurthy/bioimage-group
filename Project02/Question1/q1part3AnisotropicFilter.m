function [ gt ] = q1part3AnisotropicFilter( imageFile, sigmaU, sigmaV, theta )
%function to apply an anisotropic filter to the given image and return the
%filtered image

% imageFile - image file to be filtered
% sigmaU - lateral direction sigma (horizontal)
% sigmaV - longitudinal direction sigma (vertical)
% theta - orientation angle in degrees

% gt - image matrix that is filtered along the xt axis corresponding to
% given theta

% reading image file
I = imread(imageFile);

% Calculating sigmaX, tanPsi and other parameters of the gaussians
% Variables are named according to the paper Geusebroek et al., 2003, IEEE
% Transactions on Image Processing

% converting theta to radians
theta = degtorad(theta);
sigmaX = abs(sigmaU*sigmaV/sqrt(sigmaV^2*cos(theta)^2+sigmaU^2*sin(theta)^2));
tanPsi = ((sigmaV^2)*(cos(theta)^2)+(sigmaU^2)*(sin(theta)^2))/((sigmaU^2-sigmaV^2)*cos(theta)*sin(theta));
psi = atan(tanPsi);
sigmaPsi = abs((1/sin(psi))*(sqrt(sigmaV^2*cos(theta)^2+sigmaU^2*sin(theta)^2)));

% assuming filter size in x direction is 15 pixels
N = 15;

% linear space for the gaussian
x = linspace(-floor(N/2),floor(N/2), N+1);

% x axis 1D gaussian filter
wX = exp(x.^2/(-2*sigmaX^2))/(sqrt(2*pi)*sigmaX);

% initializing the output image of x-axis filtering
gx = zeros(size(I));

%height of image
h = size(I,1);

%filtering using x-axis filter
%this is a simple convolution of each row with the Gaussian filter and so
%we only loop through the rows and convolute them individually.
for y2=1:h,
    gx(y2,:) = conv(double(I(y2,:)'),double(wX), 'same')';
end


%initializing variables for t-axis filtering

%filter size in t direction
M = 15;

%width of image
w = size(I,2);

%linear space along t-axis
t = linspace(0,floor(M/2), floor(M/2)+1);

%gaussian filter along t-axis
wT = exp(t.^2/(-2*sigmaPsi^2))/(sqrt(2*pi)*sigmaPsi);

% initializing output image matrix to zeros
gt = zeros(size(I));

% interpolation coefficient set to 0.5 to give equal importance to pixels
% on both sides of a given pixel
a=0.5;

%mean
mu = abs(tanPsi);

%individually applying the convolution to each pixel
for y2=1:h,
    for x2=1:w,
        %adding effect of the pixel itself
        gt(y2,x2) = wT(1)*gx(y2,x2);
        
        %adding up terms in the summation
        for j=2:floor(M/2)+1,
            innerSum = 0;
            %checking boundaries and adding accordingly (equivalent to zero
            %padding)
            if and(floor(x2-j/mu)>0,y2-j>0)
                innerSum = innerSum+a*gx(y2-j,floor(x2-j/mu));
            end
            if and(floor(x2+j/mu)<=w,y2+j<=h)
                innerSum = innerSum + a*gx(y2+j,floor(x2+j/mu));
            end
            if and(floor(x2-j/mu)-1>0,y2-j>0)
                innerSum = innerSum + (1-a)*gx(y2-j,floor(x2-j/mu)-1);
            end
            if and(floor(x2+j/mu)+1<=w,y2+j<=h)
                innerSum = innerSum + (1-a)*gx(y2+j,floor(x2+j/mu)+1);
            end
            
            %accumulating the sum
            gt(y2,x2) = gt(y2,x2)+wT(j)*(innerSum);
        end
    end
end
end

