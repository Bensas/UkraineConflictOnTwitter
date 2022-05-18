# Q2 analysis

# we should unify paths (this path works if your working directory contains the repository)
source("UkraineConflictOnTwitter/DataAnalysis/visualization.R")

# csv file -- change the file path here
q2_russian_putin <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_russian_with_sentiment.csv')
q2_russian_zelensky <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/zelensky_russian_with_sentiment.csv')
#q2_russian_nato <-  read.csv('UkraineConflictOnTwitter/SentimentAnalysis/data/q2/nato_russian_with_sentiment.csv')

plot_piechart(q2_russian_putin, "Sentiment of Russian tweets containing 'Putin'")
plot_piechart(q2_russian_zelensky, "Sentiment of Russian tweets containing 'Zelensky'")


