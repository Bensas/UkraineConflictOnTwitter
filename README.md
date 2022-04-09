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

### Running

To execute the default code, simply stand on the main directory and run:
```
  cd SentimentAnalalysis
  python sentiment_analysis.py
```
