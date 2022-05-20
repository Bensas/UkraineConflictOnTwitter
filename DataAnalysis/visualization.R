
library(ggplot2)
library(dplyr)

label_colours = c('#d9534f', '#f0ad4e', '#5cb85c')
title_size = 15
legend_title_size = 15
legend_text_size = 15

plot_piechart <- function(data, title) {
  sentiment_by_label <- data %>%
    group_by(label) %>%
    summarise(cnt = n()) %>%
    mutate(freq = round(cnt / sum(cnt), 3)) %>%
    mutate(ypos = cumsum(freq)- 0.5*freq )
  sentiment_by_label
  
  ggplot(sentiment_by_label, aes(x="", y=freq, fill=label)) +
    geom_bar(stat="identity", width=1, color="white") +
    coord_polar("y", start=0) +
    ggtitle(title) +
    theme_void() + 
    theme(plot.title = element_text(hjust = 0.5, size=title_size, face='bold', margin = margin(t = 10, r = 0 , b = 10, l = 0))) +
    #theme(axis.text.x = element_text(size=13)) +
    theme(legend.title = element_text(face='bold', size=legend_title_size)) +
    theme(legend.text = element_text(size=legend_text_size)) +
    #theme(legend.position="none") +
    #geom_text(aes(y = ypos, label = label), color = "white", size=6) +
    scale_fill_manual('label', values=label_colours)
  
  # Q1 visualization
  ggplot(sentiment_by_week, aes(fill=label, y=freq, x=week)) + 
  geom_bar(position='stack', stat='identity') +
  theme_minimal() + 
  ggtitle("Average Sentiment of Tweets by Week") +
  labs(x='Week', y='Frequency') +
  theme(plot.title = element_text(hjust = 0.5, size=20, face='bold', margin = margin(t = 10, r = 0 , b = 10, l = 0))) +
  theme(axis.title.x = element_text(face='bold', size=15, margin = margin(t = 10, b = 10, r = 0, l = 0))) +
  theme(axis.title.y = element_text(face='bold', size=15, margin = margin(t = 0, b = 0, r = 10, l = 10))) +
  theme(axis.text.x = element_text(angle=30, size=13)) +
  theme(axis.text.y = element_text(size=13)) +
  theme(legend.title = element_text(face='bold', size=15)) +
  theme(legend.text = element_text(size=15)) +
  scale_x_continuous(breaks=c(1,3,7,11,15,19), labels=c("Dec 2021", "Jan 2022", "Feb 2022", "March 2022", "April 2022", "May 2022")) +
  scale_fill_manual('label', values=c('#d9534f', '#f0ad4e', '#5cb85c'))
}