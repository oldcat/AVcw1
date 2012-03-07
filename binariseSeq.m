% Binarises an image by looking for largest continuous area with
% intensity greater than 0.1 in given difference image
%
function [binSeq] = binariseSeq(seq, backNum, path)

    if nargin == 1
        path = '~/AV/train/';
        backNum = 1;
    elseif nargin == 2
        path = '~/AV/train/';
    end

    if path(end) ~= '/'
        path = [path '/'];
    end
    
    if((backNum > 2) | (backNum < 1))
        error('ERROR: backNumground can only be 1 or 2');
    end
    
    back = imread(['background' int2str(backNum) '.jpg'],'jpg');
    
    files = listFiles(seq,path);
    
    num = size(files);
    dim = size(back);
    binSeq = zeros(dim(1),dim(2),num(1));
    
    for i = 1:num(1)
        fore = imread(files(i,:),'jpg');
        diff = abs(fore-back);
        binIm = binariseIm(diff);
        binSeq(:,:,i) = binIm;
        %figure(i+24)
        %imshow(binIm);
    end
    
    
