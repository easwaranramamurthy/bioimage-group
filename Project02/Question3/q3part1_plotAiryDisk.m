function [ ] = q3_plotAiryDisk( lambda, numAp )
%function that plots an airy disk for the given numerical aperture and
%wavelength
%   Detailed explanation goes here
xAxis = linspace(-1500, 1500);

x = pi*xAxis*2*numAp/lambda;

airyDisk = 2*besselj(1, x);
airyDisk = airyDisk.*airyDisk;
airyDisk = airyDisk./(x.*x);
airyDisk = (airyDisk-min(airyDisk))/(max(airyDisk)-min(airyDisk));

plot(xAxis, airyDisk);
ylim([0 1.05]);

end

