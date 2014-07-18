function [ distance ] = mindist( pPattern, qPattern, alphabetSize, ...
    timeSeriesSize, breakpoints )
%MINDIST Summary of this function goes here
%   Detailed explanation goes here

% Calculate index for the reference to the alphabet breakpoints. Extract
% the breakpoints as an array.
%iBreakpoint = alphabetSize - 1;
%breakpoints = alphabetBreakpoints(1:iBreakpoint,iBreakpoint);

% Generate PAA coefficients distance look up table.
persistent distLookup;
if isempty(distLookup)
    distLookup = zeros(alphabetSize);
    for r=1:alphabetSize
        for c=1:alphabetSize
            if abs(r-c)>1
                distLookup(r,c) = breakpoints(max(r,c)-1) ...
                    - breakpoints(min(r,c));
            end
        end
    end
end

% Generate indices for the distance look up table from patterns and
% calculate the distance of both patterns.
%idistLookup = sub2ind(size(distLookup),pPattern-96,qPattern-96);
distSum = 0;
for i=1:size(pPattern,2)
    distSum = distSum + distLookup(pPattern(i)-96,qPattern(i)-96);
end

distance = sqrt(timeSeriesSize/size(pPattern,2)) * sqrt(distSum^2);

end

