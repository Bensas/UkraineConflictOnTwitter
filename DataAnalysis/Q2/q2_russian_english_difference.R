# Q2 Russian vs English sentiment

# libraries
library(ggplot2)
library(dplyr)

source("UkraineConflictOnTwitter/DataAnalysis/utils.R")

q2_zelensky_russian <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/zelensky_russian_with_sentiment.csv')
q2_zelensky_english <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/zelensky_english_with_sentiment.csv')

matrix_zelensky = create_freq_matrix_2_groups(q2_zelensky_russian, q2_zelensky_english, "Zelensky Russian", "Zelensky English")
print(matrix_zelensky)

chisq.test(matrix_zelensky)
# p-value < 2.2e-16 (significant)

q2_putin_russian <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_russian_with_sentiment.csv')
q2_putin_english <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_english_with_sentiment.csv')

matrix_putin = create_freq_matrix_2_groups(q2_putin_russian, q2_putin_english, "Putin Russian", "Putin English")
print(matrix_putin)

chisq.test(matrix_putin)
# p-value < 2.2e-16 (significant)

q2_nato_russian <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/nato_russian_with_sentiment.csv')
q2_nato_english <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/nato_english_with_sentiment.csv')

matrix_nato = create_freq_matrix_2_groups(q2_nato_russian, q2_nato_english, "NATO Russian", "NATO English")
print(matrix_nato)

chisq.test(matrix_nato)
# p-value < 2.2e-16 (significant)
