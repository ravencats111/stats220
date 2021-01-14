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
# el can be of diff lengths
str(lst)

## ---- lists-rec
str(list(first_el = lst, second_el = mtcars))

## ---- is-list
is.list(lst)

## ---- as-list
as.list(1:3)

## ---- matrix
matrix(1:9, nrow = 3)

## ---- array
array(1:9, dim = c(1, 3, 3))

## ---- data-frame
dept <- c("Physics", "Mathematics", "Statistics",
  "Computer Science")
nstaff <- c(12L, 8L, 20L, 23L)
sci_df <- data.frame(department = dept, count = nstaff)
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

## ---- subsetting
sci_tbl$count
sci_tbl[["count"]]

# spreadsheet-like data
# data src: https://stats.oecd.org/Index.aspx?DataSetCode=TIME_USE#
# how individuals spend their time
# read from url

## ---- read-csv
library(readr) # or library(tidyverse)
pisa <- read_csv("data/pisa/pisa-student.csv", n_max = 2929621)
pisa

## ---- vroom
library(vroom)
pisa <- vroom("data/pisa/pisa-student.csv", n_max = 2929621)

## ---- excel
library(readxl)
time_use <- read_xlsx("data/time-use-oced.xlsx")
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
movies <- read_json("data/movies.json")
length(movies)
movies[[1]]

## ---- sf
## spatial data
library(sf)
akl_bus <- st_read("data/BusService/BusService.shp")

## audio
## midi
