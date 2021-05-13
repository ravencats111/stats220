library(lubridate)
library(tidyverse)

covid_0301 <- read_csv("https://github.com/cssegisanddata/covid-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-01-2020.csv")
covid_0302 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-02-2020.csv")
covid_0303 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-03-2020.csv")
covid_03 <- bind_rows(covid_0301, covid_0302, covid_0303)
covid_03

covid_1231 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/12-31-2020.csv")
covid_1231

make_url <- function(date) {
  date_chr <- format(date, "%m-%d-%Y")
  setNames(glue::glue("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/{date_chr}.csv"),
  date_chr)
}

dates <- seq(mdy("03-01-2020"), mdy("12-31-2020"), by = 1)
urls <- make_url(dates)
head(urls, 3)
tail(urls, 3)

read_covid19 <- function(url) {
  # `Last_Update`/`Last Update`
  data <- read_csv(url, 
    col_types = cols(Last_Update = "_", `Last Update` = "_"))
  rename_with(data, janitor::make_clean_names)
}

covid19_raw <- map_dfr(urls, read_covid19, .id = "date")
date_tbl <- tibble(id = as.character(seq_along(dates)), date = dates)

covid19 <- covid19_raw %>% 
  left_join(date_tbl) %>% 
  select(date, everything(), -id) %>% 
  group_by(country_region, date) %>% 
  summarise(confirmed = sum(confirmed, na.rm = TRUE)) %>% 
  ungroup() %>% 
  drop_na(country_region)

# across
# function
# for-loop
