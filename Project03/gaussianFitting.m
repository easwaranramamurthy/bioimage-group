function [ params ] = gaussianFitting( filtered, significantMaxes )

[XI,YI] = meshgrid(1:0.2:size(filtered,2),1:0.2:size(filtered,1));
[X,Y] = meshgrid(1:1:size(filtered,2),1:1:size(filtered,1));

interped = interp2(X,Y,filtered, XI, YI);
params = [];
maxesY = [];

for i=1:size(filtered,1),
    for j=1:size(filtered,2),
        
        if(significantMaxes(i,j)==1)
            interpI = 5*(i-1)+1;
            interpJ = 5*(j-1)+1;
            
            subMatrix = interped(interpI-2:interpI+2,interpJ-2:interpJ+2);
            
            x = XI(interpI-2:interpI+2,interpJ-2:interpJ+2);
            y = YI(interpI-2:interpI+2,interpJ-2:interpJ+2);
            
            norm = @(x, y, params) params(3)*exp(-((x-params(1)).^2+(y-params(2)).^2)/params(4));
            
            startParams = [interpJ, interpI, interped(interpI,interpJ), 50]
            bestParams = lsqnonlin(@(params) norm(x, y,params) - subMatrix, startParams);
            params = [params;bestParams];
%             maxesY = [maxesY;bestY0];
        end
    end
end

maxesPositions = [params,maxesY];

end

