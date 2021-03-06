addpath(genpath('~/AV/'))

back = imread('background1.jpg','jpg');
fore = imread('00090.MTS0057.jpg','jpg');

figure(1)
diff = abs(fore-back);
imshow(diff)

figure(2)
hsvdiff = rgb2hsv(diff);
imshow(hsvdiff(:,:,3)>0.15)
