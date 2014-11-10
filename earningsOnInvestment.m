function [ earnings, firstPurchasePrice] = earningsOnInvestment( decisionParameters, closingPrices, ...
    saxSequences, windowSize, nSegments, alphabetSize, alphabetBreakpoints )
%EARNINGSONINVESTMENT Summary of this function goes here
%   Detailed explanation goes here
stockBought = false;
balance = 0;
daysOfOwnership = 0;
firstPurchasePrice = -1;

distanceToBuy = decisionParameters{1};
distanceToSell = decisionParameters{2};
daysToSell = decisionParameters{3};
distanceMeasure = decisionParameters{4};
pattern = cell2mat(decisionParameters(5:end));
returnSchedule = zeros(size(saxSequences));

% Preform sax reduction on sliding window of time series.
for i=1:size(saxSequences)
    saxSequence = saxSequences{i};
    distance = 0;
    if distanceMeasure
        distance = mindist(pattern, saxSequence, alphabetSize, windowSize, alphabetBreakpoints);
    else
        distance = dist(pattern, saxSequence);
    end
    
    % selling
    if daysOfOwnership >= daysToSell && stockBought
        stockBought = false;
        balance = balance + closingPrices(i + windowSize - 1);
        daysOfOwnership = 0;
    % buy
    elseif ~stockBought && distance < distanceToBuy
        stockBought = true;
        balance = balance - closingPrices(i + windowSize - 1);
        daysOfOwnership = 1;
        if firstPurchasePrice == -1
            firstPurchasePrice = closingPrices(i + windowSize - 1);
        end
    % sell
    elseif distance > distanceToSell && stockBought
        stockBought = false;
        balance = balance + closingPrices(i + windowSize - 1);
        daysOfOwnership = 0;
    % keep
    elseif stockBought
        daysOfOwnership = daysOfOwnership + 1;
    end
    
    if firstPurchasePrice ~= -1
        saxEarning = balance;
        if stockBought
            saxEarning = saxEarning + closingPrices(i + windowSize - 1);
        end
        returnSchedule(i) = saxEarning/firstPurchasePrice;
    end
end

earnings = balance;
if stockBought
    earnings = earnings + closingPrices(end);
end

end

