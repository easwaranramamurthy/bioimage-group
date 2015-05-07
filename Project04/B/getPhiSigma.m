function [ phiSigma ] = getPhiSigma( x, y )

sigma = 1;

phiSigmaDeriv = @(x,y) exp((-x.^2/(2*sigma.^2))+(-y.^2/(2*sigma.^2)));

phiSigma = integral2(phiSigmaDeriv, -Inf, x, -Inf, y);

end

