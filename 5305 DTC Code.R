# 5305 DTC
library(readxl)
library(forcats)
library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(zoo)
library(urca)
library(tseries)
library(forecast)

# Load data

forecast_data<-read_excel("ch6_stock_index (1).xlsx")

forecast <- forecast_data %>% 
  select('Date','Close')



# TimeSeries doesn't like missing Data. Creating a monthly sum 

monthly <- forecast %>% 
  group_by(date=as.Date(as.yearmon(Date, "%m/%Y"))) %>% 
  summarise(month_average = mean(Close)) %>% 
  filter(date >= '2010-01-01')

# Descriptive Stats

summary(monthly)

# Fitting the Time Series

ts <- ts(monthly$month_average,frequency = 12, start = c(2010,1))
plot.ts(ts, col = 'blue',main= "NDX-100", ylab = "Index", xlab = "Month")

# In the first video, you need to find a time series data that interests you, is approximately stationary
# or can be made stationary, and has at least 100 observations. 
################################################################################
# Testing the Stationarity of the Data - Conduct ADF test 

adf.test(ts)

# The significant p-value suggest the ts is not stationary. Detrend the data by log difference

logts<-diff(log(ts))

# Plot the diff

plot(logts,main= "Stock Index- DIFF", ylab = "Index", xlab = "Month")

# Plot the ACF/ PACF

acf(logts)

# Gradually decreasing ACF suggest AR process

pacf(logts)

# Or we can do this to view all plot at the same time 

tsdisplay(logts)


# One significant spike in the PACF suggest AR(1)
################################################
#### First Model AR(1)

Ar1<-Arima(logts,c(1,0,0))

# Fitting the AR1 model
fitted_ts <- ts(fitted(Ar1), frequency = 12, start = c(2010,1))

# Plot and Compare with the Log-Ts
plot(logts)
lines(fitted_ts,col='green')

# Summary of the model 

summary(Ar1)

# The residual is suggesting that bigger than the P-Value ARIMA(1,0,0) model with non-zero mean is a good fit for data
checkresiduals(Ar1)


# PACF/ACF Plot of the Residual

ar_resid <- residuals(Ar1)
acf(ar_resid, main="ACF of residuals")
pacf(ar_resid, main="PACF of residuals")

# Get residuals from AR(2) model
ar_resid <- residuals(Ar2)
acf(ar_resid, main="ACF of residuals")
pacf(ar_resid, main="PACF of residuals")


# Creating Sub to test

# Plot 6 period ahead 
ts_sub<-monthly$month_average[1:154]

ts_sub <- ts(ts_sub,frequency = 12, start = c(2010,1))
logts_sub<-diff(log(ts_sub))


ts_sub_model_ar <-Arima(logts_sub,order=c(1,0,0))

# Make 6-month forecast
test_fct_ar<-forecast(ts_sub_model_ar,h=6)

# Plot the test and real-data
plot(test_fct_ar,12)
lines(logts,col='red')


# 6-Month Output
print(test_fct_ar$mean)

# Plot of the forecast
ar_forecast <- forecast(Ar1, h = 6)
plot(ar_forecast, include = 12)

#########################
########## Model 2

# MA(1) Model 

MA1<-Arima(logts,c(0,0,1))

# Fitting the AR2 model
MA1_fit <- ts(fitted(MA1), frequency = 12, start = c(2010,1))

# Plot the Ts

plot(logts)
lines(MA1_fit,col='green')

#Check the summary

summary(MA1)
checkresiduals(MA1)


# Get residuals from MA(1) model and Plot PACF ACF
ma_resid <- residuals(MA1)
acf(ma_resid, main="ACF of residuals")
pacf(ma_resid, main="PACF of residuals")

# Plot 6 period ahead 

ts_sub_model_ar <-Arima(logts_sub,order=c(0,0,1))


test_fct_ar<-forecast(ts_sub_model_ar,h=6)
plot(test_fct_ar,12)
lines(logts,col='red')


ar_forecast <- forecast(MA1, h = 6)
plot(ar_forecast, include = 12)


# Missing one model



# Based on the ACF and PACF, you will choose three linear models (MA, AR, or ARMA) and estimate them.


# You will present the estimation results, show the ACF and PACF correlograms of residuals from
# each specification, and verify they are white noise using Q-Test. 



# You will summarize all the model estimation and evaluation in a table 
# (refere to table 8.2 on page 214 in your textbook) and make asix-month ahead forecast. 


# You will plot the multistep of forecasts and their correspondence bands
#for each specification and comment on your preferred model and why. 


# Please name your video, Group <#> Final Project - Step1.


