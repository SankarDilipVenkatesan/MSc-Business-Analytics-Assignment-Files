#Assignment2
#https://data.gov.ie/dataset/housing-social-housing-2009-2016-fcc?package_type=dataset
dataset <- read.csv("C:/Dilip/Business Analytics/Semester 2/Customer analytics/Assignment2/client_analysis.csv",header = TRUE)
head(dataset)

str(dataset)

install.packages("gghighlight")
install.packages("xts")
library(xts)
dataset$SmartBear<-as.numeric(gsub(",","",dataset$SmartBear))
dataset$Cisco<-as.numeric(gsub(",","",dataset$Cisco))
dataset$Deloitte<-as.numeric(gsub(",","",dataset$Deloitte))
dataset$USB<-as.numeric(gsub(",","",dataset$USB))
dataset$Diligent<-as.numeric(gsub(",","",dataset$Diligent))
dataset$SAP<-as.numeric(gsub(",","",dataset$SAP))
dataset$Amazon<-as.numeric(gsub(",","",dataset$Amazon))

ts.plot(dataset, col=2:8,xlab="Years",ylab="Spendings",main="Customer Spendings")
color<-rainbow(ncol(dataset[2:8]))
legend("topleft", colnames(dataset[2:8]),lty=1, col=color,cex = 0.55)

library("reshape2")
library(ggplot2)
library(gghighlight)

data_final <- melt(dataset,"Month")
data_final
data_final$Month <- factor(data_final$Month, levels = unique(data_final$Month))
ggplot(data_final,                           
       aes(x = Month,
           y = log10(value),
           col = variable,
           group = variable)) +
  geom_point(size = 1,alpha=0.2) +
  geom_line(alpha=0.2) +
  geom_line(data = subset(data_final,variable == 'Amazon'),size=1, linetype='dashed', color='red',alpha=3)+
  geom_line(data = subset(data_final,variable == 'SAP'),size=1, linetype='dashed', color='blue')+
  
  scale_y_log10() +
theme_minimal()

ggplot(data_final,                           
       aes(x = Month,
           y = log10(value),
           col = variable,
           group = variable)) +
  geom_point(size = 2) +
  geom_line() +
  scale_y_log10() +
  theme_minimal()+ facet_wrap(~variable) +
  scale_x_discrete(labels = seq(1,12), breaks = seq(1,12,1)) + labs(x = "Months") +
  labs(y="Spendings")

########################################################################3
#Question2-a
dataset <- read.csv("C:/Dilip/Business Analytics/Semester 2/Customer analytics/Assignment2/client_analysis.csv",na.strings = "")
head(dataset)

set.seed(1)
df <- ts(dataset[-1], start = 1, frequency = 1)
df
plot(df)

plot(df, plot.type="single", col = 1:ncol(df))
legend("bottomleft", colnames(df), col=1:ncol(dataset), lty=1, cex=.65)












