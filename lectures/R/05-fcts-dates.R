library(tidyverse)
dept <- c("Physics", "Mathematics", "Statistics",
  "Computer Science")
nstaff <- c(12L, 8L, 20L, 23L)
sci_tbl <- tibble(dept = dept, count = nstaff)
sci_tbl

class(dept)
sort(dept)

(dept_fct <- factor(dept))
class(dept_fct)
typeof(dept_fct)
levels(dept_fct)

factor(dept, levels = dept)

factor(dept, levels = rev(dept))

rep(dept_fct, 3)

library(forcats)

sci_tbl %>% 
  ggplot(aes(dept, count)) +
  geom_col()

sci_tbl %>% 
  mutate(dept = fct_reorder(dept, count)) %>% 
  pull(dept)

sci_tbl %>% 
  mutate(dept = fct_reorder(dept, count)) %>% 
  ggplot(aes(dept, count)) +
  geom_col()

sci_tbl %>% 
  mutate(dept = fct_inorder(dept)) %>% 
  ggplot(aes(dept, count)) +
  geom_col()

movies <- as_tibble(jsonlite::read_json(
  "https://vega.github.io/vega-editor/app/data/movies.json",
  simplifyVector = TRUE))

movies %>% 
  ggplot(aes(Major_Genre, Rotten_Tomatoes_Rating)) +
  geom_boxplot()

movies %>% 
  mutate(
    Major_Genre = fct_reorder(Major_Genre, Rotten_Tomatoes_Rating,
      .fun = median, na.rm = TRUE)) %>% 
  ggplot(aes(Major_Genre, Rotten_Tomatoes_Rating)) +
  geom_boxplot()

movies %>% 
  count(Major_Genre) %>% 
  ggplot(aes(Major_Genre, n)) +
  geom_col()

movies %>% 
  mutate(
    Major_Genre = fct_lump_n(Major_Genre, 5),
    Major_Genre = fct_reorder(Major_Genre, -n)
  ) %>% 
  count(Major_Genre) %>% 
  ggplot(aes(Major_Genre, n)) +
  geom_col()
