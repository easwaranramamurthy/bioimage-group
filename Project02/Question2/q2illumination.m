function [ ] = q2illumination( input_folder_name )
imagefiles = dir([input_folder_name,'/*.tif']);
num_images = length(imagefiles);
E_illum = []; % This will contain the coefficients of variance
for k = 1:num_images
    currentfilename = imagefiles(k).name;
    A = imread([input_folder_name,'/',currentfilename]);
    A_std = mean(std2(A)); % Standard Deviation of matrix
    A_mean = mean(mean(A)); % Mean of matrix
    A_illum = A_std/A_mean; % CoV of matrix
    E_illum(end+1) = A_illum*100; % CoV converted to percent & recorded
end
figure
hist(double(E_illum),num_images); % CoV as percent histogram
end