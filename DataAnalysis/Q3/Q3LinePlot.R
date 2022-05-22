library(ggplot2)
library(dplyr)

# csv file -- change the file path here
#q1 <-  read.csv('/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q1/all_tweets_emotions_with_sentiment.csv')
foxnews <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/fox_news_Final_with_sentiment.csv")
nytimes <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/new_york_times_Final_with_sentiment.csv")
#foxtitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/FoxNews_Sheikh_with_sentiment.csv")
#nytitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/NYT_Sheikh_with_sentiment.csv")
q1 <- nytimes

#filter tweets that starts with @
q1 <- q1 %>%  filter(!grepl("^@", q1$text))


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
ggplot(sentiment_by_week, aes(fill=label, y=freq, x=Week, col=label)) + 
  geom_line(lwd=1.5) +
  theme_minimal() + 
  theme(panel.background = element_blank()) +
  ggtitle("NYTimes Average Sentiment of Tweets by Week") +
  labs(x='Week', y='Frequency') +
  theme(plot.title = element_text(hjust = 0.5, size=15, face='bold', margin = margin(t = 10, r = 0 , b = 10, l = 0))) +
  theme(axis.title.x = element_text(face='bold', size=10, margin = margin(t = 10, b = 10, r = 0, l = 0))) +
  theme(axis.title.y = element_text(face='bold', size=10, margin = margin(t = 0, b = 0, r = 10, l = 10))) +
  theme(axis.text.x = element_text(angle=30, size=10)) +
  theme(axis.text.y = element_text(size=10)) +
  theme(legend.title = element_text(face='bold', size=10)) +
  theme(legend.text = element_text(size=8)) +
  scale_x_continuous(breaks=c(1,11,16,23), labels=c("Dec 24th", "Feb 24th", "April 7th", "May 24th"))
#scale_color_manual('label', values=c('#d9534f', '#f0ad4e', '#5cb85c', '#5cb86c', '#5cb87c', '#5cb88c', '#5cb89c'))

