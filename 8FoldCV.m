function [class] = 8FoldCV(trainPath, testPath)

	if isempty(testPath)
		selfTest = 1;
	else
		selfTest = 0;
	end
	
	trainSets = split8(train, splitType);
	
	getLabs(train);	
	
	for fold = 1:8
		if selfTest
			test = train(:,i);
		end
		
		for i = [1:(fold-1) (fold+1):8]
		    
        end
	end
