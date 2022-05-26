library(pacman) #my package manager

#load necessary packages
p_load(ggplot2)
p_load(dplyr)
p_load(reshape2)
p_load(gridExtra)
p_load(stringr)
p_load(tidytext)
p_load(tidyr)

####Loading all the data
foxnews <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/fox_news_Final_with_sentiment.csv")
nytimes <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/new_york_times_Final_with_sentiment.csv")
foxtitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/FoxNews_Sheikh_with_sentiment.csv")
nytitle <- read.csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/NYT_Sheikh_with_sentiment.csv")

coocc_func <- function(foxnews){
  fox_unn <- foxnews %>% unnest_tokens(word, text, token = "ngrams",
                                       n=2) %>% 
    anti_join(stop_words)
  bg_fox <- fox_unn %>% 
    separate(word, c("word1", "word2"), sep=" ")
  
  avoid_list <- c("russia", "ukraine", "user", "http")
  filter_bg_fox <- bg_fox %>% 
    filter(!word1 %in% stop_words$word) %>% 
    filter(!word2 %in% stop_words$word) %>% 
    filter(!word1 %in% avoid_list) %>% 
    filter(!word2 %in% avoid_list)
  
  count_bg <- filter_bg_fox %>% 
    group_by(word1, word2) %>% 
    tally(sort = TRUE)
  return(count_bg)  
}
fox_pos <- foxnews %>% filter(label=="Positive")
fox_neg <- foxnews %>% filter(label=="Negative")
fox_neu <- foxnews %>% filter(label=="Neutral")

nyt_pos <- nytimes %>% filter(label=="Positive")
nyt_neg <- nytimes %>% filter(label=="Negative")
nyt_neu <- nytimes %>% filter(label=="Neutral")

type(coocc_func(foxnews))
df <- coocc_func(nytimes)
df$bigram <- paste(df$word1, df$word2, sep=" ")
head(df)
