# 5305 DTC
library(readxl)

# Load data
ch6_stock_index <- read_excel("data/ch6_stock_index.xlsx")
View(ch6_stock_index)

# In the first video, you need to find a time series data that interests you, is approximately stationary
# or can be made stationary, and has at least 100 observations. 



# You will perform in-sample evaluations
#by loading the data into RStudio, plotting the time series, and removing trend and seasonality when
# needed. 


# You will also stationarize the time series using first differencing when necessary. 


# Based on the ACF and PACF, you will choose three linear models (MA, AR, or ARMA) and estimate them.


# You will present the estimation results, show the ACF and PACF correlograms of residuals from
# each specification, and verify they are white noise using Q-Test. 



# You will summarize all the model estimation and evaluation in a table 
# (refere to table 8.2 on page 214 in your textbook) and make asix-month ahead forecast. 


# You will plot the multistep of forecasts and their correspondence bands
#for each specification and comment on your preferred model and why. 


# Please name your video, Group <#> Final Project - Step1.

