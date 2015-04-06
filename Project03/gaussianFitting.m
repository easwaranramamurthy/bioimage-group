function [ bestParams, start ] = gaussianFitting( filtered, significantMaxes )

[XI,YI] = meshgrid(1:0.2:size(filtered,2),1:0.2:size(filtered,1));
[X,Y] = meshgrid(1:1:size(filtered,2),1:1:size(filtered,1));

interped = interp2(X,Y,filtered, XI, YI);
bestParams = [];
start = [];

maxesY = [];

num = 0;
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
            
            gaussian2D = @(x,XY) x(1)*exp(-((XY(:,:,1)-x(3)).^2/x(2))-((XY(:,:,2)-x(4)).^2/x(2)));            
            
            A = max(max(subMatrix));
            [x0, y0] = find(subMatrix==max(max(subMatrix)));
            b = 1.5;
            
            startParams = [A, b, 1, 1];
            bestParam = lsqcurvefit(gaussian2D,startParams,XY,subMatrix); 
            bestParams = [bestParams;bestParam];
            start = [start; startParams];
        end
    end
end


end

