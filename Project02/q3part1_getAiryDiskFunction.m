function [ airyDisk ] = q3part1_getAiryDiskFunction( lambda, numAp, xAxis )
%function that plots an airy disk for the given numerical aperture and
%wavelength
%   Detailed explanation goes here

x = pi*xAxis*2*numAp/lambda;

airyDisk = 2*besselj(1, x);
airyDisk = airyDisk.*airyDisk;
airyDisk = airyDisk./(x.*x);
airyDisk = (airyDisk-min(airyDisk))/(max(airyDisk)-min(airyDisk));

% plot(xAxis, airyDisk);

end

