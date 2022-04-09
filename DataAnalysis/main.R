library(data.table)
library(dplyr)

inputFilePath = '/Working/Directory/Data/test.csv'
ex4 <- fread(inputFilePath , header=TRUE)
sentimentCounts <- as.data.frame(ex4) %>% count(sentiment)
sentimentCounts
barplot(sentimentCounts[,2], xlab="Sentiment", ylab="Number of tweets")
