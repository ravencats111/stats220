## ---- str-eg
library(tidyverse) # library(stringr)
string <- "lzDHk3orange2o5ghte"
string
fruit <- c("cherry", "banana")
fruit

## ---- str-c
c(string, fruit)
str_c(string, fruit, sep = ", ")
str_c(string, fruit, collapse = ", ")

## ---- str-detect
str_detect(string, "orange")
str_detect(fruit, "orange")

## ---- str-locate
str_locate(string, "orange")
str_locate(fruit, "orange")

## ---- str-extract
str_sub(string, 7, 12)
str_extract(string, "orange")
str_extract(fruit, "orange")

## ---- str-replace
str_replace(string, "orange", "apple")
str_replace(fruit, "orange", "apple")

## ---- str-dot
str_extract(string, "o....e")
str_extract_all(string, "o....e")

## ---- str-q
str_extract_all(string, "o.{4}e")
str_extract_all(string, "o.*e")
str_extract_all(string, "o.*?e")

## ---- escape
str_view_all(string, "o\\.{4}e")
str_view_all("a.b.c", "\\.")

## ---- meta
str_view_all(string, "\\d")
str_view_all(string, "[0-9]")

## ---- meta-upper
str_view_all(string, "\\D")
str_view_all(string, "[^0-9]")

## ---- posix
str_view_all(string, "[:digit:]")
str_view_all(string, "[:alpha:]")

## ---- anchor
str_view_all(fruit, "a")

## ---- anchor-end
str_view_all(fruit, "a$")

## ---- anchor-start
str_view_all(fruit, "^a")

## ---- gapminder
gapminder <- read_rds("data/gapminder.rds") %>% 
  group_by(country) %>% 
  slice_tail() %>% 
  ungroup()
gapminder

## ---- gapminder-dot
gapminder %>% 
  filter(str_detect(country, "i.a"))

## ---- gapminder-anchor
gapminder %>% 
  filter(str_detect(country, "i.a$"))

## ---- gapminder-handcls
gapminder %>% 
  filter(str_detect(country, "[nls]ia$"))

## ---- gapminder-negate
gapminder %>% 
  filter(str_detect(country, "[^nls]ia$"))

## ---- gapminder-punct
gapminder %>% 
  filter(str_detect(country, "[:punct:]"))

## ---- text
lyrics <- c("This will be an uncertain time for us my love",
            "I can hear the echo of your voice in my head",
            "Singing my love",
            "I can see your face there in my hands my love",
            "I have been blessed by your grace and care my love",
            "Singing my love")
text_tbl <- tibble(line = seq_along(lyrics), text = lyrics)
text_tbl

## ---- unnest-words
library(tidytext)
text_tbl %>%
  unnest_tokens(output = word, input = text)

## ---- unnest-words-count
text_tbl %>%
  unnest_tokens(output = word, input = text) %>% 
  count(word, sort = TRUE)

## ---- unnest-chrs
text_tbl %>%
  unnest_characters(output = word, input = text)

## ---- unnest-ngrams
text_tbl %>%
  unnest_ngrams(output = word, input = text, n = 2)

## ---- acnh
user_reviews <- read_tsv(
  "data/animal-crossing/user_reviews.tsv")
user_reviews

## ---- acnh-grade
user_reviews %>% 
  ggplot(aes(grade)) +
  geom_bar()

## ---- acnh-max
user_reviews %>% 
  slice_max(grade, 
    with_ties = FALSE) %>% 
  pull(text)

## ---- acnh-min
user_reviews %>% 
  slice_min(grade,
    with_ties = FALSE) %>% 
  pull(text)

## ---- acnh-token
user_reviews_words <- user_reviews %>% 
  mutate(text = str_remove(text, "Expand$")) %>% 
  unnest_tokens(output = word, input = text)
user_reviews_words

## ---- acnh-hist
user_reviews_words %>% 
  count(user_name) %>% 
  ggplot(aes(x = n)) +
  geom_histogram()

## ---- acnh-count
user_reviews_words %>%
  count(word, sort = TRUE)

## ---- stop-words
get_stopwords()

## ---- stop-words-rm
stopwords_smart <- get_stopwords(source = "smart")
user_reviews_smart <- user_reviews_words %>%
  anti_join(stopwords_smart)
user_reviews_smart

## ---- stop-words-smart
user_reviews_smart %>%
  count(word) %>%
  slice_max(n, n = 20) %>% 
  ggplot(aes(x = n, y = fct_reorder(word, n))) +
  geom_col() +
  labs(x = "", y = "",
    title = "Frequency of words in user reviews")

## ---- sentiments-l
get_sentiments("afinn")

## ---- sentiments-r
get_sentiments("loughran")

## ---- sentiments
sentiments_bing <- get_sentiments("bing")
sentiments_bing

## ---- join-sentiments
user_reviews_sentiments <- user_reviews_words %>%
  inner_join(sentiments_bing) %>%
  count(sentiment, word, sort = TRUE)
user_reviews_sentiments

## ---- plot-sentiments
user_reviews_sentiments %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>%
  ungroup() %>%
  ggplot(aes(x = n, y = fct_reorder(word, n), 
    fill = sentiment)) +
  geom_col() +
  facet_wrap(~ sentiment, scales = "free") +
  labs(x = "", y = "",
    title = "Sentiments in user reviews")

## ---- count-sentiments
user_reviews_sentiments %>% 
  group_by(sentiment) %>% 
  summarise(n = sum(n)) %>% 
  mutate(p = n / sum(n))
