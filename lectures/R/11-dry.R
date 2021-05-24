## ---- covid-03
library(tidyverse) # library(purrr)
covid_0301 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-01-2020.csv")
covid_0302 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-02-2020.csv")
covid_0303 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/03-03-2020.csv")
(covid_03 <- bind_rows(covid_0301, covid_0302, covid_0303))

## ---- covid-1231
covid_1231 <- read_csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/12-31-2020.csv")
covid_1231

## ---- make-url
make_url <- function(date) {
  date_chr <- format(date, "%m-%d-%Y")
  setNames(glue::glue("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/{date_chr}.csv"),
  date_chr)
}

## ---- test-make-url
library(lubridate)
dates <- seq(mdy("03-01-2020"), mdy("12-31-2020"), by = 1)
urls <- make_url(dates)
head(urls, 2)
tail(urls, 2)

## ---- read-covid19
read_covid19 <- function(url) {
  data <- read_csv(url, 
    col_types = cols(Last_Update = "_", `Last Update` = "_"))
  rename_with(data, janitor::make_clean_names)
}
read_covid19(urls[1])

## ---- read-covid19-hand
covid19_csv1 <- read_covid19(urls[1])
covid19_csv2 <- read_covid19(urls[2])
covid19_csv3 <- read_covid19(urls[2])
covid19_csv4 <- read_covid19(urls[4])
covid19_csv5 <- read_covid19(urls[5])
covid19_csv6 <- read_covid19(urls[6])
covid19_csv6 <- read_covid19(urls[7])
covid19_csv8 <- read_covid19(urls[8])
covid19_csv9 <- read_covid19(urls[9])

## ---- map
covid19_lst <- map(urls, read_covid19)
covid19_lst[[length(covid19_lst)]]

## ---- map-lamda
covid19_lst <- map(urls, read_covid19)
covid19_lst <- map(urls, ~ read_covid19(.x))
covid19_lst <- map(urls, function(.x) read_covid19(.x))

## ---- bind-rows
bind_rows(covid19_lst)

## ---- map2
covid19_lst <- map2(urls, dates, #<<
  ~ read_covid19(.x) %>% mutate(date = .y))
bind_rows(covid19_lst)

## ---- map-dfr
covid19_raw <- map_dfr(urls, read_covid19, .id = "date")
covid19_raw

## ---- clean-country
covid19_bystate <- covid19_raw %>% 
  select(date, country_region:recovered) %>% 
  mutate(
    date = mdy(date),
    country_region = case_when(
      country_region == "Korea, South" ~ "South Korea",
      country_region == "Mainland China" ~ "China",
      TRUE ~ country_region)
  )
covid19_bystate

## ---- manual-col
covid19_byregion <- covid19_bystate %>% 
  group_by(country_region, date) %>% 
  summarise(
    confirmed = sum(confirmed, na.rm = TRUE), #<<
    deaths = sum(deaths, na.rm = TRUE), #<<
    recovered = sum(recovered, na.rm = TRUE) #<<
  ) %>% 
  mutate(
    new_confirmed = confirmed - lag(confirmed, na.rm = TRUE), #<<
    new_deaths = deaths - lag(deaths, na.rm = TRUE), #<<
    new_recovered = recovered - lag(recovered, na.rm = TRUE) #<<
  ) %>% 
  ungroup()

## ---- across
covid19_byregion <- covid19_bystate %>% 
  group_by(country_region, date) %>% 
  summarise(
    across( #<<
      confirmed:recovered, #<<
      sum, na.rm = TRUE) #<<
  ) %>% 
  mutate(
    across( #<<
      confirmed:recovered, #<<
      ~ .x - lag(.x, na.rm = TRUE), #<<
      .names = "new_{.col}")#<<
  ) %>% 
  ungroup()

## ---- across-where
covid19_byregion <- covid19_bystate %>% 
  group_by(country_region, date) %>% 
  summarise(
    across( #<<
      where(is.numeric),  #<<
      sum, na.rm = TRUE) #<<
  ) %>% 
  mutate(
    across( #<<
      where(is.numeric),  #<<
      ~ .x - lag(.x, na.rm = TRUE),  #<<
      .names = "new_{.col}") #<<
  ) %>% 
  ungroup()

## ---- covid19-byregion
covid19_byregion

## ---- covid19-nest
covid19_lstcol <- covid19_byregion %>% 
  nest(data = -country_region)
covid19_lstcol

## ---- covid19-au
covid19_au <- covid19_lstcol$data[[10]]
covid19_au

## ---- covid19-au-fit
fit_au <- lm(new_recovered ~ lag(new_confirmed, n = 14), 
  data = covid19_au)
fit_au
slope_au <- coef(fit_au)[2]
slope_au

## ---- extract-slope
extract_slope <- function(data) {
  fit <- lm(new_recovered ~ lag(new_confirmed, n = 14), data)
  coef(fit)[2]
}

## ---- map-slope
covid19_lstcol$data %>% 
  map(extract_slope)

## ---- safely-slope
safely_extract_slope <- safely(extract_slope, 
  otherwise = NA_real_)
covid19_lstcol$data %>% map(safely_extract_slope)

## ---- safely-result-lst
covid19_lstcol$data %>% 
  map(safely_extract_slope) %>% 
  map("result")

## ---- safely-result-dbl
covid19_lstcol$data %>% 
  map(safely_extract_slope) %>% 
  map_dbl("result")

## ---- mutate-map
covid19_lstcol %>% 
  mutate(
    slopes = map(data, safely_extract_slope) %>% 
      map_dbl("result"))

## ---- group-split
covid19_lst <- covid19_byregion %>% 
  group_by(country_region) %>% 
  group_split()
covid19_lst[[1]]

## ---- walk2
region_names <- unique(covid19_byregion$country_region)
file_name <- glue::glue("data/covid19/{region_names}.csv")
# fs::dir_create("data/covid19")
walk2(covid19_lst, file_name, write_csv)

## ---- map-dfr-disk
library(fs)
covid19_local <- map_dfr(
  dir_ls("data/covid19", glob = "*.csv"), read_csv)
covid19_local
