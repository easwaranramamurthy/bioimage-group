function [] = tuneSOTParam( filename )
    
I = double(imread(filename));
log2(max(I(:)))
figure
subplot(2,3,1); imshow(I,[]); title('Original Image');
i=1;
for num = linspace(log2(6),log2(64),5),
    i=i+1;
    result = performSOT(I, [2^num]);
    subplot(2,3,i); imshow(result,[]); title(sprintf('%f histograms',2^num));
end
end

