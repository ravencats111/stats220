library(tidyverse)
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
covid19_raw
(date_tbl <- tibble(id = as.character(seq_along(dates)), date = dates))

covid19 <- covid19_raw %>% 
  left_join(date_tbl) %>% 
  select(date, everything(), -id) %>% 
  mutate(country_region = case_when(
    country_region == "Mainland China"~ "China", 
    TRUE ~ country_region)) %>% 
  group_by(country_region, date) %>% 
  summarise(confirmed = sum(confirmed, na.rm = TRUE)) %>% 
  ungroup() %>% 
  drop_na(country_region)
write_csv(covid19, "data/covid19-daily-cases.csv")
