% Converts a matrix location referencing labels
% into a sequence identifier.
%
function [seq] = getSeqFromLoc(labels, loc)

    seq = [0,0];
    dim = size(labels);
    
    seq(2) = round(ceil(loc/dim(1)));
    seq(1) = round(((loc/dim(1))-floor(loc/dim(1)))*dim(1)+1);
