#Question3
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)
library(stringr)
library(tidyverse)
library(readtext)
#install.packages("wordcloud")
library(wordcloud)
#install.packages("RColorBrewer")
library(RColorBrewer)
#install.packages("wordcloud2")
library(wordcloud2)

dataset <- read.csv("C:/Dilip/Business Analytics/Semester 2/Customer analytics/Assignment2/tweets.csv",header = TRUE)
head(dataset$text)
dataset<-sum(is.na(dataset))
dataset<-dataset[duplicated(dataset),]

str(dataset)

dataset$text <- gsub("http[^[:space:]]*","'",dataset$text) #remove space
dataset$text = tolower(dataset$text) #lower case
dataset$text <- gsub("[[:digit:]]","'",dataset$text) #remove digits
dataset$text <- gsub("#\\s+","'",dataset$text) #remove hash
dataset$text <- gsub("@\\w+","'",dataset$text) #remove at
dataset$text <- gsub("(rt|via|amp)","'",dataset$text) #remove rt
dataset$text <- gsub("[^\u0001-\u007F]+|<U\\+\\w+>","'",dataset$text)
dataset$text <- gsub("^  ","'",dataset$text) #remove blanks
dataset$text <- gsub(" $","'",dataset$text) #remove blanks
#dataset$text <- gsub("[ |\t]{2,}","'",dataset$text)
#dataset$text <- gsub("[[:punct:]]","'",dataset$text)

view(dataset)

view(dataset)
require(quanteda)
require(readtext)

#question3.1
corp <- corpus(dataset,text_field = "text")
corp

remove_word <- c("is","the","are","a","will","get","now","just")

dtm <- dfm(corp,remove = c(stopwords("en"),remove_word),remove_numbers=T, remove_punct=T,remove_symbols=T)
dtm = dfm_trim(dtm,min_termfreq = 24 ) 


count <- textstat_frequency(dtm,n=25)

ggplot(count, aes(x=reorder(feature,frequency),y=frequency)) +
  geom_col() +
  coord_flip() +
  labs(x = "Count",
       y = "Unique words",
       title = "Count of unique words found in tweets") +
  theme_minimal()

#Question3.2
#wordcloud(dtm,random.order = F,max.words =40)
# Create a corpus  

textplot_wordcloud(dtm, random_order = F,max_words =40,color = rainbow(40),main="T")


library(tm)
bar_dtm <- DocumentTermMatrix(corp)
freq <- colSums(as.matrix(bar_dtm))
top_words <- head(sort(freq, decreasing = TRUE), 15)
top_words
barplot(top_words,main = "Top 15 Words in Twitter Feed", xlab = "Words", ylab = "Frequency")

#Question3.3
#dataset$hour <- as.factor(hour(dataset$date))
dataset$hour <- format(as.POSIXct(dataset$date),format = "%H")
dataset$hour<-as.numeric(dataset$hour)
view(dataset)
str(dataset)
dataset$Usage<- "Others"
dataset$Usage[dataset$hour >=6 & dataset$hour <=10] <- "Between"

ggplot(dataset, aes(x=hour,fill=Usage)) + geom_bar() +
  theme_minimal()

#Question3.4
library('lubridate')
library(tibble)
dataset$month <- month(dataset$date)
tweetcount <- table(dataset$month)
tweetcount

barplot(tweetcount, main="Number of Tweets per month",
        xlab="Months", ylab = "Number of Tweets")

#Question3.5
tweet_data2 <- dataset %>% 
  mutate(date_time = as_date(ymd_hms(date)))
regex_removal <- "&amp;|&lt;|&gt;|amp"
url_pattern <- "\\s?(f|ht)(tp)(s?)(://)([^\\.])[\\.|/](\\S*)"


library(janeaustenr)
library(remotes)
library(dplyr)
library(tidytext)

tweet_data <-dataset %>% 
  #filter(source %in% c("Twitter for iPhone")) %>%
  unnest_tokens(word, text, token = "words") %>%
  filter(!word %in% stop_words$word,
         !word %in% str_remove_all(stop_words$word, "'"),
         str_detect(word, "[a-z]")) %>%
  group_by(source,word) %>%
  count() %>%
  rename(word_count = n) %>%
  arrange(-word_count) #%>%
  #head(15) 

tweet_iphone <- filter(tweet_data,source %in% c("Twitter for iPhone"))
tweet_iphone<- tweet_iphone %>% head(15)
tweet_media_studio <- filter(tweet_data,source %in% c("Media Studio"))
tweet_media_studio <- tweet_media_studio %>% head(15)                       

ggplot(tweet_iphone, aes(x=reorder(word,word_count),y=word_count)) +
  geom_col(fill="Orange",width = 0.6)+ theme_bw()+
  coord_flip()+
  labs(x = "Count",
       y = "Words in Tweets",
       title = "Top 15 words in tweets for Iphone")

ggplot(tweet_media_studio, aes(x=reorder(word,word_count),y=word_count)) +
  geom_col(fill="Orange",width = 0.6)+ theme_bw()+
  coord_flip()+
  labs(x = "Count",
       y = "Words in Tweets",
       title = "Top 15 words in tweets for Iphone")

#Question3.6
first_six <-dataset %>% 
  unnest_tokens(word, text, token = "words") %>%
  filter(date >= as.Date("2018-03-01"), date <= as.Date("2018-09-01")) %>%
  filter(!word %in% stop_words$word,
         !word %in% str_remove_all(stop_words$word, "'"),
         str_detect(word, "[a-z]")) %>%
  group_by(word) %>%
  count(word, sort = TRUE)
  count() %>%
  rename(word_count = n) %>%
  arrange(-word_count)

last_six <-dataset %>% 
  unnest_tokens(word, text, token = "words") %>%
  filter(date >= as.Date("2017-01-20"), date <= as.Date("2017-06-20")) %>%
  filter(!word %in% stop_words$word,
         !word %in% str_remove_all(stop_words$word, "'"),
         str_detect(word, "[a-z]")) %>%
  group_by(word) %>%
  count(word, sort = TRUE)
  count() %>%
  rename(word_count = n) %>%
  arrange(-word_count)

Final_words<-first_six %>%
  filter(!word %in% last_six) %>% head(6)
