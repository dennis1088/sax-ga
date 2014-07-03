function [ num ] = gaussianConvolution( num, p, variance, min, max, isInteger )
%GAUSSIANCONVOLUTION Summary of this function goes here
%   Detailed explanation goes here

if p >= rand(1)
    n = -Inf;
    while not(min <= num + n && num + n <= max)
        if isInteger
            n = randi(3) - 2;
        else
            n = sqrt(variance) * randn(1);
        end
        n = sqrt(variance) * randn(1);
    end
    num = num + n;
end

end

