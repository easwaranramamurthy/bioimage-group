clear all;
seqPrefix = '../project4_data/Mito_GFP_a01/MitoGFP_LgtGal4_a01r01s02%0.3d.tif';
resultsPrefix = 'C2_2_SOT_results/%0.3d.tif';
mkdir('C2_2_SOT_results');
for i=1:150,
    inFile = sprintf(seqPrefix,i);
    I = double(imread(inFile));
    segmentedImage = performSOT(I, max(I(:)));
    imwrite(segmentedImage, sprintf(resultsPrefix,i), 'Compression', 'None');
end

clear all;