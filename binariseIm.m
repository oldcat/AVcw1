% Finds a threshold and then binarises image by finding largest continuous area in image
%
function [binIm] = binariseIm(image, background)

    diff = rgb2hsv(abs(image-background));
    binIm = mycleanup(diff(:,:,3)>0.1,2,2);
