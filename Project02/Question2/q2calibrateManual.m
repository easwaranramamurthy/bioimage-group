function [ ] = q2calibrateManual( test_image, mag )
A = imread(test_image);
figure
imshow(A,[]);
height = [];
i = 5;
while i > 0
    rect = getrect;
    height = [height;rect(4)];
    i = i - 1;
    fprintf('%i more measurements.\n',i);
end
avgHeight = mean(height);
micro = 1000*mag/avgHeight;
fprintf('Each pixel is %d micrometers.\n',micro);
end