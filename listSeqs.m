% Lists the sequences found at a path, should be of the form 'x-y' or 'x'
% where x and y are integers
% 
function [seqList] = listSeqs(path)
      
    if nargin == 0
        path = '~/AV/train/';
    end  
      
    if path(end) ~= '/'
        path = [path '/'];
    end
    
    folderStruct = dir(path);
    folders = struct2cell(folderStruct);
    folders = char(folders(1,3:end));

    num = size(folders);
    seqList = [];    

    for i = 1:num(1)
        seq = [];
        name = folders(i,:);
		isDash = (name == '-');
		dashPos = find(isDash,1);
		if isempty(dashPos)
			seq = str2num(name);
		else
			seq = str2num(name(1:dashPos-1));
			seq = [seq str2num(name(dashPos+1:end))];
		end
		seqList = [seqList; seq];
	end
