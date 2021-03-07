library(readxl)
time_use_raw <- read_xlsx("data/time-use-oced.xlsx")
time_use_raw

library(tidyverse)
time_use <- time_use_raw %>% 
  rename(
    country = Country, 
    category = Category, 
    minutes = `Time (minutes)`)

time_use %>% 
  distinct(category)

time_use %>% 
  distinct(country) %>% 
  pull(country)

time_use %>% 
  slice(1:33)

set.seed(220)
time_use %>% 
  slice_sample(n = 10)

time_use %>% 
  arrange(minutes)

time_use %>% 
  arrange(desc(minutes)) # -minutes

time_use %>% 
  arrange(country, desc(minutes))

time_use %>% 
  filter(country %in% c("Australia", "New Zealand"))

time_use[time_use$country %in% c("Australia", "New Zealand"), ]

time_use %>% 
  filter(country %in% c("Australia", "New Zealand"), minutes > 30)

time_use %>% 
  filter(country %in% c("Australia", "New Zealand") & minutes > 30)

time_use %>% 
  filter(country %in% c("Australia", "New Zealand") | minutes > 30)

time_use_oz <- time_use %>% 
  filter(country %in% c("Australia", "New Zealand"))

time_use_nz <- time_use_oz %>% 
  filter(country == "New Zealand")
time_use_oz %>% 
  ggplot(aes(as.factor(country), minutes, group = category)) +
  geom_line(aes(colour = category)) +
  geom_point(aes(colour = category)) +
  ggrepel::geom_text_repel(aes(label = category), data = time_use_nz,
    size = 3) +
  theme(legend.position = "none")

time_use_oz %>% 
  arrange(country, desc(minutes))

time_use_oz %>% 
  select(country, category)

time_use_oz %>% 
  select(-minutes)

time_use_oz %>% 
  select(country:category)

time_use_oz %>% 
  relocate(minutes)

time_use_oz %>% 
  relocate(minutes)

time_use_oz %>% 
  relocate(minutes, .after = country)

time_use_oz2 <- time_use_oz %>%
  mutate(
    hours = minutes / 60,
    iso = case_when(
      country == "Australia" ~ "AU", 
      TRUE ~ "NZ"))

time_use_oz2 %>% 
  summarise(
    avg_mins = mean(minutes),
    ttl_hrs = sum(hours))

time_use_oz2 %>% 
  group_by(category) %>% 
  summarise(min = min(hours), max = max(hours))

time_use %>% 
  filter(country %in% c("Australia", "New Zealand")) %>% 
  mutate(hours = minutes / 60) %>% 
  group_by(category) %>% 
  summarise(min = min(hours), max = max(hours), avg = mean(hours))

time_use %>% 
  filter(country %in% c("Australia", "New Zealand")) %>% 
  mutate(hours = minutes / 60) %>% 
  group_by(category) %>% 
  summarise(min = min(hours), max = max(hours), avg = mean(hours)) %>% 
  ggplot(aes(x = category, y = avg)) +
  geom_pointrange(aes(ymin = min, ymax = max), colour = "#e6550d") +
  theme(axis.text.x = element_text(angle = 90))

time_use_oz %>% 
  group_by(country) %>% 
  summarise(n = n())

# shortcuts
time_use_oz %>% 
  count(country) # tally()

time_use_oz %>% 
  group_by(country) %>% 
  filter(minutes > median(minutes))

# dbplyr
library(RSQLite)
con <- dbConnect(SQLite(), dbname = "data/pisa/pisa-student.db")
pisa_db <- tbl(con, "pisa")

pisa_sql <- pisa_db %>% 
  filter(country %in% c("NZL", "AUS")) %>% 
  group_by(country) %>% 
  summarise(avg_math = mean(math, na.rm = TRUE)) %>% 
  arrange(desc(math))

pisa_sql %>% 
  show_query()

pisa_sql %>% 
  collect()
