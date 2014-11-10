% SAX parameters.
windowSize      = 10;
wordSize        = 2;
alphabetSize    = 7;

strategy = {2.92963360957959,4.89040628000013,3,0,'f','d'};

% Data file.
dataFileName = 'data/CAH_testing_2.csv';

% Open file and Read the formatted data from the file.
dataFileID = fopen(dataFileName, 'rt');
C = textscan(dataFileID, '%s %f %f %f %f %f %f', ...
    'Delimiter',',', 'CollectOutput',1, 'HeaderLines',1);
fclose(dataFileID);

data = flipud(C{2});
dates = flipud(C{1});
closingPrices = data(:,6);

load('alphabetBreakpoints.mat');

% Calculate index for the reference to the alphabet breakpoints. Extract
% the breakpoints as an array.
iBreakpoint = alphabetSize - 1;
breakpoints = alphabetBreakpoints(1:iBreakpoint,iBreakpoint);

nDataPoints = size(data,1);
nSequences = nDataPoints - windowSize;
saxSequences = cell(nSequences,1);

% Preform sax reduction on sliding window of time series.
for i=1:nSequences
    saxSequences{i} = reduceToSax(closingPrices(i:i+windowSize-1)...
        ,wordSize, alphabetSize, alphabetBreakpoints);
end

[profit, firstPurchasePrice] = earningsOnInvestment( ...
    strategy, closingPrices, saxSequences, ...
    windowSize, wordSize, alphabetSize, breakpoints);

roi = profit/firstPurchasePrice;
 