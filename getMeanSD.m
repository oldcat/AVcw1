% get the means and standard deviations of data sets.
% Each feature should be a collumn in the data matrix.
%
function [means, sds] = getMeanSD(data)

	dim = size(data);
	
	means = zeros(1,dim(2));
	for i=1:dim(1)
		means = means + data(i,:);
	end
	means = means/dim(1);
	
	sds = zeros(1,dim(2));
	for i=1:dim(1)
		sds = sds + ((data(i,:)-means) .* (data(i,:)-means));
	end
	sds = sqrt(sds/dim(1));
