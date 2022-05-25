# Q1 : linear model

# source file -- change the file path here
source('./UkraineConflictOnTwitter/DataAnalysis/Q1/q1_analysis.R')

# linear regression analysis

negative.linear <- lm(freq ~ Week, data = sentiment_by_week[sentiment_by_week$label == 'Negative',])
# p-value : 9.191e-08 (significant)
neutral.linear <- lm(freq ~ Week, data = sentiment_by_week[sentiment_by_week$label == 'Neutral',])
# p-value : 5.34e-08 (significant)
positive.linear <- lm(freq ~ Week, data = sentiment_by_week[sentiment_by_week$label == 'Positive',])
# p-value : 0.238 (insignificant)

# plot linear model
ggplot() +
  theme_minimal() + 
  theme(panel.background = element_blank()) +
  ggtitle("Average Sentiment of Tweets by Week") +
  labs(x='Week', y='Frequency') +
  theme(plot.title = element_text(hjust = 0.5, size=20, face='bold', margin = margin(t = 10, r = 0 , b = 10, l = 0))) +
  theme(axis.title.x = element_text(face='bold', size=15, margin = margin(t = 10, b = 10, r = 0, l = 0))) +
  theme(axis.title.y = element_text(face='bold', size=15, margin = margin(t = 0, b = 0, r = 10, l = 10))) +
  theme(axis.text.x = element_text(size=13)) +
  theme(axis.text.y = element_text(size=13)) +
  theme(legend.title = element_text(face='bold', size=15)) +
  theme(legend.text = element_text(size=15)) +
  geom_smooth(aes(x = Week, y = freq), data = sentiment_by_week[sentiment_by_week$label == 'Negative',], 
              method = "lm", se = FALSE, color = "#d9534f") + 
  geom_smooth(aes(x = Week, y = freq), data = sentiment_by_week[sentiment_by_week$label == 'Neutral',], 
              method = "lm", se = FALSE, color = "#f0ad4e") + 
  geom_smooth(aes(x = Week, y = freq), data = sentiment_by_week[sentiment_by_week$label == 'Positive',], 
              method = "lm", se = FALSE, color = "#5cb85c") + 
  geom_point(aes(x = Week, y = freq), data = sentiment_by_week[sentiment_by_week$label == 'Negative',], color = "#d9534f") + 
  geom_point(aes(x = Week, y = freq), data = sentiment_by_week[sentiment_by_week$label == 'Neutral',], color = "#f0ad4e") +
  geom_point(aes(x = Week, y = freq), data = sentiment_by_week[sentiment_by_week$label == 'Positive',], color = "#5cb85c")
