function [distance] = euclidDist(point1, point2)

    len = length(point1);

    distance = 0;

    for i = 1:len
        distance = distance + (point1(i)-point2(i))^2;
    end
    
    distance = sqrt(distance);
