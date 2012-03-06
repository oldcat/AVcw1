function [dist] = distance(v1, v2, distMeas)

    len1 = length(v1);
    len2 = length(v2);    
    
    if(len1 ~= len2)
        fprintf('v1: [');
        for i = 1:len1-1
            fprintf('%4.2f, ', v1(i));
        end
        fprintf('%4.2f]\n', v1(len1));
        fprintf('v2: [');
        for i = 1:len2-1
            fprintf('%4.2f, ', v2(i));
        end
        fprintf('%4.2f]\n', v2(len2));        
        error('ERROR: Trying to calculate distance between vectors of uneven length');
    end

    if distMeas == 1
        %Euclidean Distance
        dist = 0;
        for i = 1:len1
            dist = dist + (v1(i)-v2(i))^2;
        end
        dist = sqrt(dist);
        
    elseif distMeas == 2
        %Manhattan Distance
        dist = sum(abs(v1-v2));

    elseif distMeas == 3
        %Mahalanobis Distance
        dist = sqrt((v1-v2)*inv(cov([[v1];[v2]]))*(v1-v2)');

    else
        error('ERROR: Distance measure must be 1-3. 1=Euclidean, 2=Manhattan, 3=Mahanlobis.')
    end


%    if (distMeas = 1) % Euclidean distance
        
