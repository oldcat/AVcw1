% Given a series of binary images finds the bounding box for anything happening in them
%
function [minX, maxX, minY, maxY] = getBBox(binIms)
    
    dim = size(binIms);
    
    minX = dim(2)+1;
    maxX = 0;
    minY = dim(1)+1;
    maxY = 0;

    for i = 1:dim(3)
        [miX maX miY maY] = findHand(binIms(:,:,i));
        if (miX < minX) & (miX > 0)
            minX = miX;
        end
        if (maX > maxX) & (maX > 0)
            maxX = maX;
        end
        if (miY < minY) & (miY > 0)
            minY = miY;
        end
        if (maY > maxY) & (maY > 0)
            maxY = maY;
        end
        %fprintf('%02d: (%03d,\t%03d)\t(%03d,\t%03d)\n',i, minX, minY, maxX, maxY)
    end
