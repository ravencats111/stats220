library(tidyverse)
text <- c("This will be an uncertain time for us my love",
          "I can hear the echo of your voice in my head",
          "Singing my love",
          "I can see your face there in my hands my love",
          "I have been blessed by your grace and care my love",
          "Singing my love")
text

text_tbl <- tibble(line = seq_along(text), text = text)
text_tbl

library(tidytext)
text_tbl %>%
  unnest_tokens(output = word, input = text, token = "words")

text_tbl %>%
  unnest_tokens(output = word, input = text, token = "characters")

text_tbl %>%
  unnest_tokens(output = word, input = text, token = "ngrams", n = 2)

user_reviews <- read_tsv("data/animal-crossing/user_reviews.tsv")

user_reviews %>% 
  slice_max(grade) %>% 
  slice_head() %>% 
  pull(text)

user_reviews %>% 
  slice_min(grade) %>% 
  slice_head() %>% 
  pull(text)

user_reviews_parsed <- user_reviews %>% 
  mutate(text = str_remove(text, "Expand$"))

user_reviews_words <- user_reviews_parsed %>%
  unnest_tokens(output = word, input = text)

user_reviews_words %>% 
  count(user_name) %>% 
  ggplot(aes(x = n)) +
  geom_histogram()

user_reviews_words %>%
  count(word, sort = TRUE)

get_stopwords()

stopwords_smart <- get_stopwords(source = "smart")

user_reviews_words %>%
  anti_join(stopwords_smart)

user_reviews_words %>%
  anti_join(stopwords_smart) %>%
  count(word) %>%
  arrange(-n) %>%
  top_n(20) %>%
  ggplot(aes(fct_reorder(word, n), n)) +
  geom_col() +
  coord_flip() +
  theme_minimal() +
  labs(title = "Frequency of words in user reviews",
       subtitle = "",
       y = "",
       x = "")

sentiments_bing <- get_sentiments("bing")
user_reviews_words %>%
  inner_join(sentiments_bing) %>%
  count(sentiment, word, sort = TRUE)

user_reviews_words %>%
  inner_join(sentiments_bing) %>%
  count(sentiment, word, sort = TRUE) %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  ggplot(aes(fct_reorder(word, n), n, fill = sentiment)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~sentiment, scales = "free") +
  theme_minimal() +
  labs(
    title = "Sentiments in user reviews",
    x = ""
  )
