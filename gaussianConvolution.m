function [ num ] = gaussianConvolution( num, p, variance, min, max )
%GAUSSIANCONVOLUTION Summary of this function goes here
%   Detailed explanation goes here

if p >= rand(1)
    n = -Inf;
    while not(min <= num + n && num + n <= max)
        n = sqrt(variance) * randn(1);
    end
    num = num + n;
end

end

