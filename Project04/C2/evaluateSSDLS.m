function [vol_error, fpr, fnr] = evaluateSSDLS( )
%function to evaluate fpr, fnr and volumetric overlap error for SSDLS on
%the first 3 MitoGFP frames
I1 = double(imread('../selected_images/MitoGFP_LgtGal4_a01r01s02001.tif'));
gt1 = imread('../selected_images/frame1.tif');
I2 = double(imread('../selected_images/MitoGFP_LgtGal4_a01r01s02002.tif'));
gt2 = imread('../selected_images/frame2.tif');
I3 = double(imread('../selected_images/MitoGFP_LgtGal4_a01r01s02003.tif'));
gt3 = imread('../selected_images/frame3.tif');

seg1 = performSSDLS(I1);
seg2 = performSSDLS(I2);
seg3 = performSSDLS(I3);
[vol1, fpr1, fnr1] = calcErrors(gt1, seg1)
[vol2, fpr2, fnr2] = calcErrors(gt2, seg2)
[vol3, fpr3, fnr3] = calcErrors(gt3, seg3)

vol_error = mean([vol1, vol2, vol3]);
fpr = mean([fpr1, fpr2, fpr3]);
fnr = mean([fnr1, fnr2, fnr3]);
end

