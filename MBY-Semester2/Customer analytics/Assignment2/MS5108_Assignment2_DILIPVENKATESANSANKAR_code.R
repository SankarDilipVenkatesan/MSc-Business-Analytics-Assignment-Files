############################################################
##Title: Individual Assignment 2                           #
##Module Name and Code: Applied Customer Analytics MS5108  #
#Student Name and ID:  Dilip Venkatesan Sankar 22225743    #
############################################################

#Question1
#Dataset -> https://data.gov.ie/dataset/latest-buoy-reports-for-m6?package_type=dataset

#Reading the dataset as csv file
dataset <- read.csv("C:/Dilip/Business Analytics/Semester 2/Customer analytics/Assignment2/wind_dataset.csv",header = TRUE)

#checking the datatype and changing them to numeric to perform calculations
str(dataset)
dataset$pressure <- as.numeric(dataset$pressure)
dataset$humidity <- as.numeric(dataset$humidity)
dataset$windDir <- as.numeric(dataset$windDir)
dataset$windSpeed <- as.numeric(dataset$windSpeed)


#Checking the Summary to obtain min and max in order to fix breaks
summary(dataset$pressure)
up_break <- seq(1029,1034,by = 0.5)

#Question1 - A
#R base graphics -> Plotting Histogram with labels and titles
hist(dataset$pressure,main="Sea Level Pressure in Ireland for last 26 hrs",xlab = "Pressure",breaks = up_break,col = "lightblue")

#############################################################################################################################################################

#Question1 - B
#GGPLOT2 -> Importing library and plotting ggplot histogram
library("ggplot2")
ggplot(dataset) + geom_histogram(aes(x=pressure), breaks =seq(1029,1034, by =0.5),
          color='black', fill='lightblue')+
          labs(title="Sea Level Pressure in Ireland for last 26 hrs", x="Pressure", y="Frequency")

#############################################################################################################################################################

#Question1 - C
#R base graphics -> Scatter plot 
plot1<- plot(dataset$windDir,dataset$windSpeed,main = "Wind Speed Vs Wind Direction",
     xlab = "Wind Direction in degrees", ylab = "Wind Speed in km/hr",pch=19,frame=TRUE ) 

#Adding a regression line to check the relationship between DV and IV's
plot2_abline <- plot1+ abline(lm(dataset$windSpeed~dataset$windDir),col= "blue")

#Adding losses fit for scatterplot smoothing
plot3_lowline <- plot2_abline + lines(lowess(dataset$windSpeed~dataset$windDir),col="red")

#Importing Car library for  enhanced scatter plot
library(car)
scatterplot(dataset$windSpeed~dataset$windDir, data=dataset,main = "Wind Speed Vs Wind Direction",xlab = "Wind Direction in degrees", ylab = "Wind Speed in km/hr")

#############################################################################################################################################################

#Question1 - D
#GGPLOT2 -> Scatter plot added with smoothing line,colors and legend
scatter_ggplot <- ggplot(dataset,aes(x=windDir,y=windSpeed)) + geom_point(aes(color = factor(seaTemp))) +labs(title="Wind Speed Vs Wind Direction in degrees", x="Wind Direction", y="Wind Speed in km/hr") +guides(col=guide_legend("Sea Temperature"))
scatter_ggplot  
scatter_ggplot + geom_smooth(method = 'lm')    

#############################################################################################################################################################################################################################################

#Question2
library(lubridate)
library(dygraphs)
library(xts)
library(lubridate)
require(graphics)
library(tidyverse)

#Question2 - A
#Reading the dataset as CSV file
input <- read.csv("C:/Dilip/Business Analytics/Semester 2/Customer analytics/Assignment2/client_analysis.csv",na.strings = "", header = TRUE)

#Data cleanup and numeric conversion
input$SmartBear <- as.numeric(gsub(",","",input$SmartBear))
input$Cisco     <- as.numeric(gsub(",","",input$Cisco    ))
input$Deloitte  <- as.numeric(gsub(",","",input$Deloitte ))
input$USB <- as.numeric(gsub(",","",input$USB))
input$Diligent  <- as.numeric(gsub(",","",input$Diligent ))
input$SAP <- as.numeric(gsub(",","",input$SAP))
input$Amazon    <- as.numeric(gsub(",","",input$Amazon   ))

#Time series plot shows individual plots and a single plot with all spending and platform
df <- ts(input[-1], start = 1, frequency = 1)
plot(df)

plot(df,xlab='Months', ylab= 'Customer spendings in Euros',xlim=c(1,12),ylim = c(60000,500000),main = 'Trend of Customer spendings from Month to Month',
     plot.type="single", col = 1:ncol(df),log='y')
legend("bottomleft", colnames(df), col=1:ncol(dataset), lty=1, cex=.50)

#############################################################################################################################################################

#Question2 - B
library(reshape2)
library(ggplot2)
library(gghighlight)
library(xts)
library(lubridate)
library(lubridate)

#plotting time series using ggplot, geom_line and geom_point
#Metling the dataset month wise
data_final <- melt(input,"Month")
data_final
data_final$Month <- factor(data_final$Month, levels = unique(data_final$Month))
ggplot(data_final,aes(x = Month,y = log10(value),
                      col = variable,group = variable)) +
  geom_point(size = 1,alpha=0.2) +geom_line(alpha=0.28) +
  geom_line(data = subset(data_final,variable == 'Amazon'),size=1, linetype='dashed',alpha=1)+
  geom_line(data = subset(data_final,variable == 'SAP'),size=1, linetype='dashed',alpha=1)+
  scale_y_log10() +theme_minimal() +labs(title="Trend of Customer spendings from Month to Month", x="Months", y="Customer spendings in Euros")

#dygraphs created with more functionalities

dygraph(input,main = "Trend of Customer spendings from Month to Month")%>%
  dyOptions(fillAlpha=0.1,drawGrid=T,axisLineWidth = 1)%>%
  dyAxis("x", label = "Months",valueRange = c(1,12)) %>%
  dyAxis("y", label = "Customer spendings in Euros") %>%
  dyLegend(width=150)%>%
  dySeries("SmartBear", label = "SmartBear", color ='red',strokeWidth = 2) %>%
  dySeries("Cisco", color = "blue",strokeWidth = 2) %>%
  dySeries("Deloitte", color = "coral",strokeWidth = 2) %>%
  dySeries("USB", color = "black",strokeWidth = 2, strokePattern = "dashed") %>%
  dySeries("Diligent", color = "navy",strokeWidth = 2) %>%
  dySeries("SAP", color = "green",strokeWidth = 2)%>%
  dySeries("Amazon", color = "green",strokeWidth = 2)%>%
  dyHighlight(highlightCircleSize = 3, highlightSeriesBackgroundAlpha = 0.3)%>% 
  dyRangeSelector(strokeColor = "pink")

#############################################################################################################################################################################################################################################

#Question3
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)
library(stringr)
library(tidyverse)
library(readtext)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
require(quanteda)
require(readtext)
library(lubridate)
library(tibble)
library(janeaustenr)
library(remotes)
library(dplyr)
library(tidytext)

#Importing dataset as CSV
dataset <- read.csv("C:/Dilip/Business Analytics/Semester 2/Customer analytics/Assignment2/tweets.csv",header = TRUE)

#Dataset preprocessing and cleanup
dataset$text <- gsub("http[^[:space:]]*","'",dataset$text) #remove space
dataset$text = tolower(dataset$text) #lower case
dataset$text <- gsub("[[:digit:]]","'",dataset$text) #remove digits
dataset$text <- gsub("#\\s+","'",dataset$text) #remove hash
dataset$text <- gsub("@\\w+","'",dataset$text) #remove at
dataset$text <- gsub("(rt|via|amp)","'",dataset$text) #remove rt
dataset$text <- gsub("[^\u0001-\u007F]+|<U\\+\\w+>","'",dataset$text)
dataset$text <- gsub("^  ","'",dataset$text) #remove blanks
dataset$text <- gsub(" $","'",dataset$text) #remove blanks

#Question3 - A
#Corpus Creation 
corp_value <- corpus(dataset,text_field = "text")

#Vector for stop words
remove_word <- c("is","the","are","a","will","get","now","just")

#Converting to document term matrix, removing stop words and special characters
final_dtm <- dfm(corp_value,remove = c(stopwords("en"),remove_word),remove_numbers=T, remove_punct=T,remove_symbols=T)
 
#Filtering top 25 words
freq_count <- textstat_frequency(final_dtm,n=25)

#GGPLOT for frequency plot of top 25 words in tweet
ggplot(freq_count, aes(x=reorder(feature,frequency),y=frequency)) +geom_col(color="white", fill='lightblue') +coord_flip() +labs(y = "Count of words",x = "Words in Tweets",title = "Frequency count of Top 25 words") +theme_minimal()

#############################################################################################################################################################

#Question3 - B
#WordCould of 40 most common words 
textplot_wordcloud(final_dtm, random_order = F,max_words =40,color = rainbow(40),main="T")

#############################################################################################################################################################

#Question3 - C
#Social media usage between 6-10AM using number of tweets
#Segregating hour from the date column and converting to numeric
dataset$hour <- format(as.POSIXct(dataset$date),format = "%H")
dataset$hour<-as.numeric(dataset$hour)

#Assigning keywords based on 6-10AM usage
dataset$Usage<- "Other times"
dataset$Usage[dataset$hour >=6 & dataset$hour <=10] <- "Between 6-10AM"

#GGPLOT to view the usage
ggplot(dataset, aes(x=hour,fill=Usage)) + geom_bar() +labs(x='Hours',y='Usage')+ggtitle('Social media during breakfast time (6-10 AM)')+theme_minimal()

#Question3 - D
#Per month social medial usage
#extracting month from the date column in dataset
dataset$month <- month(dataset$date)

#Converting to table format for input to barplot
NumOftweets <- table(dataset$month)

#bar plot for social media monthly usage
barplot(NumOftweets, main="Social media usage per month",xlab="Months", ylab = "Number of Tweets",names.arg = c('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'),col = "lightblue")

#############################################################################################################################################################

#Question3 - E
#Top-15 words for source=’iPhone’ and source=’Media Studio using tidyverse
#Adding stop words
remove_word <- tibble(word=c(stopwords("en")))

#using unnest for creating filtering words from source and group the source and word to get count
data1 <- dataset %>% 
  unnest_tokens(word, text, token = "words")
data2 <- data1 %>% 
  anti_join(remove_word) %>% 
  group_by(source,word) %>% 
  count() %>%
  rename(word_count = n) %>% 
  arrange(-word_count)

#filtering based on source
tweet_iphone <- filter(data2,source %in% c("Twitter for iPhone"))
tweet_iphone<- tweet_iphone %>% head(15)
tweet_media_studio <- filter(data2,source %in% c("Media Studio"))
tweet_media_studio <- tweet_media_studio %>% head(15)                       

#ggplot for iphone and media studio to plot top 15 words
ggplot(tweet_iphone, aes(x=reorder(word,word_count),y=word_count)) +
  geom_col(fill="lightblue",width = 0.7,color='black')+ theme_bw()+
  coord_flip()+
  labs(x = "Words",
       y = "Count of Words",
       title = "Top 15 words in tweets for Iphone")

ggplot(tweet_media_studio, aes(x=reorder(word,word_count),y=word_count)) +
  geom_col(fill="Orange",width = 0.7,color='black')+ theme_bw()+
  coord_flip()+
  labs(x = "Words",
       y = "Count of Words",
       title = "Top 15 words in tweets for Media Studio")

#############################################################################################################################################################

#Question3 - F
#Adding stop words
remove_word <- tibble(word=c(stopwords("en")))

#using unnest for creating filtering words from source and group the source and word to get count
data1 <- dataset %>% 
  unnest_tokens(word, text, token = "words")

#words used in the first six months
last_six <- data1 %>% 
  anti_join(remove_word) %>%
  filter(date >= as.Date("2018-03-01"), date <= as.Date("2018-09-01")) %>%
  group_by(word) %>%
  count() %>%
  rename(word_count = n) %>%
  arrange(-word_count) 

#words used in the last six months
first_six <- data1 %>% 
  anti_join(remove_word) %>%
  filter(date >= as.Date("2017-01-20"), date <= as.Date("2017-06-20")) %>%
  group_by(word) %>%
  count() %>%
  rename(word_count = n) %>%
  arrange(-word_count)

#six words used in last six months of the data but were frequently used in the first six months
full <- first_six %>% full_join(last_six, by="word")
filter_words <- full %>% filter(is.na(word_count.y)) %>% arrange(desc(word_count.x)) %>% head(6)

abc <- filter_words %>% select(word,word_count.x)
names(abc)[2] <- 'Frequency'
view(abc)

#############################################################################################################################################################