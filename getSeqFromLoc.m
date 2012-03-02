function [seq] = getSeqFromLoc(labels, loc)

    seq = [0,0];
    dim = size(labels);
    
    seq(2) = ceil(loc/dim(1));
    seq(1) = ((loc/dim(1))-floor(loc/dim(1)))*dim(1);
