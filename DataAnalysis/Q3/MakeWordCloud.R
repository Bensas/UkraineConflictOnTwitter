# Q1 wordcloud
library(pacman)
p_load(wordcloud)
p_load(tm)
p_load(dplyr)
p_load(ggplot2)

# source file -- change the file path here
foxnews <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/fox_news_Final_with_sentiment.csv")
nytimes <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/new_york_times_Final_with_sentiment.csv")
foxtitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/FoxNews_Sheikh_with_sentiment.csv")
nytitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/NYT_Sheikh_with_sentiment.csv")

make_cloud <- function(dataset, sentiment){
  positive <- dataset[dataset$label == sentiment,] 
  
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
  docs <- tm_map(docs, removeWords, c("russia", "ukraine", "user", "http")) # remove "Russia" and "Ukraine"
  
  # create matrix
  dtm <- TermDocumentMatrix(docs) 
  matrix <- as.matrix(dtm) 
  words <- sort(rowSums(matrix),decreasing=TRUE) 
  df <- data.frame(word = names(words),freq=words)
  
  # create wordcloud
  set.seed(1234)
  wc <- wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, 
            colors=brewer.pal(8, "Dark2"))
  return(wc)

}

make_cloud(foxnews, "Neutral")

