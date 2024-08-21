im1 = imread('StackNinja3.bmp');

% Split into Color Space 
red1 = im1(:,:,1); % red 
green1 = im1(:,:,2); %green  
blue = im1(:,:,3); % blue


% Apply Anisotropic Diffusion
noi_green = imdiffusefilt(green1, 'Connectivity','minimal');


%Sharpen the image
sharp_green = imsharpen(noi_green);


% Edge dectection on Green 
edge_dect = edge(sharp_green, 'canny');


% Dilate the hollow circles 
se = strel('disk', 1);
dilated = imdilate(edge_dect, se);


% Fill the holes in the image
filledImage = imfill(dilated, 'holes');


% Binarize the red color space : with cell wall 
red = imbinarize(red1);
% Remove Unecessary parts 
filledImage(red == 1) = 0;

% Erode the Image 
se2 = strel('disk',2);
eroded = imerode(filledImage, se2);

figure
imshow(eroded);
title('final');
