function [ significantMaxes ] = q2_4ttest( meanBG,image,sdBG,local_maxima,confidence_quantile )

%getting intensities at local maxima
newImage = double(image).*local_maxima;
row = size(newImage,1);
col = size(newImage,2);
significantMaxes = zeros(row,col);

% loop through the image and do ttest for each maximum
for i = 1:row
    for j =1:col
        %check for maximum
        if newImage(i,j) ~= 0
            % ttest to check for significance
            deltaI = abs(newImage(i,j) - meanBG);
            significantMaxes(i,j) = (sqrt(3)*deltaI/sdBG)>=confidence_quantile;
        end
    end
end

end

