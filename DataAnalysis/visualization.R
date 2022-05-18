
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
  
}