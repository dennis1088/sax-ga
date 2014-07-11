% Genetic algorithm parameters.
populationSize  = 100;
generations     = 1;

% SAX parameters.
windowSize      = 20;
wordSize        = 5;
alphabetSize    = 4;

% Mutation parameters.
mutationProb    = .1;
variance        = 1;

% Data file.
dataFileName = 'data/AAPL.csv';

% Open file and Read the formatted data from the file.
dataFileID = fopen(dataFileName, 'rt');
C = textscan(dataFileID, '%s %f %f %f %f %f %f', ...
    'Delimiter',',', 'CollectOutput',1, 'HeaderLines',1);
fclose(dataFileID);

data = flipud(C{2});
dates = flipud(C{1});
closingPrices = data(:,4);

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

% Calculate maximum values for decision paramters in chromosome.
maxSimpleDistance = alphabetSize-1;
maxDist = breakpoints(end) * 2;
maxMinDistance = sqrt(windowSize/wordSize)*sqrt(maxDist^2 * wordSize);
maxDays = 100; % This will be the number of days in the stock time series

chromosomeSize = wordSize + 4;
population = cell([populationSize chromosomeSize]);

% Generate random population
for i=1:populationSize
    population{i,1} = rand()*maxMinDistance;
    population{i,2} = rand()*maxMinDistance;
    population{i,3} = randi(maxDays);
    population{i,4} = .5 > rand();
    
    for iWord=1:wordSize
        population{i,iWord+4} = char(randi([97,97+alphabetSize-1]));
    end
end

best = [cell(1,chromosomeSize),-Inf];

for iGeneration = 1:generations
    populationFitness = zeros(1,populationSize);
    for individual=1:populationSize
        % Calculate individual fitness
        individualFitness = earningsOnInvestment( ...
            population(individual,:), closingPrices, saxSequences, ...
            windowSize, wordSize, alphabetSize, breakpoints);
        populationFitness(individual) = individualFitness;
        
        % Record best individual
        if best{end} == -Inf || best{end} < individualFitness
            best = [population(individual,:), individualFitness];
        end
    end
    
    % Get best half of population
    [populationFitness, iIndividuals] = sort(populationFitness, 'descend');
    bestHalfOfPopulation = population(iIndividuals(1:populationSize/2),:);
    
    children = cell([populationSize chromosomeSize]);
    
    % Populate child population
    for b=1:populationSize/2
        % Chose two parent randomly from best half of population.
        parent1 = bestHalfOfPopulation(randi(populationSize/2),:);
        parent2 = bestHalfOfPopulation(randi(populationSize/2),:);
        
        % Crossover parents.
        [child1, child2] = twoPointCrossover(parent1, parent2);
        
        originalChild = child1;
        
        % Mutate Children.
        child1{1} = gaussianConvolution(child1{1}, mutationProb,...
            variance, 0, maxDist, false);
        child1{2} = gaussianConvolution(child1{2}, mutationProb,...
            variance, 0, maxDist, false);
        child1{3} = gaussianConvolution(child1{3}, mutationProb,...
            variance, 0, maxDays, true);
        child1{4} = mutationProb > rand();
        for iWord=1:wordSize
            child1{iWord+4} = char(gaussianConvolution(child1{iWord+4}, ...
                mutationProb, variance, 97, 97+alphabetSize-1, true));
        end
        
        child2{1} = gaussianConvolution(child2{1}, mutationProb,...
            variance, 0, maxDist, false);
        child2{2} = gaussianConvolution(child2{2}, mutationProb,...
            variance, 0, maxDist, false);
        child2{3} = gaussianConvolution(child2{3}, mutationProb,...
            variance, 0, maxDays, true);
        child2{4} = mutationProb > rand();
        for iWord=1:wordSize
            child2{iWord+4} = char(gaussianConvolution(child2{iWord+4}, ...
                mutationProb, variance, 97, 97+alphabetSize-1, true));
        end
        
        children(b*2-1,:)   = child1;
        children(b*2,:)     = child2;
        
    end
    
    population = children;
    
end