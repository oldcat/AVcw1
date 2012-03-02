% Takes the label nubers from getLabNum and converts to a matrix of locations.
% Each collumn is a classification.
%
function [labLocs] = getLabLocs(labNums)
    
    
    dim = size(labNums);
    maxLab = max(max(labNums));
    
    labLocs = [];
    
    for i = 1:maxLab
        labLocs(:,i) = find(labNums == i);
    end
