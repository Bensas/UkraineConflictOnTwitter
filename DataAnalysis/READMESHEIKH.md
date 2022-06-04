# How to handle my files ~ Sheikh

## Naming convention of the csv files used here:
> All the data files are kept in: ./SentimentAnalysis/data/q3/May30Scrap  
1. Files containing the tweets themselves are imported as foxnews and nytimes. They contain all the tweets that had been scrapped using Nikita's query (and contains replies). These files are named as foxalltweets and nytalltweets in the folder
2. Files that ONLY contain the tweets from the news sources are imported as foxtitle and nytitle
The reason to scrap the tweets of no 2 is that for question 1, I used them to find some observations that is impossible to find using data used in 1, as they are already filtered to contain Ukrainan tweets. 

## Data Analysis
> All the R files used for data analysis is kept here: ./DataAnalysis/Q3
>> There is a folder called Figues, which contains some corresponding output figures, however, some of them contain figures generated from old data, so better not to be meddled with. We can generate new figues instantly from our R files

The names of the R files are self explanatory for what they do. Still some points:
- trigramWordCloud.R doesn't work as expected, so we didnt' use its output. 
- Q3TitleAnalysis.R and NumberofWarRelatedTweets.R are the files that uses data scrapped in 2.
- Q3SidebySideBar plots the overall sentiment of the tweets bar plot
- For wordcloud files after running the entire code, running the function on the terminal using proper dataset and parameters would give proper result



