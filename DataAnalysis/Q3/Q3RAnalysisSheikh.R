#Research Question 3
library(pacman) #my package manager

#load necessary packages
p_load(ggplot2)
p_load(dplyr)
p_load(reshape2)
p_load(gridExtra)
#reading data
foxnews <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/FoxNews_Sheikh_with_sentiment.csv")
nytimes <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/NYT_Sheikh_with_sentiment.csv")
#preprocess everything
foxnews <- foxnews %>% select(Date, text, label, score)

nytimes <- nytimes %>% select(Date, text, label, score)



nytimes$Date <- substr(nytimes$Date, 0, 10) %>% as.Date("%Y-%m-%d")
foxnews$Date <- substr(foxnews$Date, 0, 10) %>% as.Date("%Y-%m-%d")

foxTotal <- table(foxnews$label)/length(foxnews$label) * 100
nyTotal <- table(nytimes$label)/length(nytimes$label) * 100
#Overall positive and negative news
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
ggplot(allSent, aes(x=Sentiment, y=Percentage, fill=Source)) +
  geom_bar(stat="identity", width = 1, position = position_dodge()) +
  theme(panel.background = element_blank()) +
  scale_fill_manual(values=c("#fc4949", "#1a94eb"))




