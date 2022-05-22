# Q1 analysis

# libraries
library(ggplot2)
library(dplyr)
library(wordcloud)
library(tm)
library(stringi)

# csv file -- change the file path here
q1 <-  read.csv('./UkraineConflictOnTwitter/SentimentAnalysis/data/q1/all_tweets_with_sentiment.csv')

## stacked bar plot ##

# convert string to datetime
q1$Date <- sub(" .*", "", q1$Date)
q1$Date <- as.Date(q1$Date, format="%Y-%m-%d", tz="UTC")

# create YearMonth column
q1$YearMonth <- substr(q1$Date, 1,7)

# create Week column
q1 <- q1 %>% 
  mutate(Week = cut.Date(q1$Date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(q1$Date)

# calculate percentage of sentiment by week
sentiment_by_week <- q1 %>%
  group_by(Week, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(Week)

# calculate percentage of sentiment by month
sentiment_by_month <- q1 %>%
  group_by(YearMonth, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(YearMonth)

# graph (by week)
ggplot(sentiment_by_week, aes(fill=label, y=freq, x=Week)) + 
  geom_bar(position='stack', stat='identity') +
  theme_minimal() + 
  theme(panel.background = element_blank()) +
  ggtitle("Average Sentiment of Tweets by Week") +
  labs(x='Week', y='Frequency') +
  theme(plot.title = element_text(hjust = 0.5, size=20, face='bold', margin = margin(t = 10, r = 0 , b = 10, l = 0))) +
  theme(axis.title.x = element_text(face='bold', size=15, margin = margin(t = 10, b = 10, r = 0, l = 0))) +
  theme(axis.title.y = element_text(face='bold', size=15, margin = margin(t = 0, b = 0, r = 10, l = 10))) +
  theme(axis.text.x = element_text(angle=30, size=13)) +
  theme(axis.text.y = element_text(size=13)) +
  theme(legend.title = element_text(face='bold', size=15)) +
  theme(legend.text = element_text(size=15)) +
  scale_x_continuous(breaks=c(1,11,16,23), labels=c("Dec 24th", "Feb 24th", "April 7th", "May 24th")) +
  scale_fill_manual('label', values=c('#d9534f', '#f0ad4e', '#5cb85c'))

# graph (by month)
ggplot(sentiment_by_month, aes(fill=label, y=freq, x=YearMonth)) + 
  geom_bar(position='stack', stat='identity') +
  theme_minimal() + 
  theme(panel.background = element_blank()) +
  ggtitle("Average Sentiment of Tweets by Month") +
  labs(x='Month', y='Frequency') +
  theme(plot.title = element_text(hjust = 0.5, size=20, face='bold', margin = margin(t = 10, r = 0 , b = 10, l = 0))) +
  theme(axis.title.x = element_text(face='bold', size=15, margin = margin(t = 10, b = 10, r = 0, l = 0))) +
  theme(axis.title.y = element_text(face='bold', size=15, margin = margin(t = 0, b = 0, r = 10, l = 10))) +
  theme(axis.text.x = element_text(angle=30, size=13)) +
  theme(axis.text.y = element_text(size=13)) +
  theme(legend.title = element_text(face='bold', size=15)) +
  theme(legend.text = element_text(size=15)) +
  scale_fill_manual('label', values=c('#d9534f', '#f0ad4e', '#5cb85c'))
