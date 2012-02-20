% finds the location of the hand in the image and returns the 4 parameters of
% a bounding box in the x and y plane. 0,0 is top left corner.
%
function [minX, maxX, minY, maxY] = findHand(binIm)
    
    dim = size(binIm);
    
    minX = 0;
    maxX = 0;
    minY = 0;
    maxY = 0;
    
    for r = 1:dim(1)
        if (sum(binIm(r,:)) > 0) & (minY == 0)
            minY = r;
            break;
        end
    end
        
    for r = dim(1):-1:1
        if (sum(binIm(r,:)) > 0) & (maxY == 0)
            maxY = r;
            break;
        end
    end
    
    for c = 1:dim(2)
        if (sum(binIm(:,c)) > 0) & (minX == 0)
            minX = c;
            break;
        end
    end
    
    for c = dim(2):-1:1
        if (sum(binIm(:,c)) > 0) & (maxX == 0)
            maxX = c;
            break;
        end
    end         
