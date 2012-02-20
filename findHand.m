% finds the location of the hand in the image and returns the 4 parameters of
% a bounding box in the x and y plane. 0,0 is top left corner.
%
function [minX, maxX, minY, maxY] = findHand(image, background)

    
