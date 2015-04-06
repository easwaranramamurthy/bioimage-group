function [ centerXs, centerYs ] = gaussianFitting( filtered, significantMaxes )

[XI,YI] = meshgrid(1:0.2:size(filtered,2),1:0.2:size(filtered,1));
[X,Y] = meshgrid(1:1:size(filtered,2),1:1:size(filtered,1));

interped = interp2(X,Y,filtered, XI, YI, 'cubic');
centerXs = [];
centerYs = [];

for i=1:size(filtered,1),
    for j=1:size(filtered,2),        
        if(significantMaxes(i,j)==1)
            interpI = 5*(i-1)+1;
            interpJ = 5*(j-1)+1;      
            subMatrix = interped(interpI-2:interpI+2,interpJ-2:interpJ+2);
            x = XI(interpI-2:interpI+2,interpJ-2:interpJ+2);
            y = YI(interpI-2:interpI+2,interpJ-2:interpJ+2);
            
            XY(:,:,1) = x;
            XY(:,:,2) = y;
            
            gaussian2D = @(param,XY) param(1)*exp(-((XY(:,:,1)-param(3)).^2/param(2))-((XY(:,:,2)-param(4)).^2/param(2)));                        
            A = max(max(subMatrix));
            x0 = interpJ;
            y0 = interpI;
            b = 1.5;            
            startParams = [A, b, x0, y0];
            bestParam = lsqcurvefit(gaussian2D,startParams,XY,subMatrix);
            centerXs = [centerXs; (bestParam(3)-1)*0.2+1];
            centerYs = [centerYs; (bestParam(4)-1)*0.2+1];
        end
    end
end


end

