## ---- lists
lst <- list( # list constructor/creator
  1:3, 
  "a", 
  c(TRUE, FALSE, TRUE), 
  c(2.3, 5.9)
)
lst

## ---- lists-type
typeof(lst)

## ---- lists-cls
class(lst)

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

## ---- tibbles
library(tibble)
sci_tbl <- tibble(
  department = dept, 
  count = nstaff, 
  percentage = count / sum(count))
sci_tbl

## ---- subsetting
sci_tbl$count
sci_tbl[["count"]]

sci_mat <- as.matrix(sci_tbl)
sci_mat
as_tibble(sci_mat)

sci_lst <- as.list(sci_tbl)
sci_lst
sci_lst$new_column <- sample(1:100, size = 5)
sci_lst
as_tibble(sci_lst)

# spreadsheet-like data
# data src: https://stats.oecd.org/Index.aspx?DataSetCode=TIME_USE#
# how individuals spend their time
# read from url
## excel files
library(readxl)
time_use <- read_xlsx("data/time-use-oced.xlsx")

library(skimr)
skim(time_use)
## plain-text rect files
library(readr)
## comma delmited files
pisa <- read_csv("data/pisa/pisa-student.csv")
write_csv(pisa, file = "data/pisa/pisa-student-copy.csv")
## fixed width files
## foreign formats
# data src: https://www.oecd.org/pisa/data/
library(haven)
pisa2018 <- read_spss("data/pisa/CY07_MSU_STU_QQQ.sav")

## database
library(DBI)
con <- dbConnect(RSQLite::SQLite(), dbname = "data/pisa/pisa-student.db")
dbListTables(con)
dbListFields(con, "pisa")
pisa <- dbReadTable(con, "pisa", pisa)
res <- dbSendQuery(con, "SELECT * FROM pisa WHERE year = 2018")
pisa2018 <- as_tibble(dbFetch(res))
dbDisconnect(con)

## faster reading
library(vroom)
pisa <- vroom("data/pisa/pisa-student.csv")

## larger than memory
chunked <- function(x, pos) {
  dplyr::filter(x, year == 2018)
}
pisa2018 <- read_csv_chunked("data/pisa/pisa-student.csv",
  callback = DataFrameCallback$new(chunked))

## hierarchical data: json
library(jsonlite)
movies <- read_json("data/movies.json")
length(movies)
movies[[1]]

## spatial data
library(sf)
akl_bus <- st_read("data/BusService/BusService.shp")

## audio
## midi
