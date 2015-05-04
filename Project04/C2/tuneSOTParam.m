function [] = tuneSOTParam( filename, out_dir )

mkdir(out_dir);
I = double(imread(filename));
max_histograms = max(I(:));
if(max_histograms>255)
    %just filtering for the 60x image since the max intensity is very high
    %in that one
    max_histograms = 255;
end
for num = 0:max_histograms,
    result = performSOT(I, num);
    text = sprintf('num_histograms_%0.3d',num);
    result = insertText(result, [0 0], text);
    imwrite(result, [out_dir,text,'.tif'], 'TIF', 'Compression', 'None');
end
end

