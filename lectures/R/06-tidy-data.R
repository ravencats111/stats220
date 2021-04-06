library(tidyverse)
tb <- read_csv("data/tb.csv")
tb

tb %>% 
  pivot_longer(cols = m_04:f_u, names_to = "sex_age", values_to = "cases")

tb %>% 
  pivot_longer(cols = m_04:f_u, names_to = "sex_age", values_to = "cases") %>% 
  separate(sex_age, into = c("sex", "age"), sep = "_")

tb_tidy <- tb %>% 
  pivot_longer(cols = m_04:f_u, names_to = "sex_age", values_to = "cases") %>% 
  separate(sex_age, into = c("sex", "age"), sep = "_") %>% 
  group_by(iso2) %>% 
  fill(cases, .direction = "updown") %>% 
  ungroup()
tb_tidy

tb_tidy %>% 
  nest(data = year:cases)

tb_tidy %>% 
  nest(data = year:cases) %>% 
  mutate( # below for week 11
    model = map(data, lm),
    intercept = map_dbl(model, ~ coef(.)[1]),
    slope = map_dbl(model, ~ coef(.)[2])
  )
  
tb_tidy %>% 
  nest(data = year:cases) %>% 
  mutate(
    model = map(data, lm),
    intercept = map_dbl(model, ~ coef(.)[1]),
    slope = map_dbl(model, ~ coef(.)[2])
  ) %>% 
  ggplot(aes(x = fct_reorder(iso2, slope), y = slope)) +
  geom_point(aes(colour = slope < 0)) +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  theme(axis.text.x = element_text(angle = 90))

aklweather <- read_csv2("data/ghcnd/ghcnd-akl.csv",
  col_types = cols_only(date = "D", datatype = "c", value = "d"))
aklweather

aklweather %>%
  mutate(value = value / 10)

aklweather %>%
  mutate(value = value / 10) %>% 
  pivot_wider(names_from = datatype, values_from = value)

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
