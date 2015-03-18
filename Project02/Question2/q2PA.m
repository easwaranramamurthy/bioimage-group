function [  ] = q2PA( filename )
fname = filename;
info = imfinfo(fname);
num_images = numel(info);
noise = [];
for k = 1:num_images
    A = imread(fname, k);
    figure,imshow(A,[]);
    position = getrect;
    I = imcrop(A,position);
    linearizedImage = double(I(:));
    linearizedImage = 255*(linearizedImage-min(linearizedImage))/(max(linearizedImage)-min(linearizedImage));
    noise = [noise;linearizedImage];
end
[pxx,w] = periodogram(noise);
%plot the power spectrum density estimate
figure, plot(w,10*log10(pxx))
%plot the normplot of the noise
figure,normplot(noise);
coeffs = polyfit(w,10*log10(pxx),1);
fprintf('slope of the power spectrum : %f\n',coeffs(1));
end

