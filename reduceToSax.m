function [ saxSequence ] = reduceToSax( timeSeries, nSegments, alphabetSize, alphabetBreakpoints )
%REDUCETOSAX Reduce a time series to its Symbolic Aggregate approXimation
%representation.
%   SAX allows a time series of arbitrary length n to be reduced to a
%   string of arbitrary length w, (w < n, typically w << n). The alphabet
%   size is also an arbitrary integer a, where a > 2.

segmentSize = size(timeSeries,1)/nSegments;

% Normalize time series using standard score and reduce dimensionality via
% Piecewise Aggregate Approximation.
%normalizedSeries = (timeSeries - mean(timeSeries)) ./ std(timeSeries);
normalizedSeries = zscore(timeSeries);
paaSequence = mean(reshape(normalizedSeries,segmentSize,nSegments));

% Calculate index for the reference to the alphabet breakpoints. Extract
% the breakpoints as an array.
iBreakpoint = alphabetSize - 1;
breakpoints = alphabetBreakpoints(1:iBreakpoint,iBreakpoint);

discreteSequence = char(1:nSegments);

% For each segment in the PAA sequence.
for i=1:numel(paaSequence)
    % Inequality returns a boolean array with the amount of breakpoints the
    % segment in question is larger than. The sum of the array is added
    % with 97 to get its char representation.
    charMapping = sum(breakpoints <= paaSequence(i)) + 97;
    discreteSequence(i) = charMapping;
end

saxSequence = discreteSequence;

end