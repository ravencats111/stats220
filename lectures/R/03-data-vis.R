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
p <- ggplot(sci_tbl, aes(x = dept, y = count)) #<<
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

## ---- gg-bar-asis
ggplot(sci_tbl, aes(x = dept, y = count)) +
  geom_bar(stat = "identity")

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

## ---- gg-bar-both
p +
  geom_col(aes(fill = dept), colour = "#000000")

## ---- bubble-chart
p +
  geom_point(aes(size = count))

## ---- gg-arc
p +
  geom_col(aes(fill = dept)) +
  coord_polar(theta = "y") #<<

## ---- gg-theme-bw
p +
  geom_col(aes(fill = dept)) +
  theme_bw() #<<

## ---- ggthemes
library(ggthemes)
p +
  geom_col(aes(fill = dept)) +
  theme_economist() #<<

## ---- gg-theme
p +
  geom_col(aes(fill = dept)) +
  theme(axis.text.x = element_text(angle = 30, vjust = 0.1))

## ---- mpg
mpg

## ---- gg-mpg
p_mpg <- ggplot(mpg, aes(displ, cty)) + 
  geom_point(aes(colour = drv))
p_mpg

## ---- gg-facet-rows
p_mpg +
  facet_grid(rows = vars(drv))
  # facet_grid(~ drv)

## ---- gg-facet-cols
p_mpg +
  facet_grid(cols = vars(drv))
  # facet_grid(drv ~ .)

## ---- gg-facet-grid
p_mpg +
  facet_grid(rows = vars(drv), cols = vars(cyl))
  # facet_grid(cyl ~ drv)

## ---- gg-facet-wrap
p_mpg +
  facet_wrap(vars(drv, cyl), ncol = 3)
  # facet_wrap(~ drv + cyl, ncol = 3)

## ---- movies
movies <- as_tibble(jsonlite::read_json(
  "https://vega.github.io/vega-editor/app/data/movies.json",
  simplifyVector = TRUE))
movies

## ---- skim-movies
skimr::skim(movies)

## ---- movies-gam
ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_point(size = 0.5, alpha = 0.5) +
  geom_smooth(method = "gam") +
  theme(aspect.ratio = 1)

## ---- movies-hex
ggplot(movies, aes(x = IMDB_Rating, y = Rotten_Tomatoes_Rating)) +
  geom_hex() +
  theme(aspect.ratio = 1)

## ---- movies-bar
ggplot(movies, aes(y = Major_Genre)) +
  geom_bar()

## ---- movies-boxplot
ggplot(movies) +
  geom_boxplot(aes(x = IMDB_Rating, y = Major_Genre))

## ---- movies-density
ggplot(movies) +
  geom_density(aes(x = IMDB_Rating, fill = Major_Genre))

## ---- movies-ridges
library(ggridges)
ggplot(movies, aes(x = IMDB_Rating, y = Major_Genre)) +
  geom_density_ridges(aes(fill = Major_Genre))

## ---- movies-facet
ggplot(movies) +
  geom_density(aes(x = IMDB_Rating, fill = Major_Genre)) +
  facet_wrap(vars(Major_Genre))
