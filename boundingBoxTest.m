function [] = boundingBoxTest(seq, show, backNum, path, mhiType)
    
    if nargin < 5
        mhiType = 1;
    end
    if nargin < 4
        path = '~/AV/train/';
    end
    if nargin < 3
        backNum = 1;
    end
    if nargin < 2
        show = 1;
    end    
    
    binIms = binariseSeq(seq, backNum, path);
    mhi = motionHistoryImage(binIms, mhiType);
    [minX maxX minY maxY] = findHand(mhi);

    figure(show)
    imshow(mhi/(max(max(mhi))))
    hold on
    plot([minX minX maxX maxX minX], [minY maxY maxY minY minY]);   
    hold off
    saveas(show, sprintf('~/AV/AVcw1/Results/BBoxMHI%02dThresh0_05.png',show),'png');
