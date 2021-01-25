## ---- toy-df
library(tidyverse)
dept <- c("Physics", "Mathematics", "Statistics",
  "Computer Science")
nstaff <- c(12L, 8L, 20L, 23L)
sci_tbl <- tibble(dept = dept, count = nstaff)
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

## ---- gg-layer
ggplot(data = sci_tbl, mapping = aes(x = dept, y = count)) +
  layer(geom = "bar", stat = "identity", position = "identity")

## ---- aes-map
ggplot(sci_tbl, aes(x = dept, y = count))

## ---- gg-bar
ggplot(sci_tbl, aes(x = dept, y = count)) +
  geom_bar(stat = "identity")

## ---- gg-col2
ggplot(sci_tbl, aes(x = dept, y = count)) +
  geom_col()

## ---- sci-disaggregated
sci_tbl0 <- uncount(sci_tbl, count)
sci_tbl0

## ---- gg-bar-c
ggplot(sci_tbl0, aes(x = dept)) +
  geom_bar(stat = "count")

## ---- gg-bar-col
ggplot(sci_tbl, aes(x = dept, y = count)) +
  geom_col(aes(colour = dept))

## ---- gg-bar-fill
ggplot(sci_tbl, aes(x = dept, y = count)) +
  geom_col(aes(fill = dept))

## ---- gg-arc
ggplot(sci_tbl, aes(x = dept, y = count)) +
  geom_col(aes(fill = dept)) +
  coord_polar(theta = "y")

## ---- gg-movies
movies <- as_tibble(jsonlite::read_json(
  "https://vega.github.io/vega-editor/app/data/movies.json",
  simplifyVector = TRUE))

ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_point()

ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_point() +
  geom_smooth(method = "gam")

ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_hex()

ggplot(movies, aes(x = Major_Genre)) +
  geom_bar() +
  coord_flip()

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
