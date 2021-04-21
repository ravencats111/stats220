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
    names_to = "sex_age", # new col contains old headers #<<
    values_to = "cases") # new col contains old values #<<

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
  nest(data = -iso2)

## ---- tb-mod
tb_fit <- tb_tidy %>% 
  nest(data = -iso2) %>% 
  mutate( # map() for week 11
    model = map(data, ~ lm(cases ~ year + sex + age, data = .)),
    r2 = map_dbl(model, ~ broom::glance(.)$r.squared)
  )
tb_fit
  
## ---- tb-mod-plot
set.seed(220)
tb_fit_pre <- tb_fit %>% 
  arrange(-r2) %>% 
  mutate(iso2 = fct_inorder(iso2), index = row_number()) #<<
hl_tb <- tb_fit_pre %>% 
  slice_sample(n = 20)
tb_fit_pre %>% 
  ggplot(aes(x = index, y = r2)) +
  geom_hline(yintercept = 0.5, size = 0.8, colour = "grey") +
  geom_point(aes(colour = r2 < 0.5), size = 0.8) + #<<
  ggrepel::geom_label_repel(aes(label = iso2), data = hl_tb, box.padding = 1) + #<<
  theme_bw() +
  theme(
    axis.text.x = element_blank(), #<<
    axis.ticks.x = element_blank(), #<<
    panel.grid.major.x = element_blank(), #<<
    legend.position = "top" #<<
  )

## ---- aklweather
aklweather <- read_csv2(
  "data/ghcnd/ghcnd-akl.csv",
  col_types = cols_only(
    date = "D", datatype = "c", 
    value = "d"))
aklweather

## ---- akl-wide
aklweather %>%
  pivot_wider(names_from = datatype, values_from = value)

## ---- akl-clean
aklweather %>%
  mutate(value = value / 10)

## ---- akl-pivot
aklweather %>%
  mutate(value = value / 10) %>% 
  pivot_wider(
    names_from = datatype, # new headers from old `datatype` val #<< 
    values_from = value)  # new col contains old `value` #<<

## ---- akl-rename
aklweather_tidy <- aklweather %>%
  mutate(value = value / 10) %>% 
  pivot_wider(
    names_from = datatype,
    values_from = value) %>%
  rename_with(tolower) #<<
aklweather_tidy

## ---- akl-complete
library(lubridate)
aklweather_tidy %>% 
  complete(date = full_seq(
    ymd(c("2019-01-01", "2021-04-01")), 1))

## ---- akl-missing
aklweather_tidy %>% 
  complete(date = full_seq(
    ymd(c("2019-01-01", "2021-04-01")), 1)) %>% 
  anti_join(aklweather_tidy) #<<

## ---- akl-rainfall-na
aklweather_tidy %>% 
  complete(date = full_seq(
    ymd(c("2019-01-01", "2021-04-01")), 
    1)) %>% 
  filter(is.na(prcp))

## ---- akl-rainfall
akl_prcp <- aklweather_tidy %>% 
  complete(
    date = full_seq(ymd(c("2019-01-01", "2021-04-01")), 1),
    fill = list(prcp = 0) #<<
  ) %>% 
  group_by(yearmonth = floor_date(date, "1 month")) %>% 
  mutate(cum_prcp = cumsum(prcp)) %>% 
  ungroup()
akl_prcp

## ---- akl-rainfall-plot
akl_prcp %>% 
  ggplot(aes(date, cum_prcp)) +
  geom_area(fill = "#3182bd", alpha = 0.8) +
  geom_text(
    aes(label = cum_prcp),
    data = akl_prcp %>% filter(date %in% rollforward(date)), #<<
    nudge_y = 3
  )

## ---- akl-monthly
akl_monthly_temp <- aklweather_tidy %>% 
  group_by(yearmonth = floor_date(date, "1 month")) %>% 
  summarise(
    tavg = mean(tavg, na.rm = TRUE),
    tmax = mean(tmax, na.rm = TRUE),
    tmin = mean(tmin, na.rm = TRUE)
  )
akl_monthly_temp

## ---- akl-monthly-plot
akl_monthly_temp %>% 
  ggplot(aes(yearmonth, tavg, ymin = tmin, ymax = tmax)) +
  geom_line() +
  geom_ribbon(fill = "#e6550d", alpha = 0.8) +
  scale_x_date(date_labels = "%Y %b") #<<

## ---- akl-heatmap
akl_monthly_temp %>% 
  mutate(
    year = year(yearmonth),
    month = month(yearmonth, label = TRUE)) %>% 
  ggplot(aes(month, y = year, fill = tavg)) +
  geom_tile(width = 0.95, height = 0.95) + #<<
  scale_fill_viridis_c(option = "B") + #<<
  coord_fixed() + #<<
  theme_classic()
