% Function takes a cell array of labels and numbers.
%
%   1 = Rock
%   2 = Paper
%   3 = Scissors
%
function [nums] = getLabels(labels)
      
    titles = {'rock'; 'paper'; 'scissors'};
      
    dim = size(labels);
    nums = zeros(dim)-1;

    for r = 1:dim(1)
        for c = 1:dim(2)
            for i = 1:length(titles)
                if length(labels{r,c}) == length(titles{i}) & labels{r,c} == titles{i}
                    nums(r,c) = i;
                    break;
                end
            end               
        end
    end
