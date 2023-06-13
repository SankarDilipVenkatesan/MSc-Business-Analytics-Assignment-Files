############################################################
##Title: Individual Assignment 3                           #
##Module Name and Code: Applied Customer Analytics MS5108  #
#Student Name and ID:  Dilip Venkatesan Sankar 22225743    #
############################################################

#Reading the dataset as csv file
dataset <- read.csv("C:/Dilip/Business Analytics/Semester 2/Customer analytics/Assignment3/Crossfit-Ridgeline-DataSet.csv",header = TRUE,na.strings=c("", "NA"))

#checking the class type and datatype
class(dataset)
str(dataset)

#data cleansing and preparation 
#library(tidyverse)
dataset[dataset==""] <- NA
dataset_clean <-na.omit(dataset)

#The clean dataset after removing NA/NULL we have 106 rows and 24 columns and is stored in dataset_clean
#view(dataset_clean) 

#####################################################################################################################################

#Question1 - Basic box plot 
#Checking the Summary to obtain min and max in order to fix breaks for age group
summary(dataset_clean$Age)
age_group <- cut(dataset_clean$Age, breaks=c(0,30,65), labels=c("<30","30+"))

#Verifying if grouping has done successfully based on age<30 and age>30
dataset_clean$Age[1:5]
age_group[1:5]

#Syntax to generate Boxplot with axis labels and legend
#Boxplot created for 2 age groups: Age <30, Age >30 with respect to Male and Female
boxplot(Membership.Tenure ~ Gender*age_group,data=dataset_clean,
        main="Boxplot for Membership Tenure Vs Gender and Age",
        names=c("M:<30","F:<30","M:30+","F:30+"),
        ylab="Membership Tenure",
        xlab="Gender",
        col=c("lightBlue","lightgreen"),
        border="black",
        las=1)
legend("topright", c("Male", "Female"), border="black", fill = c("lightblue", "lightgreen"))

#####################################################################################################################################

#Question2 - Histogram using GGPLOT2
#importing GGPLOT2 for visualization
library("ggplot2")

#Syntax to generate Histogram using GGPLOT2
#Histogram created to display the distribution of Age groups using Crossfit Ridgeline
#Histogram contains age of member in x-axis and count of members in y-axis
ggplot(dataset_clean) + geom_histogram(aes(x=dataset_clean$Age),
                                 color='black', fill='lightblue',bins = 15, binwidth = 2)+
  labs(title="Histogram for Age Distribution", x="Age of members", y="Count")

#####################################################################################################################################

#Question3 - Regression using on dependent variable and at least 3 independent variable
#dependent variable:
#1. Membership tenure

#independent variable:
#1. COASAT1(Friendliness and Courteous services by Coach)
#2. CLIM1(Comfortability around other gym members)
#3. COND6(Music loudness)

#importing necessary libraries to display the report of the model
library(report)

#Building a simple linear regression model
#The linear model is used to predict the gym membership based on the user feedback 
#and takes one dependent variable and three independent variable as input
linear_model <- lm(Membership.Tenure ~ COASAT1 + CLIM1 + COND6, 
                data = dataset_clean)

#Summary to produce the details of the model
#The summary of the linear model contains the residuals values, coefficients, error and statistical values
summary(linear_model)

#generate the report of the model
report(linear_model)

#Checking the normality
#Plotting histogram of the residuals to check the normality
#A Histogram without a  bell shaped curve indicates the residuals are not normally distributed
hist(linear_model$residuals,main='Histogram of Linear model',xlab='Residuals'
     ,ylab='Frequency')

#Normal Q-Q plot to check the normality pf residuals
#A S-shaped Q-Q plot typically denoted excess Kurtosis
plot(linear_model,2)

#Residuals Vs Fitted to verify the linearity property
plot(linear_model,1)

#Check normality using Kolmogorov-Smirnov test
ks.test(linear_model$residuals, "pnorm")
shapiro.test(linear_model$residuals)

#Scale-location to check the homoscedasticity of the residuals
plot(linear_model,3)

#Residuals Vs leverage to display Cook's distance with Outliers
plot(linear_model,5)

#Confidence intervals for model coefficients of intercept and slope 
confint(linear_model, conf.level=0.95)

#Variance inflation factor (VIF) score of the independent variable to check correlation
#Typically the value should be close to 1
library(car)
vif(linear_model)

#Anova-test to verify the significance 
#A value less than 0.05 indicates the Membership Tenure is significantly dependent on atleast on dependent variable
anova(linear_model, lm(Membership.Tenure ~ 1, data = dataset_clean))

#####################################################################################################################################

#Question4:
#Question3 - Regression using one dependent variable, one independent variable and one interacting variable
#dependent variable:
#1. CUSSAT3(Satisfaction level w.r.t service)

#independent variable:
#2. Gender

#interacting variable:
#3. CLIM3(Atmosphere at CrossFit Redgeline)

#importing library to check the performance of the models
library(performance)

#Building linear model without interacting variable
#Linear model to predict CLIM1 based on Gender so the model takes takes one independent variable and one dependent variable
lm_model1 <- lm(CLIM1 ~ Gender ,data = dataset_clean)

#Summary to produce the details of the GLM
#The summary display the residuals values, co-efficients, error and statistical values of the lm_model1
summary(lm_model1)

#generate the report of the GLM
report(lm_model1)

#Building R2 and model performance without interacting variable
#R2 is used to check the variance of dependent variable based on independent variable
r2(lm_model1)
model_performance(lm_model1)

#Building linear model with interacting variable
#Linear model to predict CLMI1 based on Gender and CLIM3 
#so the model takes one dependent variable, one independent and one interacting variable
lm_model2 <- lm(CLIM1 ~ Gender * COASAT4,data = dataset_clean)

#Summary to produce the details of the GLM
#The summary display the residuals values, co-efficients, error and statistical values of the lm_model2
summary(lm_model2)

#generate the report of the GLM
report(lm_model2)

#Building r2 and model performance with interacting variable
r2(lm_model2)
model_performance(lm_model2)

#Model comparison with rank true to arrange based on better model and verbose false to eliminate error values
#A model is better performance-score and lower RMSE indicates a better model for prediction
compare_performance(lm_model1,lm_model2,rank = T,verbose = F)

#model plotting
plot(compare_performance(lm_model1,lm_model2,rank = T, verbose = F))

#Checking significance using anova test on linear model2 with better prediction statistics
#The significance of COASAT4 and Gender:COASAT4 is < 0.05 
summary(aov(lm_model2))
  
#####################################################################################################################################