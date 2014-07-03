% Genetic algorithm parameters.
populationSize  = 100;
generations     = 500;

% SAX parameters.
windowSize      = 20;
wordSize        = 5;
alphabetSize    = 4;

% Mutation parameters.
mutationProb    = .1;
variance        = 1;


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
    populationFitness = zeros(1,populationSize);
    for individual=1:populationSize
        % Calculate individual fitness
        individualFitness = randi(100);
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
        
        % Mutate Children.
        child1{1} = gaussianConvolution(child1{1}, mutationProb,...
            variance, 0, maxDist, false);
        child1{2} = gaussianConvolution(child1{2}, mutationProb,...
            variance, 0, maxDist, false);
        child1{3} = gaussianConvolution(child1{3}, mutationProb,...
            variance, 0, maxDays, true);
        child1{4} = mutationProb > rand();
        
        
    end
    
end