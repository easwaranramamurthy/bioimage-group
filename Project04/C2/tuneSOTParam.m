function [] = tuneSOTParam( filename, out_dir )
%function to tune SOT param, write output files for each value of n so that
%it can be visually inspected.

%initializing output directory
mkdir(out_dir);

%reading in input
I = double(imread(filename));

%deciphering max_histograms
max_histograms = max(I(:));

%setting max histograms to 255 for greater than 8 bit images.
if(max_histograms>255)
    %just filtering for the 60x image since the max intensity is very high
    %in that one
    max_histograms = 255;
end

%performing SOT for each setting of n and writing output to the output
%directory.
for num = 0:max_histograms,
    result = performSOT(I, num);
    text = sprintf('no_hist_%0.3d',num);
    result = insertText(result, [0 0], text, 'FontSize',18,'BoxColor','g', 'BoxOpacity', 1);
    imwrite(result, [out_dir,text,'.tif'], 'TIF', 'Compression', 'None');
end
end

