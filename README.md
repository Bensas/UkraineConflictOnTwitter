# UkraineConflictOnTwitter
Analysis of twitter data to track the sentiment of different groups in regards to the Ukraine-Russia conflict.


## Running Twitter API code
### Requirements
- You must have the [Deno Runtime](https://deno.land) installed on your computer.

- You must include a valid Access Token for the Twitter API on the `index.ts` file.

### Running
To execute the default code, simply stand on the main directory and run:
```
  cd DataCollection/TwitterAPI
  bash run.sh
```

## Running Sentiment Analaysis code
### Requirements
- You must have the `transformers` library installed. Can be isntalled running `pip install -q transformers`

- You must have the `tensorflow` library installed. Can be installed running `pip install -q tensorflow`

- You must have the `pytorch` library installed. Can be installed running `pip install -q torch`

### Running [DEPRECATED]

To execute the default code, simply stand on the main directory and run:
```
  cd SentimentAnalalysis
  python sentiment_analysis.py
```

## Running Data Analaysis code
### Requirements
- The R runtime must be installed on your system ([RStudio is recommended](https://www.rstudio.com/products/rstudio/download/))
- You must modify the `main.R` file to include the correct path to the data files.
### Running

To execute the default code, enter the `DataAnalysis` directory, run the `requirements.R` script to install necessary dependencies, and finally run the `main.R` script.

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



