function [ DT,x,y ] = delaunayTriangulateImage( mins )

numRows = size(mins,1);
numCols = size(mins,2);

x = [];
y = [];
for i=1:numRows,
    for j=1:numCols,
        if(mins(i,j)==1)
            y=[y;i];
            x=[x;j];
        end
    end
end

DT = delaunayTriangulation(x,y);

end

