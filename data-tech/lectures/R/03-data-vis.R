## ---- toy-df
library(tidyverse)
dept <- c("Physics", "Mathematics", "Statistics",
  "Computer Science")
nstaff <- c(12L, 8L, 20L, 23L)
sci_tbl <- tibble(
  dept = dept, 
  count = nstaff, 
  percentage = count / sum(count))
sci_tbl

## ---- base-barplot
barplot(as.matrix(sci_tbl$count), 
  legend = sci_tbl$dept)

## ---- base-pieplot
pie(sci_tbl$count, 
  labels = sci_tbl$dept)

## ---- gg-col
library(ggplot2)
ggplot(data = sci_tbl) +
  geom_bar(
    aes(x = "", y = count, fill = dept),
    stat = "identity"
  )

## ---- gg-pie
ggplot(data = sci_tbl) +
  geom_bar(
    aes(x = "", y = count, fill = dept),
    stat = "identity"
  ) +
  coord_polar(theta = "y") #<<

movies <- as_tibble(jsonlite::read_json(
  "https://vega.github.io/vega-editor/app/data/movies.json",
  simplifyVector = TRUE))

ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_point()

ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_point() +
  geom_smooth(method = "gam")

ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_point(colour = "#3182bd")

ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_point(aes(colour = Major_Genre))

ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_hex()

ggplot(movies) +
  geom_boxplot(aes(x = Major_Genre, y = IMDB_Rating))

ggplot(movies) +
  geom_density(aes(x = IMDB_Rating, fill = Major_Genre))

library(ggridges)
ggplot(movies, aes(x = IMDB_Rating, y = Major_Genre)) +
  geom_density_ridges(aes(fill = Major_Genre))

ggplot(movies, aes(x = IMDB_Rating, y = Major_Genre)) +
  geom_density_ridges(aes(colour = Major_Genre, fill = Major_Genre))

ggplot(movies) +
  geom_density(aes(x = IMDB_Rating, fill = Major_Genre)) +
  facet_wrap(vars(Major_Genre))
