clear all;
seqPrefix = '../project4_data/Mito_GFP_a01/MitoGFP_LgtGal4_a01r01s02%0.3d.tif';
resultsPrefix = 'C2_2_SSDLS_results_with_filtering/%0.3d.tif';
mkdir('C2_2_SSDLS_results_with_filtering');
for i=1:150,
    inFile = sprintf(seqPrefix,i);
    I = double(imread(inFile));
    segmentedImage = performSSDLS(I);
    imwrite(segmentedImage, sprintf(resultsPrefix,i), 'Compression', 'None');
end
clear all;

