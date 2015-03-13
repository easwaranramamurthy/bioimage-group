function [ bestFitSigma ] = q3_plotAiryDisk( lambda, numAp, fitGaussian )
%function that plots an airy disk for the given numerical aperture and
%wavelength

%assuming a space from -1500 to 1500 nm radius for simplicity.
xAxis = linspace(-1500, 1500);

%formula to calculate the argument for the bessel function
x = pi*xAxis*2*numAp/lambda;

%calculation of the point spread function

%bessel function of first kind of order one
airyDisk = 2*besselj(1, x);

%squaring the 2*bessel term
airyDisk = airyDisk.*airyDisk;

%dividing by the square of x
airyDisk = airyDisk./(x.*x);

%normalizing to 0-1 scale
airyDisk = (airyDisk-min(airyDisk))/(max(airyDisk)-min(airyDisk));

%plotting
if fitGaussian
    norm = @(xAxis, sigma) exp(-(xAxis/sigma).^2);
    bestFitSigma = lsqnonlin(@(sigma) norm(xAxis, sigma) - airyDisk, 10);
    bestFitNorm = exp(-(xAxis/bestFitSigma).^2);
    plot(xAxis, airyDisk, xAxis, bestFitNorm );
    title('Best Fit Gaussian with Airy Disk');
    legend(sprintf('Airy Disk (lambda=%d,NA=%0.1f)',lambda, numAp), sprintf('Best Fit Gaussian (sigma = %0.2f)',bestFitSigma));
else
    plot(xAxis, airyDisk);
    title('Airy Disk for Given lambda and NA');
    legend(sprintf('Airy Disk (lambda=%d,NA=%0.1f)',lambda, numAp));
    
end

xlabel('Radial Distance from optical axis (nm)');
ylabel('Intensity');
%setting y limit slightly higher than 1 so that peak is visible.
ylim([0 1.05]);
end

