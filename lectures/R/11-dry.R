library(tidyverse)

covid_0301 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-01-2020.csv")
covid_0302 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-02-2020.csv")
covid_0303 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-03-2020.csv")
covid_0304 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-04-2020.csv")
covid_0305 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-05-2020.csv")

library(lubridate)
dates <- seq(mdy("03-01-2020"), by = 1, length.out = 92)
dates_chr <- format(dates, "%m-%d-%Y")
urls <- glue::glue("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/{dates_chr}.csv")

covid19_raw <- map_dfr(
  urls, # `Last_Update`/`Last Update`
  function(.x) {
    data <- read_csv(.x, 
      col_types = cols(Last_Update = "_", `Last Update` = "_"))
    rename_with(data, janitor::make_clean_names)
  },
  .id = "id")
date_tbl <- tibble(id = as.character(seq_along(dates)), date = dates)

covid19 <- covid19_raw %>% 
  left_join(date_tbl) %>% 
  select(date, everything(), -id) %>% 
  group_by(country_region, date) %>% 
  summarise(confirmed = sum(confirmed, na.rm = TRUE)) %>% 
  ungroup() %>% 
  drop_na(country_region)
