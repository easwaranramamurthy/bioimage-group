function [ detectedLines ] = StegerDetection( imageFile )

I = double(imread(imageFile));

gaussX = zeros(size(I));
gaussY = zeros(size(I));
gaussDerivX = zeros(size(I));
gaussDerivY = zeros(size(I));
gaussDerivXX = zeros(size(I));
gaussDerivYY = zeros(size(I));
gaussDerivXY = zeros(size(I));

sprintf('Starting first for loop')
for i=1:size(I,1),
    for j=1:size(I,2),
        sprintf('Currently working on i:%d, j:%d',i,j)    
        gaussX(i,j) = getPhiSigma(i+0.5,j)-getPhiSigma(i-0.5,j);
        gaussY(i,j) = getPhiSigma(i,j+0.5)-getPhiSigma(i,j-0.5);
    end
end



sprintf('Starting second for loop')
for i=1:size(I,1),
    for j=1:size(I,2),
        sprintf('Currently working on i:%d, j:%d',i,j)    
        gaussDerivX(i,j) = getGauss(i+0.5,j, gaussX)-getGauss(i-0.5,j,gaussX);
        gaussDerivY(i,j) = getGauss(i,j+0.5, gaussY)-getGauss(i,j-0.5,gaussY);
        gaussDerivXX(i,j) = getGauss(i+1,j,gaussX)-2*getGauss(i,j,gaussX)+getGauss(i-1,j,gaussX);
        gaussDerivYY(i,j) = getGauss(i,j+1,gaussY)-2*getGauss(i,j,gaussY)+getGauss(i,j-1,gaussY);
        gaussDerivXY(i,j) = getGauss(i+0.5,j+0.5,gaussX)-getGauss(i-0.5,j+0.5, gaussX)-getGauss(i+0.5,j-0.5,gaussX)+getGauss(i-0.5,j-0.5,gaussX);
    end
end


rX = conv2(I, gaussDerivX, 'same');
rY = conv2(I, gaussDerivY, 'same');
rXX = conv2(I, gaussDerivXX, 'same');
rYY = conv2(I, gaussDerivYY, 'same');
rXY = conv2(I, gaussDerivXY, 'same');

detectedLines = zeros(size(I));

sprintf('Starting third for loop')

for i=1:size(I,1),
    for j=1:size(I,2),
        sprintf('Currently working on i:%d, j:%d',i,j)
        hessian = [rXX(i,j), rXY(i,j);rXY(i,j), rYY(i,j)];
        [V, D] = eig(hessian);
        D = abs(diag(D)');
        index = find(D==max(D));
        eigVector = V(:,index(1));
        eigVector = eigVector/norm(eigVector);
        nX = eigVector(1);
        nY = eigVector(2);
        t = (rX(i,j)*nX+rY(i,j)*nY)/(rXX(i,j)*(nX^2)+2*rXY(i,j)*nX*nY+rYY(i,j)*(nY^2));
        pX = t*nX;
        pY = t*nY;
        if(pX>=-0.5&&pX<=0.5&&pY>=-0.5&&pY<=0.5)
            detectedLines(i,j) = 1;
        end
    end
end
end

