clear all
close all
clc

%%
% load image
imageFile = '2007_004856.jpg';
im = imread(imageFile);
h = size(im, 1);
w = size(im, 2);

% load heatmap scores
load('heatmap.mat')
heatmap = double(heatmap); % conversion single to double

% use exp to enforce contrast
heatmap = exp(heatmap * 0.02);

% choose colormap
colormap('parula')

% resize the heatmap to the image size
heatmap = imresize(heatmap, [h, w]);
maxScores = max(max(heatmap));
minScores = min(min(heatmap));

% display the image and the heatmap in different plot
figure(1), subplot(1,3,1), imagesc(im); axis off, axis image, title('image')
figure(1), subplot(1,3,2), imagesc(heatmap); axis off, axis image, title('cat heatmap')

% normalized the heatmap: all values are in the range [0, 1]
normalizedHeatmap = (heatmap - minScores) / (maxScores - minScores);

% display the image
figure(1), subplot(1,3,3), imagesc(im), axis image, title('image with cat heatmap');     
hold on
hImg = imagesc(255 * normalizedHeatmap); axis off, caxis([0 255]);

% the alpha parameter change the transparency of the heatmap
alpha = 0.45;
set(hImg, 'AlphaData', alpha);
hold off

print('-djpeg', 'results.jpg')
