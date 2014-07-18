function [ num ] = gaussianConvolution( num, p, variance, min, max, isInteger )
%GAUSSIANCONVOLUTION Summary of this function goes here
%   Detailed explanation goes here

if p >= rand(1)
    n = -Inf;
    if isInteger
        n = randi(3) - 2;
        if not(min <= num + n && num + n <= max)
            n = -n;
        end
    else
        while not(min <= num + n && num + n <= max)
            n = sqrt(variance) * randn(1);
        end
    end
    num = num + n;
end

% if p >= rand(1)
%     n = -Inf;
%     if isInteger
%         n = randi(3) - 2;
%     else
%         n = sqrt(variance) * randn(1);
%     end
%     if num + n < max
%     num = num + n;
%     else
% end

end

