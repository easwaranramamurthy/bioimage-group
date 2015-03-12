function [  ] = q2background( input_folder_name, output_folder_name )
imagefiles = dir([input_folder_name,'/*.tif']);
num_images = length(imagefiles);
%read the series of images.
for k = 1:num_images
    %extract the file name
    currentfilename = imagefiles(k).name;
    %read the current file
    A = imread([input_folder_name,'/',currentfilename]);
    %get the initial position for cropping the image
    if k == 1
        figure, imshow(A,[]); h = imrect; position = wait(h);
        %close the window after double clicking the spot
        %to get the position
    end
    %crop the region
    I = imcrop(A,position);
    %scale the image
    normalizedImage = uint8(255*mat2gray(I));
    %output image path with the image name
    S = sprintf([output_folder_name,'/', sprintf('background%0.3d.tif',k)]);
    %write the image to the output
    imwrite(normalizedImage,S);
end
end
