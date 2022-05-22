# Q2 before/after analysis of russian tweets

# libraries
library(ggplot2)
library(dplyr)

source("UkraineConflictOnTwitter/DataAnalysis/utils.R")


split_before_after_date <- function(data, date) {
  # convert string to datetime
  data$Date <- sub(" .*", "", data$Date)
  data$Date <- as.Date(data$Date, format="%Y-%m-%d", tz="UTC")
  
  #data <- subset(data, Date >= as.Date('2022-02-25') & Date <= as.Date('2022-03-10'))
  data
  
  # Tweets before and after twitter ban
  data_before <- subset(data, Date < date)
  data_after <- subset(data, Date >= date)
  
  return(list(data_before, data_after))
  
}

conduct_chisq_before_after <- function(data) {
  result = split_before_after_date(data, as.Date('2022-03-04'))
  before_ban = data.frame(result[1])
  after_ban = data.frame(result[2])
  
  # calculate frequency of label
  info_matrix = create_freq_matrix_2_groups(before_ban, after_ban, "Before Twitter Ban", "After Twitter Ban")
  print(info_matrix)
  
  chisq.test(info_matrix)
}

# Russian

# csv file -- change the file path here
q2_zelensky_russian <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/zelensky_russian_with_sentiment.csv')
conduct_chisq_before_after(q2_zelensky_russian)

q2_putin_russian <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_russian_with_sentiment.csv')
conduct_chisq_before_after(q2_putin_russian)

q2_nato_russian <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/nato_russian_with_sentiment.csv')
conduct_chisq_before_after(q2_nato_russian)

# English

q2_zelensky_english <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/zelensky_english_with_sentiment.csv')
conduct_chisq_before_after(q2_zelensky_english)

q2_putin_english <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_english_with_sentiment.csv')
conduct_chisq_before_after(q2_putin_english)

q2_nato_english <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/nato_english_with_sentiment.csv')
conduct_chisq_before_after(q2_nato_english)




