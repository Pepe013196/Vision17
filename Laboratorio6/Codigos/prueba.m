a = imread('55075.jpg');
imshow(a);

resRGB = segmentByClustering(a,'lab','gmm',18);
%subplot(1,2,1);
image(resRGB);
colormap(colorcube);
%subplot(1,2,2);
%imshow(a);
%%
title('LAB')
%%
% % rgb
% % lab
% % hsv
