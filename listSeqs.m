% 
function [seqList] = listSeqs(path)
      
    if path(end) ~= '/'
        path = [path '/'];
    end
    
    folderStruct = dir(path);
    folders = struct2cell(folderStruct);
    folders = char(folders(1,3:end-1));

    num = length(folders);
    seqList = [];    

    for i = 1:num
        seq = [];
        name = folders(i,:);
        isDash = (name == '-');
        dashPos = find(isDash,1);
        seq = str2num(name(1:dashPos-1));
        seq = [seq str2num(name(dashPos+1:end))];
        seqList = [seqList; seq];
    end
