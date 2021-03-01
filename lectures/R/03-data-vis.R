## ---- numbers
library(datasauRus)
library(tidyverse)
dino <- datasaurus_dozen %>% 
  filter(dataset == "dino") %>% 
  select(-dataset)
dino

## ---- plots
dino %>% 
  ggplot(aes(x, y)) +
  geom_point()

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
p <- ggplot(sci_tbl, aes(x = dept, y = count))
p

## ---- gg-bar
p + 
  geom_bar(stat = "identity")

## ---- gg-col2
p + 
  geom_col()

## ---- gg-point
p +
  geom_point()

## ---- gg-seg
p +
  geom_segment(aes(xend = dept, y = 0, yend = count))

## ---- gg-pop
p +
  geom_point() +
  geom_segment(aes(xend = dept, y = 0, yend = count))

## ---- sci-disaggregated
sci_tbl0 <- uncount(sci_tbl, count)
sci_tbl0

## ---- gg-bar-c
ggplot(sci_tbl0, aes(x = dept)) +
  geom_bar(stat = "count")

## ---- gg-bar-col
p +
  geom_col(aes(colour = dept))

## ---- gg-bar-fill
p +
  geom_col(aes(fill = dept))

## ---- gg-bar-fill-str
p +
  geom_col(fill = "#756bb1")

## ---- gg-arc
p +
  geom_col(aes(fill = dept)) +
  coord_polar(theta = "y")

## ---- gg-theme
p +
  geom_col(aes(fill = dept)) +
  theme(axis.text.x = element_text(angle = 90))

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
