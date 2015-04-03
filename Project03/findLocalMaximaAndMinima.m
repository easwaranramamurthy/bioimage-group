function [maxes, mins] = findLocalMaximaAndMinima(I, maskSize)

numRows = size(I,1);
numCols = size(I,2);
maxes = ones(size(I));
mins = ones(size(I));
maxOffset = floor(maskSize/2);
for i=1:numRows,
    for j=1:numCols,
        for row=i-maxOffset:i+maxOffset,
            for col=j-maxOffset:j+maxOffset,
                if(row>=1&&row<=numRows)
                    if(col>=1&&col<=numCols)
                        if(~(row==i&&col==j))
                            if(I(i,j)<I(row,col))
                                maxes(i,j)=0;
                            end
                            if(I(i,j)>I(row,col))
                                mins(i,j)=0;
                            end
                        end
                    end
                end
            end
        end
    end
end