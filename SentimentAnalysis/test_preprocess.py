import pandas as pd
input_csv = pd.read_csv("/Volumes/GoogleDrive/My Drive/Spring 2022/Data Science Methodology/UkraineConflictOnTwitter/SentimentAnalysis/data/q3/FoxNews_Sheikh.csv") 
input_csv.head()
tweet_text = input_csv['text'].to_list()
tweet_date = input_csv['Date'].list()
filtered_tweets = [text for text in tweet_text if type(text) == str] # If some tweets have no text for whatever reason, we remove them
print('Removed ', len(tweet_text) - len(filtered_tweets), 'invalid tweets')


#Adding a preprocessing step to remove links and users
pre_processed = [] #we put all the filtered tweets in this array
for tweet in filtered_tweets:
    tweet_words = [] 
    for word in tweet.split(' '):
        if word.startswith('@') and len(word) > 1: #if it is a mention then it starts with @ 
            word = '@user'
        elif word.startswith("http"):
            word = "http" 
        tweet_words.append(word)
    tweet = " ".join(tweet_words)
    pre_processed.append(tweet)

d = {"Date": tweet_date, "text": pre_processed}
final_df = pd.DataFrame(d)
final_df[tweet[1]]

