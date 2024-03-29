library(pacman) #my package manager

#load necessary packages
p_load(ggplot2)
p_load(dplyr)
p_load(reshape2)
p_load(gridExtra)
p_load(stringr)
p_load(tidytext)
p_load(tidyr)
p_load(wordcloud)
p_load(tm)

####Loading all the data
foxnews <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/May30Scrap/foxalltweets_with_sentiment.csv")
nytimes <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/May30Scrap/nytalltweets_with_sentiment.csv")
foxtitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/May30Scrap/foxtitle_with_sentiment.csv")
nytitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/May30Scrap/nytitle_with_sentiment.csv")
trigram_wc <- function(foxnews){
  fox_unn <- foxnews %>% unnest_tokens(word, text, token = "ngrams",
                                       n=3) %>% 
    anti_join(stop_words)
  bg_fox <- fox_unn %>% 
    separate(word, c("word1", "word2", "word3"), sep=" ")
  
  avoid_list <- c("russia", "ukraine", "user", "http", "fox", "york")
  filter_bg_fox <- bg_fox %>% 
    filter(!word1 %in% stop_words$word) %>% 
    filter(!word2 %in% stop_words$word) %>%
    filter(!word3 %in% stop_words$word) %>% 
    filter(!word1 %in% avoid_list) %>% 
    filter(!word2 %in% avoid_list) %>% 
    filter(!word3 %in% avoid_list)
  
  count_bg <- filter_bg_fox %>% 
    group_by(word1, word2) %>% 
    tally(sort = TRUE)
  
  count_bg <- as.data.frame(count_bg)
  
  count_bg$bigram <- paste(count_bg$word1, count_bg$word2, sep=" ")
  wc <- wordcloud(words = count_bg$bigram, freq = count_bg$n, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, 
                  colors=brewer.pal(8, "Dark2"))
  
  return(wc)
}

fox_pos <- trigram_wc(foxnews %>% filter(label=="Positive"))
fox_neg <- trigram_wc(foxnews %>% filter(label=="Negative"))
fox_neu <- trigram_wc(foxnews %>% filter(label=="Neutral"))

nyt_pos <- trigram_wc(nytimes %>% filter(label=="Positive"))
nyt_neg <- trigram_wc(nytimes %>% filter(label=="Negative"))
nyt_neu <- trigram_wc(nytimes %>% filter(label=="Neutral"))

