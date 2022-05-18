# UkraineConflictOnTwitter
Analysis of twitter data to track the sentiment of different groups in regards to the Ukraine-Russia conflict.


## Running Twitter API code
### Requirements
- You must have the [Deno Runtime](https://deno.land) installed on your computer.

- You must include a valid Access Token for the Twitter API on the `index.ts` file.

### Running
To execute the default code, simply stand on the main directory and run:
```
  cd TwitterAPI
  bash run.sh
```

## Running Sentiment Analaysis code
### Requirements
- You must have the `transformers` library installed. Can be isntalled running `pip install -q transformers`

- You must have the `tensorflow` library installed. Can be installed running `pip install -q tensorflow`

- You must have the `pytorch` library installed. Can be installed running `pip install -q torch`

### Running

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
