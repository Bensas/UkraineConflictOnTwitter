library(ggplot2)
library(dplyr)

# csv files
foxnews <- read.csv("./UkraineConflictOnTwitter/SentimentAnalysis/data/q3/fox_news_Final_with_sentiment.csv")
nytimes <- read.csv("./UkraineConflictOnTwitter/SentimentAnalysis/data/q3/new_york_times_Final_with_sentiment.csv")

# remove replies (starting with '@')
foxnews <- foxnews[!grepl('^@',foxnews$text),]
nytimes <- nytimes[!grepl('^@',nytimes$text),]

# modifying data

# fox news
# convert string to datetime
foxnews$Date <- sub(" .*", "", foxnews$Date)
foxnews$Date <- as.Date(foxnews$Date, format="%Y-%m-%d", tz="UTC")

# create Week column
foxnews <- foxnews %>% 
  mutate(Week = cut.Date(foxnews$Date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(foxnews$Date)

# calculate count by week
foxnews_by_week <- foxnews %>%
  group_by(Week) %>%
  summarise(cnt = n()) %>%
  arrange(Week)

# ny times 

# convert string to datetime
nytimes$Date <- sub(" .*", "", nytimes$Date)
nytimes$Date <- as.Date(nytimes$Date, format="%Y-%m-%d", tz="UTC")

# create Week column
nytimes <- nytimes %>% 
  mutate(Week = cut.Date(nytimes$Date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(nytimes$Date)

# calculate count by week
nytimes_by_week <- nytimes %>%
  group_by(Week) %>%
  summarise(cnt = n()) %>%
  arrange(Week)

# line graph
ggplot() +
  theme_minimal() + 
  theme(panel.background = element_blank()) +
  ggtitle("Weekly Number of Tweets Containing Ukraine or Russia") +
  labs(x='Week', y='Number of Tweets') +
  theme(plot.title = element_text(hjust = 0.5, size=20, face='bold', margin = margin(t = 10, r = 0 , b = 10, l = 0))) +
  theme(axis.title.x = element_text(face='bold', size=15, margin = margin(t = 10, b = 10, r = 0, l = 0))) +
  theme(axis.title.y = element_text(face='bold', size=15, margin = margin(t = 0, b = 0, r = 10, l = 10))) +
  theme(axis.text.x = element_text(size=13)) +
  theme(axis.text.y = element_text(size=13)) +
  theme(legend.title = element_text(face='bold', size=15)) +
  theme(legend.text = element_text(size=15)) +
  geom_line(aes(x = Week, y = cnt, color = "Fox News"), data = foxnews_by_week, size=1.5) + 
  geom_line(aes(x = Week, y = cnt, color = "NY Times"), data = nytimes_by_week, size=1.5) +
  scale_color_manual(name = "Y series", values = c("Fox News" = "#d9534f", "NY Times" = "#0275d8")) + 
  scale_x_continuous(breaks=c(1,4,11,16,23), labels=c("Dec 24th", "Jan 14th", "Feb 24th", "April 7th", "May 24th")) 