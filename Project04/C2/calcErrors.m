function [ vol_overlap, fpr, fnr ] = calcErrors( groundTruth, segmented )
% function to calculate fpr, fnr and volumetric overlap error given a
% segmented binary image and a manually segmented binary image representing
% the ground truth
vol_overlap = (1-sum(sum(groundTruth==segmented))/numel(groundTruth));
numFP = sum(sum(segmented-groundTruth==1));
numGTDetect = sum(sum(groundTruth==1));
numFN = sum(sum(segmented-groundTruth==-1));
fpr = numFP/numGTDetect;
fnr = numFN/numGTDetect;

end

