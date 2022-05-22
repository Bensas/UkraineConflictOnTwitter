# Q1 wordcloud

# source file -- change the file path here
source('./UkraineConflictOnTwitter/DataAnalysis/Q1/q1_analysis.R')

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
docs <- tm_map(docs, removeWords, c("russia", "ukraine", "user")) # remove "Russia" and "Ukraine"

# create matrix
dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

# create wordcloud
set.seed(1234)
wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))