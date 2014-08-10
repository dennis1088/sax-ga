Financial Time Series Prediction Using SAX-GA
=============================================

Manifest
--------

    ├── README.md
	├── alphabetBreakpoints.mat
	├── data
	│   ├── AAPL_testing.csv
	│   ├── AAPL_training.csv
	│   ├── CAH_testing.csv
	│   ├── CAH_training.csv
	│   ├── CI_testing.csv
	│   ├── CI_training.csv
	│   ├── CNL_testing.csv
	│   ├── CNL_training.csv
	│   ├── ESL_testing.csv
	│   ├── ESL_training.csv
	│   ├── GE_testing.csv
	│   ├── GE_training.csv
	│   ├── HIW_testing.csv
	│   ├── HIW_training.csv
	│   ├── WDC_testing.csv
	│   ├── WDC_training.csv
	│   ├── XOM_testing.csv
	│   └── XOM_training.csv
	├── dist.m
	├── earningsOnInvestment.m
	├── gaussianConvolution.m
	├── geneticAlgorithm.m
	├── main.m
	├── mindist.m
	├── reduceToSax.m
	├── results
	│   ├── apple_result_1.mat
	│   ├── apple_result_2.mat
	│   ├── cah_result_1.mat
	│   ├── ci_result_1.mat
	│   ├── cnl_result_1.mat
	│   ├── esl_result_1.mat
	│   ├── ge_result_1.mat
	│   ├── ge_result_2.mat
	│   ├── hiw_result_1.mat
	│   ├── wdc_result_1.mat
	│   └── xom_result_1.mat
	├── returnsOnTestData.m
	└── twoPointCrossover.m
    
README.md - This file describing files and code.

alphabetBreakpoints.mat - A matlab data file containing reference to breakpoints for the number of alphabets specified.

data - Folder containing stock price data for several stocks seperated into training and testing data.

dist.m - Simple distance method proposed in research.

earningsOnInvestment.m - Fitness function calculating the amount of earnings made based on individual.

gaussianConvolution.m - Function that preforms guassian convolution for mutation.

geneticAlgorithm.m - Script which runs the entire sequence to get the best pattern and decision paramters for a stock.

main.m - Script file that coordinates the control of the entire program. Running this file in matlab will take stock information from the data files and display its SAX sequence patterns.

mindist.m - A distance measure for the SAX pattern.

reduceToSax.m - Function file which converts a time series to an SAX pattern based on the paramters passed in.

results - Holds the results on experiements run.

returnsOnTestData.m - A utility that helps on running the investment strategy on test data.

twoPointCrossover.m - Function which preforms two point crossover on two individual.