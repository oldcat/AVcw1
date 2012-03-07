function [means, sds] = getMeanSD(data)

	size = dim(data);
	
	means = zeros(dim(2));
	for i=1:dim(1)
		means = means + data(i,:);
	end
	means = means/dim(1);
	
	sds = zeroes(dim(2));
	for i=1:dim(1)
		sds = sds + ((data-means) .* (data-means));
	end
	sds = sqrt(sds/dim(1));