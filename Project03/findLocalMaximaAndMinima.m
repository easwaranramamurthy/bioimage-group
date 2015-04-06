function [maxes, mins] = findLocalMaximaAndMinima(I, maskSize)

numRows = size(I,1);
numCols = size(I,2);
maxes = ones(size(I));
mins = ones(size(I));
maxOffset = floor(maskSize/2);

%loop through each element
for i=1:numRows,
    for j=1:numCols,
        % loop through each 3x3 or 5x5 block (depending on mask size)
        for row=i-maxOffset:i+maxOffset,
            for col=j-maxOffset:j+maxOffset,
                % check boundaries
                if(row>=1&&row<=numRows)
                    if(col>=1&&col<=numCols)
                        %ignore the element itself
                        if(~(row==i&&col==j))
                            %check for maxima
                            if(I(i,j)<I(row,col))
                                maxes(i,j)=0;
                            end
                            %check for minima
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