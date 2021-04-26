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

## ---- regex
# metacharacter
# a lowercase letter will select any of the things it stands for (so \\d selects any digit, while \\s will select any blank space)
# an uppercase letter will select everything BUT that thing (so \\D doesn’t select digits, \\S will erase blank spaces, and so on)
# Split a string based on a match.
str_split(string, "\\d") # metacharacter
str_split(string, "[:digit:]") # POSIX class
str_view(string, "\\d")
str_split(string, "\\D")

str_extract(string, "o....e")
str_extract_all(string, "o....e")
# Quantifiers
str_extract_all(string, "o.{4}e")
str_extract_all(string, "o\\D{4}e")
str_view_all(string, "o\\D{4}e")
# *: as many times as it shows up
str_extract_all(string, "o.*e")
str_extract_all(string, "o.*?e")
str_view_all(string, "o.*?e")

gapminder <- read_rds("data/gapminder.rds")
countries <- levels(gapminder$country)

str_subset(countries, "i.a")
# Anchors can be included to express where the expression must occur within the string. The ^ indicates the beginning of string and $ indicates the end.
# Characters with special meaning
str_subset(countries, "i.a$")

# Character classes
# one of the characters in the class
str_subset(countries, pattern = "[nls]ia$")
# use ^ to negate the class
str_subset(countries, pattern = "[^nls]ia$")
str_subset(countries, pattern = "[:punct:]")


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
