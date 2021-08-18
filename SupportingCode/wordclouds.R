library(tidyr)
library(dplyr)
library(stringr)
library(ggplot2)
# Clean the track names: (), - and []
track <- spotify$track[spotify$label=="after"] %>% str_remove_all(" \\s*\\([^\\)]+\\)") %>%
  str_remove_all(" \\-.*") %>%
  str_remove_all(" \\s*\\[[^\\)]+\\]")
m <- length(track)


#sentiment analysis of track titles
library(tidytext)
track_df <- tibble(line = 1:m, text = track)
track_sentiment <- track_df %>%
  unnest_tokens(word,text) %>%
  inner_join(get_sentiments("bing")) %>%
  count(line, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)
nrow(track_sentiment) # among 765 tracks, 230 have words fall in sentiment lexicon "bing"
sentiment <- track_sentiment$sentiment
ggplot(as.data.frame(table(sentiment)), aes(x=sentiment, y = Freq)) + 
  geom_bar(stat="identity", fill = "steelblue") +
  geom_text(aes(label=Freq), vjust=-0.3, size=3.5)+
  ggtitle("Sentiment score of 230 track titles") +
  xlab("score") +
  ylab("count") +
  theme_minimal()


# wordcloud
library(wordcloud)
word_count <- track_df %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  count(word) 
head(word_count[order(word_count$n, decreasing = TRUE),],10)
word_count %>%
  with(wordcloud(word, n, max.words = 100))

