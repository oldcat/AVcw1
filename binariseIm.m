% Binarises an image by looking for largest continuous area with
% intensity greater than 0.1 in given difference image
%
function [binIm] = binariseIm(diff)

    diff = rgb2hsv(diff);
    binIm = myCleanup(diff(:,:,3)>0.1,3,11);
    %diff = rgb2gray(diff);
    %binIm = myCleanup(diff>0.1,1,2);
    labIm = mybwlabel(binIm);
    
    maxLab = max(max(labIm));
    
    biggest = 0;
    maxSize = 0;
    for i = 1:maxLab
        areaSize = sum(sum(double(labIm == i)));
        if sum(sum(double(labIm == i))) > maxSize
            maxSize = areaSize;
            biggest = i;
        end
    end
    
    if biggest ~= 0
        binIm = (labIm == biggest);
    end
