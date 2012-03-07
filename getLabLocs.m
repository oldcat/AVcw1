% Takes the label nubers from getLabNum and converts to a matrix of locations.
% Each collumn is a classification.
%
function [labLocs] = getLabLocs(labNums)
    
    dim = size(labNums);
    maxLab = max(max(labNums));
    
    labLocs = [];
    
    for i = 1:maxLab
        labs = find(labNums == i);
        for j = 1:length(labs)
            labLocs(j,i) = labs(j);
        end
    end
    
    labLocs = labLocs - double(labLocs == 0);
