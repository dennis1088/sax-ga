function [ child1, child2 ] = twoPointCrossover( parent1, parent2 )
%TWOPOINTCROSSOVER Summary of this function goes here
%   Detailed explanation goes here
parentSize = size(parent1,2);

% Create random indecees
c = randi(parentSize);
d = randi(parentSize);

% Swap indeccess
if c > d
    t = c;
    c = d;
    d = t;
end

% Swap values
for i=c:d-1
    t = parent1{i};
    parent1{i} = parent2{i};
    parent2{i} = t;
end

child1 = parent1;
child2 = parent2;
end

