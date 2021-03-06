% Function reads a labels file from expected location or from a given one and returns the labels.
%
function [labels] = getLabels(file)
    
    if nargin < 1
        file = '~/AV/train/labels';
    end
    
    fid = fopen(file,'r');
    InputText=textscan(fid,'%s','delimiter','\n'); % Read strings delimited by
    Intro=InputText{1};
    fclose(fid);	

    num = length(Intro);
    
    labels = {};

    for i = 2:num
    	st  = Intro{i};
    	dash = strfind(st,'-');
        tab = strfind(st,'	');
        if isempty(dash)
            seq = str2num(st(1:tab(1)-1));          
            labels(1,seq) = {st(1,tab(2)+1:end)};
        else
            seq1 = str2num(st(1:dash-1));
            seq2 = str2num(st(dash+1:tab(1)-1));
            labels(seq1,seq2) = {st(1,tab(2)+1:end)};
        end
    end
