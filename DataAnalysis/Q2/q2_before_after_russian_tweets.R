# Q2 before/after analysis of russian tweets

# libraries
library(ggplot2)
library(dplyr)
library(wordcloud)
library(tm)
library(stringi)

# csv file -- change the file path here
q2_zelensky <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_russian_with_sentiment.csv')

# convert string to datetime
q2_zelensky$Date <- sub(" .*", "", q2_zelensky$Date)
q2_zelensky$Date <- as.Date(q2_zelensky$Date, format="%Y-%m-%d", tz="UTC")

# Tweets before twitter ban
q2_zelensky_before_ban <- subset(q2_zelensky, Date < as.Date('2022-03-04'))
q2_zelensky_after_ban <- subset(q2_zelensky, Date >= as.Date('2022-03-04'))

# calculate percentage of label
sentiment_before_ban <- q2_zelensky_before_ban %>%
  group_by(label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3))

sentiment_after_ban <- q2_zelensky_after_ban %>%
  group_by(label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3))

negative_freq = c(sentiment_before_ban$freq[1], sentiment_after_ban$freq[1])
neutral_freq = c(sentiment_before_ban$freq[2], sentiment_after_ban$freq[2])
positive_freq = c(sentiment_before_ban$freq[3], sentiment_after_ban$freq[3])
matrix_data = rbind(negative_freq, neutral_freq, positive_freq)
info_matrix = matrix(matrix_data, nrow=3, ncol=2, dimnames= list(c("Negative tweets", "Neutral Tweets", "Positive tweets"), c("Before Twitter Ban", "After Twitter Ban")))
info_matrix

chisq.test(info_matrix)

ggplot(info_matrix, aes(fill=label, y=freq, x=week)) + 
  geom_bar(position='stack', stat='identity') +
  theme_minimal() + 
  ggtitle("Average Sentiment of Tweets by Week") +
  labs(x='Week', y='Frequency') +
  theme(plot.title = element_text(hjust = 0.5, size=20, face='bold', margin = margin(t = 10, r = 0 , b = 10, l = 0))) +
  theme(axis.title.x = element_text(face='bold', size=15, margin = margin(t = 10, b = 10, r = 0, l = 0))) +
  theme(axis.title.y = element_text(face='bold', size=15, margin = margin(t = 0, b = 0, r = 10, l = 10))) +
  theme(axis.text.x = element_text(angle=30, size=13)) +
  theme(axis.text.y = element_text(size=13)) +
  theme(legend.title = element_text(face='bold', size=15)) +
  theme(legend.text = element_text(size=15)) +
  scale_x_continuous(breaks=c(1,3,7,11,15,19), labels=c("Dec 2021", "Jan 2022", "Feb 2022", "March 2022", "April 2022", "May 2022")) +
  scale_fill_manual('label', values=c('#d9534f', '#f0ad4e', '#5cb85c'))
