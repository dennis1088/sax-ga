% Specify and open data file.
dataFileName = 'data/AAPL.csv';
dataFileID = fopen(dataFileName, 'rt');

% Read the formatted data from the file.
C = textscan(dataFileID, '%s %f %f %f %f %f %f', ...
    'Delimiter',',', 'CollectOutput',1, 'HeaderLines',1);

dates = C{1};
data = C{2};
fclose(dataFileID);
data = flipud(data);
dates = flipud(dates);

% Plot closing prices.
closingPrices = data(:,4);
ts = timeseries(closingPrices);
ts.Name = 'Daily Apple Stock Closing Price';
ts.DataInfo.Units = 'dollars';
ts.TimeInfo.Units = 'days';
ts.TimeInfo.StartDate='DEC-12-1980';
ts.TimeInfo.Format = 'mm/dd/yy';
plot(ts);

% Declare SAX Parameters.
windowSize = 80;
nSegments = 8;
alphabetSize = 4;

nDataPoints = size(data,1);
nSequences = nDataPoints - windowSize;
saxSequences = cell(nSequences,1);

% Preform sax reduction on sliding window of time series.
for i=1:nSequences
    saxSequences{i} = reduceToSax(closingPrices(i:i+windowSize-1)...
        ,nSegments, alphabetSize);
end

saxSequences
