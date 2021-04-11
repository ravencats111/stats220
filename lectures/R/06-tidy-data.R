## ---- movies
library(tidyverse)
movies <- as_tibble(jsonlite::read_json(
  "https://vega.github.io/vega-editor/app/data/movies.json",
  simplifyVector = TRUE))

movies %>% 
  relocate(Release_Date, US_DVD_Sales) %>% 
  slice(37:39, 268:269) %>% 
  print(width = 80)

## ---- timeuse
library(readxl)
time_use <- read_xlsx("data/time-use-oecd.xlsx") %>% 
  rename_with(~ c("country", "category", "minutes")) %>% 
  filter(country %in% c("New Zealand", "USA")) %>% 
  print(width = 40)

## ---- country
country_code <- read_csv("data/countrycode.csv") %>% 
  filter(country_name %in% c("New Zealand", "United States")) %>% 
  print()

## ---- tb
tb <- read_csv("data/tb.csv") %>% 
  print(width = 80)

## ---- tb-pivot
library(tidyverse) # library(tidyr)
tb %>% 
  pivot_longer(
    cols = m_04:f_u, # cols in the data for pivoting #<<
    names_to = "sex_age", # new col contains previous headers #<<
    values_to = "cases") # new col contains previous values #<<

## ---- tb-sep
tb %>% 
  pivot_longer(cols = m_04:f_u, 
    names_to = "sex_age", values_to = "cases") %>% 
  separate(sex_age, into = c("sex", "age"), sep = "_") #<<

## ---- tb-fill
tb_tidy <- tb %>% 
  pivot_longer(cols = m_04:f_u, 
    names_to = "sex_age", values_to = "cases") %>% 
  separate(sex_age, into = c("sex", "age"), sep = "_") %>% 
  group_by(iso2) %>% 
  fill(cases, .direction = "updown") %>% #<<
  ungroup()
tb_tidy

## ---- tb-nest
tb_tidy %>% 
  nest(data = year:cases)

## ---- tb-mod
tb_fit <- tb_tidy %>% 
  nest(data = year:cases) %>% 
  mutate( # below for week 11
    model = map(data, lm),
    intercept = map_dbl(model, ~ coef(.)[1]),
    slope = map_dbl(model, ~ coef(.)[2])
  )
tb_fit
  
## ---- tb-mod-plot
tb_fit %>% 
  ggplot(aes(x = fct_reorder(iso2, slope), y = slope)) +
  geom_hline(yintercept = 0, size = 0.8, colour = "grey") +
  geom_point(aes(colour = slope < 0), size = 0.8) +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 90, size = 5),
    legend.position = "top"
  )

## ---- aklweather
aklweather <- read_csv2("data/ghcnd/ghcnd-akl.csv",
  col_types = cols_only(date = "D", datatype = "c", value = "d"))
aklweather

## ---- akl-pivot
aklweather %>%
  mutate(value = value / 10) %>% 
  pivot_wider(names_from = datatype, values_from = value)

## ---- akl-rename
aklweather_tidy <- aklweather %>%
  mutate(value = value / 10) %>% 
  pivot_wider(names_from = datatype, values_from = value) %>% 
  rename_with(tolower)
aklweather_tidy

aklweather_tidy %>% 
  complete(date = full_seq(ymd(c("2019-01-01", "2021-04-01")), 1))

library(lubridate)
aklweather_tidy %>% 
  complete(date = full_seq(ymd(c("2019-01-01", "2021-04-01")), 1)) %>% 
  group_by(yearmonth = floor_date(date, "1 month")) %>% 
  summarise(
    tavg = mean(tavg, na.rm = TRUE),
    tmax = mean(tmax, na.rm = TRUE),
    tmin = mean(tmin, na.rm = TRUE)
  ) %>% 
  ggplot(aes(yearmonth, tavg, ymin = tmin, ymax = tmax)) +
  geom_line() +
  geom_ribbon(fill = "#e6550d", alpha = 0.8) +
  scale_x_date(date_labels = "%Y %b")

aklrainfall <- aklweather_tidy %>% 
  complete(
    date = full_seq(ymd(c("2019-01-01", "2021-04-01")), 1),
    fill = list(prcp = 0) #<<
  ) %>% 
  group_by(yearmonth = floor_date(date, "1 month")) %>% 
  mutate(cum_prcp = cumsum(prcp)) %>% 
  ungroup()

aklrainfall %>% 
  ggplot(aes(date, cum_prcp)) +
  geom_area(fill = "#3182bd", alpha = 0.8) +
  geom_text(
    aes(label = cum_prcp),
    data = aklrainfall %>% filter(date %in% rollforward(date)),
    nudge_y = 2
  )
