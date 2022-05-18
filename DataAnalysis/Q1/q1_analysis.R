# Q1 analysis

# libraries
library(ggplot2)
library(dplyr)
library(wordcloud)
library(tm)
library(stringi)

# csv file -- change the file path here
q1 <-  read.csv('./Downloads/all_tweets_with_sentiment.csv')

## stacked bar plot ##

# convert string to datetime
q1$tweetcreatedts <- sub(" .*", "", q1$tweetcreatedts)
q1$tweetcreatedts <- as.Date(q1$tweetcreatedts, format="%Y-%m-%d", tz="UTC")

# group by week
q1 <- q1 %>% 
  mutate(week = cut.Date(q1$tweetcreatedts, breaks = "1 week", labels = FALSE)) %>% 
  arrange(q1$tweetcreatedts)

# calculate percentage of label
sentiment_by_week <- q1 %>%
  group_by(week, label) %>%
  summarise(cnt = n()) %>%
  mutate(freq = round(cnt / sum(cnt), 3)) %>% 
  arrange(week)

# graph
ggplot(sentiment_by_week, aes(fill=label, y=freq, x=week)) + 
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

## wordcloud ##

# for positive tweets #

positive <- q1[q1$label == 'Positive',]

# remove non-ascii words
positive$text <- stringi::stri_trans_general(positive$text, "latin-ascii")
positive$text <- gsub("[^\x01-\x7F]", "", positive$text)

# create corpus and preprocess data
docs <- Corpus(VectorSource(positive$text))
docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, c("russia", "ukraine")) # remove "Russia" and "Ukraine"

# create matrix
dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

# create wordcloud
set.seed(1234)
wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
