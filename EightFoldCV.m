function [class] = EightFoldCV(trainPath, testPath, labelled, backnum, splitType, mhiType)

	if (length(trainPath) == 0) & (length(testPath) == 0)
	    trainPath = '~/AV/train/';
	    selfTest = 1;
    elseif (length(testPath) == 0)
        if trainPath(end) ~= '/'
            trainPath = [trainPath '/'];
        end
	    selfTest = 1;
	else
        if testPath(end) ~= '/'
            testPath = [testPath '/'];
        end
	    selfTest = 0;
        testSeqs = listSeqs(testPath);
        if labelled
            testLabs = getLabels([testPath 'labels']);
            testNums = getLabNum(testLabs);
            testLocs = getLabLocs(testNums);
        end
        tMHItmp = motionHistoryImage(binariseSeq(testSeqs(1,:), backnum, testPath),mhiType);
        tPtmp = getproperties(tMHItmp);
        dTstSeqs = size(testSeqs);
        dTstMHI = size(tMHItmp);
        dTstProps = size(tPtmp);
        testMHIs = zeros([dTstMHI dTstSeqs(1)]);
        testMHIs(:,:,1) = tMHItmp;
        testProps = zeros([dTstProps dTstSeqs(1)]);
        testProps(1,:) = tPtmp;
        for i = 2:dTstSeqs(1)
            testMHIs(:,:,i) = motionHistoryImage(binariseSeq(testSeqs(i,:), backnum, testPath),mhiType);
            testProps(i,:) = getproperties(testMHIs(:,:,i));
        end
	end
	
    trainSeqs = listSeqs(trainPath);
    trainLabs = getLabels([trainPath 'labels']);
    trainNums = getLabNum(trainLabs);
    trainLocs = getLabLocs(trainNums);
	
    tMHItmp = motionHistoryImage(binariseSeq(trainSeqs(getSeqFromLoc(trainLabs,1),:), backnum, trainPath), mhiType);
    tPtmp = getproperties(tMHItmp);
    dTrnSeqs = size(trainLocs);
    dTrnProps = size(tPtmp);
    dTrnMHI = size(tMHItmp);
    trainMHIs = zeros([dTrnMHI dTrnSeqs]);
    trainProps = zeros([dTrnProps dTrnSeqs]);
    trainMHIs(:,:,1,1) = tMHItmp;
    trainProps(:,:,1,1) = tPtmp;
    for j = 1:dTrnSeqs(2)
        for i = 1:dTrnSeqs(1)
            if (j ~= 1) & (i ~= 1) & (trainNums(i,j) > -1)
                trainMHIs(:,:,i,j) = motionHistoryImage(binariseSeq(getSeqFromLoc(trainLabs,3*(j-1)+i), backnum, trainPath),mhiType);
                trainProps(:,:,i,j) = getproperties(trainMHIs(:,:,:,i,j));
            end
        end
    end
	
	trainSets = split8(trainLocs, splitType);

	for fold = 1:8
		if selfTest & labelled
			testLocs = trainSets(:,fold);
		end

        trainLocs = [trainSets(:,1:fold-1) trainSets(:,fold+1:end)];
%		
%		for i = [1:(fold-1) (fold+1):8]
%		    
%       end
	end

    class = 1;
