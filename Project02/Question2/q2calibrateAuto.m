function [ ] = q2calibrate( test_image, mag )
A = imread(test_image);
BW = imcomplement(im2bw(A,graythresh(A)));
figure
imshow(BW);
C = corner(BW)
top = min(C(:,2));
bot = max(C(:,2));
micro = 1000*mag/(bot-top);
fprintf('Each pixel is %d micrometers.\n',micro);
end