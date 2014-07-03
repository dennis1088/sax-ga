function [ earnings ] = earningsOnInvestment( decisionParameters, closingPrices, ...
    windowSize, nSegments, alphabetSize )
%EARNINGSONINVESTMENT Summary of this function goes here
%   Detailed explanation goes here
stockBought = false;
balance = 0;
daysOfOwnership = 0;

distanceToBuy = decisionParameters{1};
distanceToSell = decisionParameters{2};
daysToSell = decisionParameters{3};
distanceMeasure = decisionParameters{4};
pattern = cell2mat(decisionParameters(5:end));

nDataPoints = size(closingPrices,1);
nSequences = nDataPoints - windowSize;

% Preform sax reduction on sliding window of time series.
for i=1:nSequences
    saxSequence = reduceToSax(closingPrices(i:i+windowSize-1)...
        ,nSegments, alphabetSize);
    distance = 0;
    if distanceMeasure
        distance = mindist(pattern, saxSequence, alphabetSize, windowSize);
    else
        distance = dist(pattern, saxSequence);
    end
    
    if daysOfOwnership >= daysToSell && stockBought
        stockBought = false;
        balance = balance + closingPrices(i + windowSize - 1);
        daysOfOwnership = 0;
    elseif ~stockBought && distance < distanceToBuy
        stockBought = true;
        balance = balance - closingPrices(i + windowSize - 1);
        daysOfOwnership = 1;
    elseif distance > distanceToSell && stockBought
        stockBought = false;
        balance = balance + closingPrices(i + windowSize - 1);
        daysOfOwnership = 0;
    elseif stockBought
        daysOfOwnership = daysOfOwnership + 1;
    end
    
end

earnings = balance;
if stockBought
    earnings = earnings + closingPrices(end);
end

end

