% Creates 8 sets of locations for training using one of two methods.
% Each set is a column of the output matrix.
%
function [sets] = split8(labLocs, method)

    if nargin < 2
    	method = 1;
    elseif(method < 1) | (method > 2)
		error('ERROR: Method of splitting data must be 1, fully random, or 2, random with one of each per set")
	end
    
    dim = size(labLocs);

    sets = zeros(ceil(dim(1)*dim(2)/8),8)-1;

    if method == 1 % method = 1 => fully random partitioning
        
        r = randperm(dim(1)*dim(2));
        for i = 1:dim(1)*dim(2)
            sets(i) = labLocs(r(i));
        end
        
    elseif method == 2  % each set must have at least one of each class
    
        for i = 1:dim(2)
             r = randperm(dim(1));
             for j = 1:dim(1)
                 sets(i,j) = labLocs(r(j),i);
             end
        end
    
    end
