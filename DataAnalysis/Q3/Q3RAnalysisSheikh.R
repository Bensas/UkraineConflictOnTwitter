#Research Question 3
library(pacman) #my package manager

#load necessary packages
p_load(ggplot2)
p_load(dplyr)
p_load(reshape2)
p_load(gridExtra)
p_load(stringr)
#reading data
foxnews <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/FoxNews_Sheikh_with_sentiment.csv")
nytimes <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/NYT_Sheikh_with_sentiment.csv")

#######3#preprocess everything

nytimes <- nytimes %>% select(Date, text, label, score)
nytimes$Date <- substr(nytimes$Date, 0, 10) %>% as.Date("%Y-%m-%d")
nytimes$text <- tolower(nytimes$text)

foxnews <- foxnews %>% select(Date, text, label, score)
foxnews$Date <- substr(foxnews$Date, 0, 10) %>% as.Date("%Y-%m-%d")
foxnews$text <- tolower(foxnews$text)
#########Copied these codes from Juan
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



####Checking the overall positivity of the news
foxTotal <- table(foxnews$label)/length(foxnews$label) * 100
nyTotal <- table(nytimes$label)/length(nytimes$label) * 100

foxTotal <- melt(foxTotal) %>% rename(c(Sentiment = Var1, Percentage=value)) %>% mutate(Source="FoxNews")
nyTotal <- melt(nyTotal) %>% rename(c(Sentiment = Var1, Percentage=value)) %>% mutate(Source="NYT")
allSent <- rbind(foxTotal, nyTotal)

gfox1 <- ggplot(foxTotal, aes(x="", y=Percentage, fill=Sentiment)) +
  geom_bar(stat="identity", width = 1, color="white") +
  coord_polar("y", start = 0) +
  theme(legend.position="none", panel.background = element_blank()) 
  

gnyt1 <- ggplot(nyTotal, aes(x="", y=Percentage, fill=Sentiment)) +
  geom_bar(stat="identity", width = 1, color="white") +
  coord_polar("y", start = 0) +
  theme_void() 

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
  scale_fill_manual(values=c("#fc4949", "#1a94eb"))



############## Filtering out war related tweets####################
#we look for the following words
warwords <- c("invasion", "ukraine", "russia", "war", "putin", "zelensky", "nato", "eu", "invade")

warTweet <- function(text) {
  word = unlist(strsplit(text, " "))[1]
  if (word %in% warwords) {
    TRUE
  } else{
    FALSE
  } 
}
warfox <- foxnews %>% filter(sapply(foxnews$text, warTweet))
warnyt <- nytimes %>% filter(sapply(nytimes$text, warTweet))

######Plotting similar graph for war tweets:
foxTotal2 <- table(warfox$label)/length(warfox$label) * 100
nyTotal2 <- table(warnyt$label)/length(warnyt$label) * 100
#positive and negative newstitles
foxTotal2 <- melt(foxTotal2) %>% rename(c(Sentiment = Var1, Percentage=value)) %>% mutate(Source="FoxNews")
nyTotal2 <- melt(nyTotal2) %>% rename(c(Sentiment = Var1, Percentage=value)) %>% mutate(Source="NYT")
allSent2 <- rbind(foxTotal2, nyTotal2)
ggplot(allSent2, aes(x=Sentiment, y=Percentage, fill=Source)) +
  geom_bar(stat="identity", width = 1, position = position_dodge()) +
  theme(panel.background = element_blank()) +
  scale_fill_manual(values=c("#fc4949", "#1a94eb"))

#to check the size of the dataframes. unfortunately they are quite small
dim(warfox)
dim(warnyt)

#########Plotting the time series of sentiment########
ggplot(foxnews, aes(x=Date, y=label)) + geom_line()




