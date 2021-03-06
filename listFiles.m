% Path passed to function is that of folder containing each set. Requires each set to be
% in a folder labled 'x-y' or 'x' where that is the name of the set and x and y are integers
%
function [fileList] = listFiles(sequence,path)

    if nargin == 1
        path = '~/AV/train/';
    end
    
    if path(end) ~= '/'
        path = [path '/'];
    end
    
    if path(end) ~= '/'
        path = [path '/'];
    end
    
    folderStruct = dir(path);
    folders = struct2cell(folderStruct);
    folders = folders(1,:);

    if (length(sequence) == 2)
        if sum(ismember(folders, sprintf('%d-%d',sequence(1),sequence(2))))
            fileListStruct = dir([path sprintf('%d-%d',sequence(1),sequence(2))]);
            fileList = struct2cell(fileListStruct);
            fileList = char(fileList(1,3:end));
        else
            error('ERROR: You have asked for a sequence that does not exist')
        end
    elseif (length(sequence == 1))
        if sum(ismember(folders, sprintf('%d',sequence)))
            fileListStruct = dir([path sprintf('%d',sequence)]);
            fileList = struct2cell(fileListStruct);
            fileList = char(fileList(1,3:end));
        else
            error('ERROR: You have asked for a sequence that does not exist')
        end
    else
        error('ERROR: Sequence invalid in listFiles')
    end

