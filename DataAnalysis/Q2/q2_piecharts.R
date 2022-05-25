# Q2 analysis

# we should unify paths (this path works if your working directory contains the repository)
source("/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/DataAnalysis/visualization.R")

# csv file -- change the file path here
q2_russian_putin <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_russian_with_sentiment.csv')
q2_russian_zelensky <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/zelensky_russian_with_sentiment.csv')
q2_russian_nato <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/nato_russian_with_sentiment.csv')

q2_english_putin <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/putin_english_with_sentiment.csv')
q2_english_zelensky <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/zelensky_english_with_sentiment.csv')
q2_english_nato <-  read.csv('/Users/Bensas/ITBA/Intercambios/KAIST/Data\ Science\ Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q2/nato_english_with_sentiment.csv')

plot_piechart(q2_russian_putin, "Sentiment of Russian tweets containing 'Putin'")
plot_piechart(q2_english_putin, "Sentiment of English tweets containing 'Putin'")

plot_piechart(q2_russian_zelensky, "Sentiment of Russian tweets containing 'Zelensky'")
plot_piechart(q2_english_zelensky, "Sentiment of English tweets containing 'Zelensky'")

plot_piechart(q2_russian_nato, "Sentiment of Russian tweets containing 'NATO'")
plot_piechart(q2_english_nato, "Sentiment of English tweets containing 'NATO'")


