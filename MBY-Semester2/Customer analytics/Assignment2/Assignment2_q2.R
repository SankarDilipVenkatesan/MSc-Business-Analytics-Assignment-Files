#Question2
library(lubridate)
library(dygraphs)
library(xts)
library(lubridate)
require(graphics)
library(tidyverse)

input <- read.csv("C:/Dilip/Business Analytics/Semester 2/Customer analytics/Assignment2/client_analysis.csv",na.strings = "", header = TRUE)
head(input)

str(input)
#cleanup data
#input$Month <- as.numeric(gsub(",","",input$Month))
input$SmartBear <- as.numeric(gsub(",","",input$SmartBear))
input$Cisco     <- as.numeric(gsub(",","",input$Cisco    ))
input$Deloitte  <- as.numeric(gsub(",","",input$Deloitte ))
input$USB <- as.numeric(gsub(",","",input$USB))
input$Diligent  <- as.numeric(gsub(",","",input$Diligent ))
input$SAP <- as.numeric(gsub(",","",input$SAP))
input$Amazon    <- as.numeric(gsub(",","",input$Amazon   ))

set.seed(1)
df <- ts(input[-1], start = 1, frequency = 1)
df
plot(df)

plot(df,xlab='Months', ylab= 'Customer spendings',xlim=c(1,12),ylim = c(60000,500000),main = 'Trend of Customer spendings from Month to Month',
     plot.type="single", col = 1:ncol(df),log='y')
legend("bottomleft", colnames(df), col=1:ncol(dataset), lty=1, cex=.50)




#partb

rate<-cbind(input$SmartBear,input$Amazon)
dygraph(rate)

numMonth <- function(x) {
  months <- list(january=1,february=2,march=3,april=4,may=5,june=6,july=7,august=8,
                 september=9,october=10,november=11,december=12)
  x <- tolower(x)
  sapply(x,function(x) months[[x]])
}

input$Month <- numMonth(input$Month)


dygraph(df,main = "Trend of Customer spendings from Month to Month")%>%
  dyOptions(fillAlpha=0.1,drawGrid=T,axisLineWidth = 1)%>% 
  dyRangeSelector(strokeColor = "pink")%>%
  dyAxis("y", label = "Months") %>%
  dyAxis("x", label = "Customer spendings in Euros",valueRange = c(1,12)) %>%
  dyLegend(width=150)%>%
  dySeries("SmartBear", label = "SmartBear",fillGraph = FALSE, color ='red',strokeWidth = 2) %>%
  dySeries("Cisco", fillGraph = FALSE, color = "blue",strokeWidth = 2) %>%
  dySeries("Deloitte",  fillGraph = FALSE, color = "coral",strokeWidth = 2) %>%
  dySeries("USB", fillGraph = FALSE, color = "black",strokeWidth = 2, strokePattern = "dashed") %>%
  dySeries("Diligent", fillGraph = FALSE, color = "navy",strokeWidth = 2) %>%
  dySeries("SAP", fillGraph = FALSE, color = "green",strokeWidth = 2)%>%
  dySeries("Amazon", fillGraph = FALSE, color = "green",strokeWidth = 2)%>%
  dyHighlight(highlightCircleSize = 3, 
              highlightSeriesBackgroundAlpha = 0.3)


