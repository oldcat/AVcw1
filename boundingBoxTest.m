function [] = boundingBoxTest(seq, backNum, path)
    
    if nargin == 1
        path = '~/AV/train/';
        backNum = 1;
    elseif nargin == 2
        path = '~/AV/train/';
    end
    
    binIms = binariseSeq(seq, backNum, path);
    
    dim = size(binIms);
    
    [minX maxX minY maxY] = getBBox(binIms);
    
    for i = 1:dim(3)
        figure(i)
        imshow(binIms(:,:,i))
        hold on
        plot([minX minX maxX maxX minX], [minY maxY maxY minY minY]);
        hold off
    end
