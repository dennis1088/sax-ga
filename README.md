Financial Time Series Prediction Using SAX-GA
=============================================

Manifest
--------

    ├── README.md
    ├── alphabetBreakpoints.mat
    ├── data
    │   ├── AAPL.csv
    │   └── ^GSPC.csv
    ├── main.m
    └── reduceToSax.m
    
README.md - This file describing files and code.

alphabetBreakpoints.mat - A matlab data file containing reference to breakpoints for the number of alphabets specified.

data - folder containing stock price data for several stocks.

AAPL.csv - Comma seperated file containing stock price information for Apple company stock.

^GSPC.csv - Comma seperated file containing stock price information for the S&P500 index.

main.m - Script file that coordinates the control of the entire program. Running this file in matlab will take stock information from the data files and display its SAX sequence patterns.

reduceToSax.m - Function file which converts a time series to an SAX pattern based on the paramters passed in.