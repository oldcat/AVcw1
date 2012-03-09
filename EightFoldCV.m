% Performs 8 Fold Cross Validation on test data using a training set to prime the classifier.
% The test data is either entered to it or the fold not being used in the CV is used.
%
% Parameters:
%
%   trainPath:  The path of the training data images, they should
%               be in folders numbered 1-1, 1-2...n-m
%   testPath:   The path of the test data images, if using 8th fold
%               to test enter '', folders should be numberer 1, 2...n
%   labelled:   If the test data comes with a set of lables this 
%               should be set to 1, otherwise 0
%   backNum:    Enter the background file number, 1 or 2
%   splitType:  Data can be split one of two ways, way 2 is obsolete,
%               1 should always be used as it is fully random
%   mhiType:    There are 5 types of MHI that can be created, see 
%               motionHistoryImage.m for types, numbers 1-5
%   likeType:   The cumulative likelihoods of each classification can
%               be summed or producted when there is a separate test
%               set. Product is 1, sum is 2
%   show:       If show is set to 1 then the MHIs will be displayed 
%               with bounding boxes
%
function [trainProps, trainLabs] = EightFoldCV(trainPath, testPath, labelled, backnum, splitType, mhiType, likeType, show)

	if (length(trainPath) == 0) & (length(testPath) == 0) 
	% use default path if none given and set to use 8th fold as test data
	    trainPath = '~/AV/train/';
	    selfTest = 1;
    elseif (length(testPath) == 0) 
    % correct train path and set to use 8th fold as test data
        if trainPath(end) ~= '/'
            trainPath = [trainPath '/'];
        end
	    selfTest = 1;
	    
	else
	% get test data from location specified
	
	    % get data
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
        
        % create first motion history image, the size of this is used to define the array to store them all
        tMHItmp = motionHistoryImage(binariseSeq(testSeqs(1,:), backnum, testPath),mhiType);

        % display motion history image with bounding box
        if show
            figure('Name',sprintf('Test Seq: %d',1),'NumberTitle','off')
            [minX maxX minY maxY] = findHand(tMHItmp);
            imshow(tMHItmp/max(max(tMHItmp)))
            hold on
            plot([minX minX maxX maxX minX], [minY maxY maxY minY minY], 'Color', 'Red', 'LineWidth', 3);   
            hold off
        end
       
        % create first property set, the size of this is used to define the array to store them all 
        tPtmp = getproperties(tMHItmp);
        
        dTstSeqs = size(testSeqs);
        dTstMHI = size(tMHItmp);
        dTstProps = size(tPtmp);
        testMHIs = zeros([dTstMHI dTstSeqs(1)]);
        testMHIs(:,:,1) = tMHItmp;
        testProps = zeros([dTstSeqs(1) dTstProps(2)]);
        testProps(1,:) = tPtmp;
        for i = 2:dTstSeqs(1)
            % Create and store motion history images
            testMHIs(:,:,i) = motionHistoryImage(binariseSeq(testSeqs(i,:), backnum, testPath),mhiType);
            % Display motion history images
            if show
                [minX maxX minY maxY] = findHand(testMHIs(:,:,i));
                figure('Name',sprintf('Test Seq: %d',i),'NumberTitle','off')
                imshow(testMHIs(:,:,i)/max(max(testMHIs(:,:,i))))
                hold on
                plot([minX minX maxX maxX minX], [minY maxY maxY minY minY], 'Color', 'Red', 'LineWidth', 3);
                hold off
            end
            % Create and store property vectors
            testProps(i,:) = getproperties(testMHIs(:,:,i));
        end
	end
	
	% get all training motion history images and properties
    trainSeqs = listSeqs(trainPath);
    trainLabs = getLabels([trainPath 'labels']);
    trainNums = getLabNum(trainLabs);
    numLabs = max(max(trainNums));
    trainLocs = getLabLocs(trainNums);

    % create first motion history image, the size of this is used to define the array to store them all
    tMHItmp = motionHistoryImage(binariseSeq(trainSeqs(getSeqFromLoc(trainLabs,1),:), backnum, trainPath), mhiType);

    % display motion history image with bounding box
    if show
        [minX maxX minY maxY] = findHand(tMHItmp(:,:,1,1));
        figure('Name',sprintf('Train Seq: %d-%d',1,1),'NumberTitle','off')
        imshow(tMHItmp(:,:,1,1)/max(max(tMHItmp(:,:,1,1))))
        hold on
        plot([minX minX maxX maxX minX], [minY maxY maxY minY minY], 'Color', 'Red', 'LineWidth', 3);
        hold off
    end

    % create first property set, the size of this is used to define the array to store them all 
    tPtmp = getproperties(tMHItmp);  
     
    dTrnSeqs = size(trainNums);
    dTrnProps = size(tPtmp);
    dTrnMHI = size(tMHItmp);
    trainMHIs = zeros([dTrnMHI dTrnSeqs]);
    trainProps = zeros([dTrnProps dTrnSeqs]);
    trainMHIs(:,:,1,1) = tMHItmp;
    trainProps(:,:,1,1) = tPtmp;
    for j = 1:dTrnSeqs(2)
        for i = 1:dTrnSeqs(1)
            if ((j ~= 1) | (i ~= 1)) & (trainNums(i,j) > -1)
                % Create and store motion history images
                trainMHIs(:,:,i,j) = motionHistoryImage(binariseSeq([i j], backnum, trainPath),mhiType);
                if show
                    % display motion history image
                    [minX maxX minY maxY] = findHand(trainMHIs(:,:,i,j));
                    figure('Name',sprintf('Train Seq: %d-%d',i,j),'NumberTitle','off')
                    imshow(trainMHIs(:,:,i,j)/max(max(trainMHIs(:,:,i,j))))
                    hold on
                    plot([minX minX maxX maxX minX], [minY maxY maxY minY minY], 'Color', 'Red', 'LineWidth', 3);
                    hold off
                end
                % Create and store property vectors
                trainProps(:,:,i,j) = getproperties(trainMHIs(:,:,i,j));
            end
        end
    end
	
	% Randomly partition training data into 8 sets
	trainSets = split8(trainLocs, splitType);
	
	% If test set provided initialise an array to store all of the likelihoods so they can be combined
	if ~selfTest
		if likeType == 1
			totalRockLike = ones(dTstSeqs(1),1);
			totalPaperLike = ones(dTstSeqs(1),1);
			totalScissorsLike = ones(dTstSeqs(1),1);
		else
			totalRockLike = zeros(dTstSeqs(1),1);
			totalPaperLike = zeros(dTstSeqs(1),1);
			totalScissorsLike = zeros(dTstSeqs(1),1);		
		end
	end

    % Work through each fold
	for fold = 1:8
	    % If classifying the left out fold then store it's properties in the test variables
		if selfTest
			testLocs = trainSets(:,fold);
			testProps = [];
			for i = 1:length(testLocs)
				seq = getSeqFromLoc(trainLabs, testLocs(i));
				testProps = [testProps; trainProps(:,:,seq(1),seq(2))];
			end
		end

        foldTrainLocs = [trainSets(:,1:fold-1) trainSets(:,fold+1:end)];
		foldTrainLocs = foldTrainLocs(:);
		

        % separate the training properties into their types
		rockProps = [];
		paperProps = [];
		scissorsProps = [];
		
		for loc = foldTrainLocs'
			seq = getSeqFromLoc(trainLabs, loc);
			if (trainNums(seq(1),seq(2)) == 1)
				rockProps = [rockProps; trainProps(:,:,seq(1),seq(2))];
			elseif (trainNums(seq(1),seq(2)) == 2)
				paperProps = [paperProps; trainProps(:,:,seq(1),seq(2))];
			elseif (trainNums(seq(1),seq(2)) == 3)
				scissorsProps = [scissorsProps; trainProps(:,:,seq(1),seq(2))];
			end		
		end
		
		% get means and standard deviations for each type
		[rockMean rockSD] = getMeanSD(rockProps);
		[paperMean paperSD] = getMeanSD(paperProps);
		[scissorsMean scissorsSD] = getMeanSD(scissorsProps);

        
		dimTest = size(testProps);

		if ~selfTest
			rockLikes = [];
			paperLikes = [];
			scissorsLikes = [];
		end

        % classify each test set with Naive Bayes
		for testSet = 1:dimTest(1)
			rockLike = 1;
			paperLike = 1;
			scissorsLike = 1;
			
			% calculate likelihoods of each classification
			% priors assumed to be 1/3 so we have ignored them as they are equal
			for prop = 1:dimTest(2)
				rockLike = rockLike * gaussValue(rockMean(1,prop), rockSD(1,prop), testProps(testSet, prop));
				paperLike = paperLike * gaussValue(paperMean(1,prop), paperSD(1,prop), testProps(testSet, prop));
				scissorsLike = scissorsLike * gaussValue(scissorsMean(1,prop), scissorsSD(1,prop), testProps(testSet, prop));
			end
		
			if ~selfTest
				rockLikes = [rockLikes rockLike];
				paperLikes = [paperLikes paperLike];
				scissorsLikes = [scissorLikes scissorLike];			
			else
			    % give user results if testing against training data
				seq = getSeqFromLoc(trainLabs, testLocs(testSet,1));
				if (rockLike > paperLike) & (rockLike > scissorsLike)
					if trainNums(seq(1),seq(2)) == 1
						cor = 'Yes';
					else
						cor = 'No';
					end
					fprintf(['\nSequence: %d-%d Class: rock Correct: ' cor], seq(1), seq(2))
				elseif (paperLike > scissorsLike)
					if trainNums(seq(1),seq(2)) == 2
						cor = 'Yes';
					else
						cor = 'No';
					end
					fprintf(['\nSequence: %d-%d Class: paper Correct: ' cor], seq(1), seq(2))				
				else
					if trainNums(seq(1),seq(2)) == 3
						cor = 'Yes';
					else
						cor = 'No';
					end
					fprintf(['\nSequence: %d-%d Class: scissors Correct: ' cor], seq(1), seq(2))				
				end
			end
			if ~selfTest
				if likeType == 1
					totalRockLike = totalRockLike .* rockLikes;
					totalPaperLike = totalPaperLike .* PaperLikes;
					totalScissorsLike = totalScissorsLike .* scissorsLikes;
				else
					totalRockLike = totalRockLike + rockLikes;
					totalPaperLike = totalPaperLike + PaperLikes;
					totalScissorsLike = totalScissorsLike + scissorsLikes;
				end
			end			
		end
		
		% Give user results if test set has been provided
		if ~selfTest
			for i = 1:length(testLocs)
				if labelled
					if (totalRockLike(i,1) > totalPaperLike(i,1)) & (totalRockLike(i,1) > totalScissorsLike(i,1))
						if testNums(1,i) == 1
							cor = 'Yes';
						else
							cor = 'No';
						end
						fprintf(['\nSequence: %d Class: rock Correct: ' cor], i)
					elseif (totalPaperLike(i,1) > totalScissorsLike(i,1))
						if testNums(1,i) == 2
							cor = 'Yes';
						else
							cor = 'No';
						end
						fprintf(['\nSequence: %d Class: paper Correct: ' cor], i)				
					else
						if testNums(1,i) == 3
							cor = 'Yes';
						else
							cor = 'No';
						end
						fprintf(['\nSequence: %d Class: scissors Correct: ' cor], i)				
					end
				else
					if (totalRockLike(i,1) > totalPaperLike(i,1)) & (totalRockLike(i,1) > totalScissorsLike(i,1))
						fprintf('\nSequence: %d Class: rock', i)
					elseif (totalPaperLike(i,1) > totalScissorsLike(i,1))
						fprintf('\nSequence: %d Class: paper', i)				
					else
						fprintf('\nSequence: %d Class: scissors', i)				
					end				
				end
			end
		end
	end
