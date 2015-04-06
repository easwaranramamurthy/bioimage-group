function [] = writeMatFiles( input_folder_name, output_folder_name )

num_images = 218;
[avg, stddev] = calcBackgroundMeanAndSD(input_folder_name);

mkdir(output_folder_name);

for k = 1:num_images
    %extract the file name
    currentfilename = sprintf('001_a5_002_t%0.3d.tif',k);
    %read the current file
    A = imread([input_folder_name,'/',currentfilename]);
    filtered = filterImage(A, 515, 1.4, 65);
    [maxes3x3, mins3x3] = findLocalMaximaAndMinima(filtered, 3);
    [maxes5x5, mins5x5] = findLocalMaximaAndMinima(filtered, 5);
    [DT,x,y] = delaunayTriangulateImage(mins5x5);
    significantMaxesQ_7 = q2_4ttest(avg, filtered, stddev, maxes5x5, 7.0);
    save(strcat(output_folder_name,'/',sprintf('001_a5_002_t%0.3d_matFile.mat',k)),'maxes3x3','mins3x3', 'maxes5x5', 'mins5x5', 'significantMaxesQ_7', 'filtered', 'DT');
end
end

