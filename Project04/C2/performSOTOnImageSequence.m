clear all;

%reading in all the MitoGFP image files
seqPrefix = '../project4_data/Mito_GFP_a01/MitoGFP_LgtGal4_a01r01s02%0.3d.tif';
%output_directory
resultsPrefix = 'C2_2_SOT_results/%0.3d.tif';
mkdir('C2_2_SOT_results');

%performing SOT on each image in the series and writing the output to the
%output folder
for i=1:150,
    inFile = sprintf(seqPrefix,i);
    I = double(imread(inFile));
    segmentedImage = performSOT(I, max(I(:)));
    imwrite(segmentedImage, sprintf(resultsPrefix,i), 'Compression', 'None');
end

clear all;