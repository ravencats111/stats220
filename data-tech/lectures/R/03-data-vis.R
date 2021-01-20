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
