% Genetic algorithm parameters.
populationSize  = 100;
generations     = 500;

% SAX parameters.
windowSize      = 20;
wordSize        = 5;
alphabetSize    = 4;

load('alphabetBreakpoints.mat');

% Calculate index for the reference to the alphabet breakpoints. Extract
% the breakpoints as an array.
iBreakpoint = alphabetSize - 1;
breakpoints = alphabetBreakpoints(1:iBreakpoint,iBreakpoint);

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
    for individual=1:populationSize
        % Calculate individual fitness
        individualFitness = 0;
        
        % Record best individual
        if best(end) == -Inf || best(end) < individualFitness
            best = [population(individual,:), individualFitness];
        end
    end
    
    % Populate child population
end