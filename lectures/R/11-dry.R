library(glue)
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
  setNames(glue("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_daily_reports/{date_chr}.csv"),
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

# 3 ways to use functions
covid19_raw <- map_dfr(urls, read_covid19, .id = "date")
covid19_raw
unique(covid19_raw$country_region)

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

covid19_byregion <- covid19_bystate %>% 
  group_by(country_region, date) %>% 
  summarise(
    confirmed = sum(confirmed, na.rm = TRUE),
    deaths = sum(deaths, na.rm = TRUE),
    recovered = sum(recovered, na.rm = TRUE)
  ) %>% 
  mutate(
    new_confirmed = confirmed - lag(confirmed, na.rm = TRUE),
    new_deaths = deaths - lag(deaths, na.rm = TRUE),
    new_recovered = recovered - lag(recovered, na.rm = TRUE)
  ) %>% 
  ungroup()
covid19_byregion

covid19_byregion <- covid19_bystate %>% 
  group_by(country_region, date) %>% 
  summarise(
    across(confirmed:recovered, sum, na.rm = TRUE) # ~ sum(.x, na.rm = TRUE)
  ) %>% 
  mutate(
    across(confirmed:recovered, ~ .x - lag(.x, na.rm = TRUE), 
      .names = "new_{.col}")
  ) %>% 
  ungroup()

covid19_byregion <- covid19_bystate %>% 
  group_by(country_region, date) %>% 
  summarise(
    across(where(is.numeric), sum, na.rm = TRUE)
  ) %>% 
  mutate(
    across(where(is.numeric), ~ .x - lag(.x, na.rm = TRUE), 
      .names = "new_{.col}")
  ) %>% 
  ungroup()

covid19_lst <- covid19_byregion %>% 
  nest(data = -country_region)

(covid19_au <- covid19_lst$data[[10]])
(fit_au <- lm(new_recovered ~ lag(new_confirmed, n = 14), covid19_au))
(slope_au <- coef(fit_au)[2])

extract_slope <- function(data) {
  fit <- lm(new_recovered ~ lag(new_confirmed, n = 14), data)
  coef(fit)[2]
}

covid19_lst$data %>% 
  map(extract_slope)

safely_extract_slope <- safely(extract_slope, otherwise = NA_real_)

covid19_lst$data %>% 
  map(safely_extract_slope)

covid19_lst$data %>% 
  map(safely_extract_slope) %>% 
  map("result")

slopes <- covid19_lst$data %>% 
  map(safely_extract_slope) %>% 
  map_dbl("result")
slopes

covid19_lst %>% 
  mutate(slopes = slopes)

covid19_lst %>% 
  mutate(slopes = map(data, safely_extract_slope) %>% map_dbl("result"))
