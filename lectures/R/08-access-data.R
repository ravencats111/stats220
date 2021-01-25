library(tidyverse)

covid_zip <- "data/csse_covid_19_daily_reports.zip"
csv_df <- unzip(covid_zip, list = TRUE)
csv_tb <- as_tibble(csv_df)

csv_df
csv_tb

csv_tb[[1]]
csv_tb[["Name"]]
csv_tb$Name
csv_tb$Na
csv_df$Na
csv_tb[, 1]
csv_df[, 1]
csv_tb[-c(1, nrow(csv_tb)), ]
csv_tb[-c(1, nrow(csv_tb)), 1]

covid_0122 <- read_csv(unz(covid_zip, "01-22-2020.csv"))
covid_0122 %>% 
  rename_all(janitor::make_clean_names)

library(lubridate)
covid_0122 %>% 
  rename_all(janitor::make_clean_names) %>% 
  mutate(
    last_update = mdy_hm(last_update),
    date = as_date(last_update),
    confirmed = replace_na(confirmed, 0),
    deaths = replace_na(confirmed, 0),
    recovered = replace_na(recovered, 0)
  )

covid_clean <- covid_0122 %>% 
  rename_all(janitor::make_clean_names) %>% 
  mutate(last_update = mdy_hm(last_update), date = as_date(last_update)) %>% 
  filter(!is.na(confirmed)) %>% 
  mutate_at(vars(deaths, recovered), ~ replace_na(., 0)) %>% 
  select(-last_update)

covid_clean %>% 
  summarise(
    total_confirmed = sum(confirmed),
    total_deaths = sum(deaths),
    total_recovered = sum(recovered)
  )

covid_clean %>% 
  summarise_at(vars(confirmed:recovered), sum)

covid_clean %>% 
  group_by(country_region) %>% 
  summarise_at(vars(confirmed:recovered), sum)

covid_0122 %>% 
  mutate(`Last Update` = mdy_hm(`Last Update`))
covid_0122 <- read_csv(unz(covid_zip, "01-22-2020.csv"),
  col_types = cols(`Last Update` = col_datetime(format = "%m/%d/%Y %H:%M")))
covid_0222 <- read_csv(unz(covid_zip, "02-22-2020.csv"),
  col_types = cols(`Last Update` = col_datetime(format = "%m/%d/%Y %H:%M:%S")))
covid_0122
glimpse(covid_0122)
covid_0222

library(stringr)
csv_names <- csv_tb$Name
str_ends(csv_names, "csv")

covid_data <- map_dfr(csv_names[str_ends(csv_names, "csv")], 
   ~ read_csv(unz(covid_zip, .)), .id = "file")

covid_data
