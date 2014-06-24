function [ distance ] = dist( pPattern, qPattern )
%DIST Summary of this function goes here
%   Detailed explanation goes here

distance = sqrt(sum((pPattern - qPattern).^2));
end

