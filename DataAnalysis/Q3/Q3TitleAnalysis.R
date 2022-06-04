library(pacman) #my package manager

#load necessary packages
p_load(ggplot2)
p_load(dplyr)
p_load(reshape2)
p_load(gridExtra)
p_load(stringr)
#reading data


foxnews <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/May30Scrap/foxalltweets_with_sentiment.csv")
nytimes <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/May30Scrap/nytalltweets_with_sentiment.csv")
foxtitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/May30Scrap/foxtitle_with_sentiment.csv")
nytitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/May30Scrap/nytitle_with_sentiment.csv")
#######3#preprocess everything

nytitle <- nytitle %>% select(Date, text, label, score)
nytitle$Date <- sub(" .*", "", nytitle$Date) %>% as.Date(format="%Y-%m-%d", tz="UTC")
nytitle$text <- tolower(nytitle$text)

foxtitle <- foxtitle %>% select(Date, text, label, score)
foxtitle$Date <- sub(" .*", "", foxtitle$Date) %>% as.Date(format="%Y-%m-%d", tz="UTC")
foxtitle$text <- tolower(foxtitle$text)

#########Copied these codes from Juan's code##########

# create YearMonth column
foxtitle$YearMonth <- substr(foxtitle$Date, 1,7)
nytitle$YearMonth <- substr(nytitle$Date, 1,7)
# create Week column
foxtitle <- foxtitle %>% 
  mutate(Week = cut.Date(foxtitle$Date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(foxtitle$Date)

nytitle <- nytitle %>% 
  mutate(Week = cut.Date(nytitle$Date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(nytitle$Date)

# calculate percentage of sentiment by week
sentiment_by_week_fox <- foxtitle  %>%
  group_by(Week, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(Week) %>% mutate(source = "foxtitle")

sentiment_by_week_nytitle <- nytitle %>%
  group_by(Week, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(Week) %>% mutate(source = "nytitle")

sentiment_by_week_combined <- rbind(sentiment_by_week_fox, sentiment_by_week_nytitle)

# calculate percentage of sentiment by month
sentiment_by_month_fox <- foxtitle %>%
  group_by(YearMonth, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(YearMonth) %>% mutate(source = "foxtitle")

sentiment_by_month_nytitle <- nytitle %>%
  group_by(YearMonth, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(YearMonth) %>% mutate(source = "nytitle")

sentiment_by_month_combined <- rbind(sentiment_by_month_fox, sentiment_by_month_nytitle)


#####################################
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
foxTotal <- table(foxtitle$label)/length(foxtitle$label) * 100
nyTotal <- table(nytitle$label)/length(nytitle$label) * 100

foxTotal <- melt(foxTotal) %>% rename(c(Sentiment = Var1, Percentage=value)) %>% mutate(Source="foxtitle")
nyTotal <- melt(nyTotal) %>% rename(c(Sentiment = Var1, Percentage=value)) %>% mutate(Source="NYT")
allSent <- rbind(foxTotal, nyTotal)

ggplot(foxTotal, aes(x="", y=Percentage, fill=Sentiment)) +
  geom_bar(stat="identity", width = 1, color="white") +
  coord_polar("y", start = 0) +
  ggtitle("Fox News Title Average Sentiment") +
  theme(panel.background = element_blank())


ggplot(nyTotal, aes(x="", y=Percentage, fill=Sentiment)) +
  geom_bar(stat="identity", width = 1, color="white") +
  coord_polar("y", start = 0) +
  ggtitle("NYT Title Average Sentiment") +
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
  ggtitle("Media Tweet Sentiment Comparison") +
  scale_fill_manual(values=c("#fc4949", "#1a94eb"))
