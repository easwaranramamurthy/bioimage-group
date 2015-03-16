function [ airyDisk ] = q3part1_getAiryDiskFunction( lambda, numAp, xAxis )
%function that returns an airy disk for the given numerical aperture and
%wavelength at the points specified by the xAxis vector

%Calculation of the airy disk function (PSF)

x = pi*xAxis*2*numAp/lambda;

airyDisk = 2*besselj(1, x);
airyDisk = airyDisk.*airyDisk;
airyDisk = airyDisk./(x.*x);
airyDisk = (airyDisk-min(airyDisk))/(max(airyDisk)-min(airyDisk));


end

