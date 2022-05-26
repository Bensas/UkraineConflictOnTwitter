# Q2 before/after analysis of russian tweets

# libraries
library(ggplot2)
library(dplyr)

source("UkraineConflictOnTwitter/DataAnalysis/utils.R")


split_before_after_date <- function(data, date) {
  # convert string to datetime
  data$Date <- sub(" .*", "", data$Date)
  data$Date <- as.Date(data$Date, format="%Y-%m-%d", tz="UTC")
  
  data <- subset(data, Date >= as.Date('2022-02-18') & Date <= as.Date('2022-03-17'))
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
  info_matrix = create_count_matrix_2_groups(before_ban, after_ban, "Before Twitter Ban", "After Twitter Ban")
  print(info_matrix)
  
  chisq.test(info_matrix)
}

plot_barplot_before_after <- function(data, plot_title) {
  result = split_before_after_date(data, as.Date('2022-03-04'))
  before_ban = data.frame(result[1])
  after_ban = data.frame(result[2])
  
  # calculate frequency of label
  info_matrix = create_freq_matrix_2_groups(before_ban, after_ban, "Before Twitter Ban", "After Twitter Ban")
  print(info_matrix)
  barplot(info_matrix, main=plot_title, col = c('#d9534f', '#f0ad4e', '#5cb85c'))
}

# Russian

# csv file -- change the file path here
q2_zelensky_russian <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/zelensky_russian_with_sentiment.csv')
conduct_chisq_before_after(q2_zelensky_russian)
plot_barplot_before_after(q2_zelensky_russian, "Sentiment of russian tweets containing \"Zelensky\"")
# p-value for 1 week before/after = 0.4434 (insignificant)
# p-value for 2 weeks before/after = 0.0744 (insignificant)


q2_putin_russian <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_russian_with_sentiment.csv')
conduct_chisq_before_after(q2_putin_russian)
plot_barplot_before_after(q2_putin_russian, "Sentiment of russian tweets containing \"Putin\"")
# p-value for 1 week before/after = 0.4486 (insignificant)
# p-value for 2 weeks before/after = 0.1378 (insignificant)

q2_nato_russian <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/nato_russian_with_sentiment.csv')
conduct_chisq_before_after(q2_nato_russian)
plot_barplot_before_after(q2_nato_russian, "Sentiment of russian tweets containing \"NATO\"")
# p-value for 1 week before/after = 0.05422 (insignificant)
# p-value for 2 weeks before/after = 0.00012 (significant)

# English

q2_zelensky_english <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/zelensky_english_with_sentiment.csv')
conduct_chisq_before_after(q2_zelensky_english)
plot_barplot_before_after(q2_zelensky_english, "Sentiment of english tweets containing \"Zelensky\"")
# p-value for 1 week before/after = 2.153e-11 (significant)

q2_putin_english <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_english_with_sentiment.csv')
conduct_chisq_before_after(q2_putin_english)
plot_barplot_before_after(q2_putin_english, "Sentiment of english tweets containing \"Putin\"")
# p-value for 1 week before/after = 0.01354 (significant)

q2_nato_english <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/nato_english_with_sentiment.csv')
conduct_chisq_before_after(q2_nato_english)
plot_barplot_before_after(q2_nato_english, "Sentiment of english tweets containing \"NATO\"")
# p-value for 1 week before/after = 0.04421 (significant)



