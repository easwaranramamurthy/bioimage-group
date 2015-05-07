function [ detectedLines ] = StegerDetection( imageFile )
width = 5;
thresh = 0.15;
sigma = floor(width/sqrt(3));
hsize = [6*sigma+1 6*sigma+1];

gauss = fspecial('gaussian', hsize, sigma);

[gaussDerivX, gaussDerivY] = gradient(gauss);

[gaussDerivXX, gaussDerivXY] = gradient(gaussDerivX);

[~, gaussDerivYY] = gradient(gaussDerivX);

I = double(imread(imageFile));

I = conv2(I,gauss,'same');
rX = conv2(I, gaussDerivX, 'same');
rY = conv2(I, gaussDerivY, 'same');
rXX = conv2(I, gaussDerivXX, 'same');
rXY = conv2(I, gaussDerivXY, 'same');
rYY = conv2(I, gaussDerivYY, 'same');

detectedLines = zeros(size(I));


for i=1:size(I,1),
    for j=1:size(I,2),
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
            if(abs(rXX(i,j))>thresh && abs(rXY(i,j))>thresh && abs(rYY(i,j))>thresh)
                detectedLines(i,j) = 1;
            end
        end
    end
end
end

