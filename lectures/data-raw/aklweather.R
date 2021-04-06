## code to prepare `aklweather` dataset goes here
library(tidyverse)
library(lubridate)
# Read stations data
stations <- read_table("data/ghcnd/ghcnd-stations.txt",
  col_names = c("id", "lat", "lon"))

library(ggmap)
akl_box <- c(left = 174.69, bottom = -37.09, right = 174.94, top = -36.60)
akl_map <- get_map(akl_box)
ggmap(akl_map) +
  geom_point(aes(x = lon, y = lat), stations)

akl_id <- stations %>%
  filter(akl_box["left"] < lon, lon < akl_box["right"],
    akl_box["bottom"] < lat, lat < akl_box["top"])

library(rnoaa)
startdate <- make_date(2019) + days(251) * 0:15
enddate <- startdate - days(1)
enddate <- c(enddate[-1], today())
akl_ncdc <- map2_dfr(startdate, enddate, function(x, y) {
  ncdcout <- ncdc(datasetid = "GHCND",
    stationid = paste0("GHCND:", akl_id$id), limit = 1000,
    startdate = x, enddate = y)
  ncdcout$data
})
aklweather <- akl_ncdc %>%
  mutate(date = as_date(ymd_hms(date))) %>%
  rename_with(tolower)
write_csv(aklweather, "data/ghcnd/ghcnd-akl.csv")
