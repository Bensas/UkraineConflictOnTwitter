#Research Question 3
library(pacman) #my package manager

#load necessary packages
p_load(ggplot2)
p_load(dplyr)
p_load(reshape2)
p_load(gridExtra)
p_load(stringr)
#reading data
foxnews <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/fox_news_Final_with_sentiment.csv")
nytimes <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/new_york_times_Final_with_sentiment.csv")
foxtitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/FoxNews_Sheikh_with_sentiment.csv")
nytitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/NYT_Sheikh_with_sentiment.csv")
#######3#preprocess everything

nytimes <- nytimes %>% select(Date, text, label, score)
nytimes$Date <- sub(" .*", "", nytimes$Date) %>% as.Date(format="%Y-%m-%d", tz="UTC")
nytimes$text <- tolower(nytimes$text)

foxnews <- foxnews %>% select(Date, text, label, score)
foxnews$Date <- sub(" .*", "", foxnews$Date) %>% as.Date(format="%Y-%m-%d", tz="UTC")
foxnews$text <- tolower(foxnews$text)

#########Copied these codes from Juan's code##########

# create YearMonth column
foxnews$YearMonth <- substr(foxnews$Date, 1,7)
nytimes$YearMonth <- substr(nytimes$Date, 1,7)
# create Week column
foxnews <- foxnews %>% 
  mutate(Week = cut.Date(foxnews$Date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(foxnews$Date)

nytimes <- nytimes %>% 
  mutate(Week = cut.Date(nytimes$Date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(nytimes$Date)

# calculate percentage of sentiment by week
sentiment_by_week_fox <- foxnews  %>%
  group_by(Week, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(Week) %>% mutate(source = "FoxNews")

sentiment_by_week_nytimes <- nytimes %>%
  group_by(Week, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(Week) %>% mutate(source = "NYTimes")

sentiment_by_week_combined <- rbind(sentiment_by_week_fox, sentiment_by_week_nytimes)

# calculate percentage of sentiment by month
sentiment_by_month_fox <- foxnews %>%
  group_by(YearMonth, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(YearMonth) %>% mutate(source = "FoxNews")

sentiment_by_month_nytimes <- nytimes %>%
  group_by(YearMonth, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(YearMonth) %>% mutate(source = "NYTimes")

sentiment_by_month_combined <- rbind(sentiment_by_month_fox, sentiment_by_month_nytimes)

###Plotting graphs
ggplot(sentiment_by_week_combined, aes(fill=source, y=freq, x=Week)) + 
  geom_bar(position='dodge', stat='identity') +
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


####Checking the overall sentiment of the news
foxTotal <- table(foxnews$label)/length(foxnews$label) * 100
nyTotal <- table(nytimes$label)/length(nytimes$label) * 100

foxTotal <- melt(foxTotal) %>% rename(c(Sentiment = Var1, Percentage=value)) %>% mutate(Source="FoxNews")
nyTotal <- melt(nyTotal) %>% rename(c(Sentiment = Var1, Percentage=value)) %>% mutate(Source="NYT")
allSent <- rbind(foxTotal, nyTotal)

ggplot(foxTotal, aes(x="", y=Percentage, fill=Sentiment)) +
  geom_bar(stat="identity", width = 1, color="white") +
  coord_polar("y", start = 0) +
  ggtitle("Fox News Tweets and Replies' Sentiment") +
  theme(panel.background = element_blank())

ggplot(nyTotal, aes(x="", y=Percentage, fill=Sentiment)) +
  geom_bar(stat="identity", width = 1, color="white") +
  coord_polar("y", start = 0) +
  ggtitle("NYT Tweets and Replies' Sentiment") +
  theme(panel.background = element_blank())
  

gfox1
gnyt1

#barplot
gfox2 <- ggplot(foxTotal, aes(x=Sentiment, y=Percentage, fill=Sentiment)) +
  geom_bar(stat="identity", width = 1, color="white") +
  theme(legend.position="none", panel.background = element_blank()) 

gnyt2 <- ggplot(nyTotal, aes(x=Sentiment, y=Percentage, fill=Sentiment)) +
  geom_bar(stat="identity", width = 1, color="white") +
  theme(legend.position="none", panel.background = element_blank()) 

#Plots side by side in one graph
#This is the side by side comparison of the sentiment of tweets of all tweets

ggplot(allSent, aes(x=Sentiment, y=Percentage, fill=Source)) +
  geom_bar(stat="identity", width = 1, position = position_dodge()) +
  theme(panel.background = element_blank()) +
  ggtitle("Media Outlet Tweet and Reply Sentiment Comparison") +
  scale_fill_manual(values=c("#fc4949", "#1a94eb"))






