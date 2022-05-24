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
q2_zelensky$tweetcreatedts <- sub(" .*", "", q2_zelensky$tweetcreatedts)
q2_zelensky$tweetcreatedts <- as.Date(q2_zelensky$tweetcreatedts, format="%Y-%m-%d", tz="UTC")

# Tweets before twitter ban
q2_zelensky_before_ban <- subset(q2_zelensky, tweetcreatedts < as.Date('2022-03-04'))
q2_zelensky_after_ban <- subset(q2_zelensky, tweetcreatedts >= as.Date('2022-03-04'))

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

