

library(ggplot2)
library(dplyr)


create_count_matrix_2_groups <- function(group_1, group_2, title_1, title_2) {
  sentiment_group_1 <- group_1 %>%
    group_by(label) %>%
    summarise(freq = n())

  sentiment_group_2 <- group_2 %>%
    group_by(label) %>%
    summarise(freq = n())

  negative_freq = c(sentiment_group_1$freq[1], sentiment_group_2$freq[1])
  neutral_freq = c(sentiment_group_1$freq[2], sentiment_group_2$freq[2])
  positive_freq = c(sentiment_group_1$freq[3], sentiment_group_2$freq[3])
  matrix_data = rbind(negative_freq, neutral_freq, positive_freq)
  info_matrix = matrix(matrix_data, nrow=3, ncol=2, 
                       dimnames= list(c("Negative tweets", "Neutral Tweets", "Positive tweets"), c(title_1, title_2)))
  return(info_matrix)
}

create_freq_matrix_2_groups <- function(group_1, group_2, title_1, title_2) {
  sentiment_group_1 <- group_1 %>%
    group_by(label) %>%
    summarise(cnt = n()) %>%
    mutate(freq = round(cnt / sum(cnt), 3))
  
  sentiment_group_2 <- group_2 %>%
    group_by(label) %>%
    summarise(cnt = n()) %>%
    mutate(freq = round(cnt / sum(cnt), 3))
  
  negative_freq = c(sentiment_group_1$freq[1], sentiment_group_2$freq[1])
  neutral_freq = c(sentiment_group_1$freq[2], sentiment_group_2$freq[2])
  positive_freq = c(sentiment_group_1$freq[3], sentiment_group_2$freq[3])
  matrix_data = rbind(negative_freq, neutral_freq, positive_freq)
  info_matrix = matrix(matrix_data, nrow=3, ncol=2, 
                       dimnames= list(c("Negative tweets", "Neutral Tweets", "Positive tweets"), c(title_1, title_2)))
  return(info_matrix)
}
