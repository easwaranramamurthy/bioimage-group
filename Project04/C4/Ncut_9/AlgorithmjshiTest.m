function [  ] = AlgorithmjshiTest( image_name,nbSegments )
% Timothee Cour, Stella Yu, Jianbo Shi, 2004.

disp('Ncut Image Segmentation demo');

%% read image, change color image to brightness image, resize to 160x160
I = imread_ncut(image_name,520,696);

%% display the image
figure(1);clf; imagesc(I);colormap(gray);axis off;
% disp('This is the input image to segment, press Enter to continue...');
% pause;

%% compute the edges imageEdges, the similarity matrix W based on
%% Intervening Contours, the Ncut eigenvectors and discrete segmentation

dataW.sampleRadius=10;
dataW.sample_rate=6;
dataW.edgeVariance = 0.045;

    %disp('computing Ncut eigenvectors ...');

 tic;
 [SegLabel,NcutDiscrete,NcutEigenvectors,NcutEigenvalues,W,imageEdges]= NcutImage(I,nbSegments,dataW);
 disp(['The computation took ' num2str(toc) ' seconds on the ' num2str(size(I,1)) 'x' num2str(size(I,2)) ' image']);
    %figure(3);clf
 bw = edge(SegLabel,0.01);
 J1=showmask(I,imdilate(bw,ones(2,2)));
    %imagesc(J1);axis off
 imwrite(J1,'Blue0001_output.tif');

% %% display the edges
% figure(2);clf; imagesc(imageEdges); axis off
% disp('This is the edges computed, press Enter to continue...');
% pause;

%% display the segmentation
% figure(3);clf
% bw = edge(SegLabel,0.01);
% J1=showmask(I,imdilate(bw,ones(2,2))); imagesc(J1);axis off
% disp('This is the segmentation, press Enter to continue...');
% pause;

% %% display Ncut eigenvectors
% figure(4);clf;set(gcf,'Position',[100,500,200*(nbSegments+1),200]);
% [nr,nc,nb] = size(I);
% for i=1:nbSegments
%     subplot(1,nbSegments,i);
%     imagesc(reshape(NcutEigenvectors(:,i) , nr,nc));axis('image');axis off;
% end
% disp('This is the Ncut eigenvectors...');
% disp('The demo is finished.');
end

