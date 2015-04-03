function [ result ] = q2_4ttest( meanBG,image,sdBG,local_maxima,confidence_quantile )
newImage = double(image).*local_maxima;
row = size(newImage,1);
col = size(newImage,2);
result = zeros(row,col);

for i = 1:row
    for j =1:col
        if newImage(i,j) ~= 0
            deltaI = abs(newImage(i,j) - meanBG);
            result(i,j) = (sqrt(3)*deltaI/sdBG)>=confidence_quantile;
        end
    end
end

end

