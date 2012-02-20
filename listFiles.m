% Path passed to function is that of folder containing each set. Requires each set to be
% in a folder labled 'x-y' where that is the name of the set and x and y are integers
%
function [fileList] = listFiles(path,sequence)
    
    if(length(sequence) ~= 2)
        error('ERROR: You have asked for a sequence that is invalid, must be 2 digits')
    end
    
    if path(end) ~= '/'
        path = [path '/'];
    end
    
    folderStruct = dir(path);
    folders = struct2cell(folderStruct);
    folders = folders(1,:);

    if sum(ismember(folders, sprintf('%d-%d',sequence(1),sequence(2))))
        fileListStruct = dir([path sprintf('%d-%d',sequence(1),sequence(2))]);
        fileList = struct2cell(fileListStruct);
        fileList = char(fileList(1,3:end));
    else
        error('ERROR: You have asked for a sequence that does not exist')
    end

