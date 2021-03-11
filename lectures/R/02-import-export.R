## ---- vector
dept <- c("Physics", "Mathematics", "Statistics", "Computer Science")
nstaff <- c(12L, 8L, 20L, 23L)

## ---- lists
lst <- list( # list constructor/creator
  1:3, 
  "a", 
  c(TRUE, FALSE, TRUE), 
  c(2.3, 5.9)
)
lst

## ---- lists-type
typeof(lst) # primitive type

## ---- lists-cls
class(lst) # type + attributes

## ---- lists-str
str(lst)
# el can be of diff lengths

## ---- lists-rec
# a named list
str(list(first_el = lst, second_el = mtcars))

## ---- is-list
is.list(lst)

## ---- as-list
as.list(1:3)

## ---- lst-sub
lst[1]

## ---- lst-sub2
lst[[1]]

## ---- matrix
matrix(1:9, nrow = 3)

## ---- array
array(1:9, dim = c(1, 3, 3))

## ---- data-frame
sci_df <- data.frame(
  department = dept, 
  count = nstaff)
sci_df

## ---- df-type
typeof(sci_df)

## ---- df-cls
class(sci_df)

## ---- df-attrs
attributes(sci_df)

## ---- tibbles
library(tibble)
sci_tbl <- tibble(
  department = dept, 
  count = nstaff, 
  percentage = count / sum(count))
sci_tbl

## ---- tbl-type
typeof(sci_tbl) # list in essence
class(sci_tbl) # tibble is a special class of data.frame

## ---- glimpse
glimpse(sci_tbl) # to replace str()

## ---- subset-vct
sci_tbl[["count"]] # col name
sci_tbl[[2]] # col pos
sci_tbl$count # col name

## ---- subset-col1
sci_tbl["count"]

## ---- subset-col2
sci_tbl[2] # sci_tbl[, 2]

## ---- subset-row1
sci_tbl[c(1, 3), ]

## ---- subset-row2
sci_tbl[-c(2, 4), ]

## ---- subset-cr
sci_tbl[1:3, 2]
sci_tbl[-4, 2]
sci_tbl[1:3, "count"]
sci_tbl[c(rep(TRUE, 3), FALSE), 2]

## ---- read-csv
library(readr) # library(tidyverse)
pisa <- read_csv("data/pisa/pisa-student.csv", n_max = 2929621)
pisa

## ---- vroom
library(vroom)
pisa <- vroom("data/pisa/pisa-student.csv", n_max = 2929621)

## ---- excel
library(readxl)
time_use <- read_xlsx("data/time-use-oecd.xlsx")
time_use

## ---- skimr
library(skimr)
skim(time_use)

## ---- haven
library(haven)
pisa2018 <- read_spss("data/pisa/CY07_MSU_STU_QQQ.sav")

## ---- database
library(RSQLite)
con <- dbConnect(SQLite(), dbname = "data/pisa/pisa-student.db")
dbListTables(con)
dbListFields(con, "pisa")

## ---- db-read
pisa <- dbReadTable(con, "pisa")

## ---- db-query
res <- dbSendQuery(con, "SELECT * FROM pisa WHERE year = 2018")
pisa2018 <- dbFetch(res)

## ---- db-close
dbDisconnect(con)

## ---- chunked
chunked <- function(x, pos) {
  dplyr::filter(x, year == 2018)
}
pisa2018 <- read_csv_chunked("data/pisa/pisa-student.csv",
  callback = DataFrameCallback$new(chunked))

## ---- json
library(jsonlite)
url <- "https://vega.github.io/vega-editor/app/data/movies.json"
movies <- read_json(url)
length(movies)
movies[[1]]

## ---- json-df
movies_tbl <- as_tibble(read_json(url, simplifyVector = TRUE))
movies_tbl

## ---- sf
library(sf)
akl_bus <- st_read("data/BusService/BusService.shp")

## ---- sf-print
akl_bus[1:4, ]

## ---- sf-plot
library(ggplot2)
ggplot() +
  geom_sf(data = akl_bus, aes(colour = AGENCYNAME))

## ---- network
library(leaflet)
leaflet(data = st_transform(akl_bus, crs = 4326)) %>% 
  addTiles() %>% 
  addPolylines(
    weight = 2,
    popup = ~ paste("Routenumber:", ROUTENUMBE)
  )

## ---- write-movies
write_csv(movies_tbl, file = "data/movies.csv")
write_sas(movies_tbl, path = "data/movies.sas7bdat")
write_json(movies_tbl, path = "data/movies.json")
