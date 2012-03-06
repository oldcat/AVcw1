function [value] = gaussValue(mean, sigma, val)

    value = (1/(sigma*sqrt(2*pi)))*exp((-(val-mean)^2)/(2*sigma^2));
    
    

