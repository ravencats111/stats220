## ---- read-time-use
library(readxl)
library(tidyverse)
time_use_raw <- read_xlsx("data/time-use-oecd.xlsx")
time_use_raw

## ---- gg-time-use
ggplot(time_use_raw) + #<<
  geom_col(aes(
    Country, `Time (minutes)`, 
    fill = Category))

## ---- gg-time-use-pipe
time_use_raw %>% #<<
  ggplot() +
  geom_col(aes(
    Country, `Time (minutes)`, 
    fill = Category))

## ---- rename
time_use <- time_use_raw %>% 
  rename(
    country = Country, 
    category = Category, 
    minutes = `Time (minutes)`)
time_use

## ---- distinct
time_use %>% 
  distinct(category)

## ---- distinct2
time_use %>% 
  distinct(country, category)

## ---- slice
time_use %>% 
  slice(1:5)

## ---- group-by
time_use %>% 
  group_by(country)

## ---- slice-gb
time_use %>% 
  group_by(country) %>% 
  slice(1:5)

## ---- slice-head
time_use %>% 
  group_by(country) %>% 
  slice_head(n = 5)

## ---- ungroup
time_use %>% 
  group_by(country) %>% 
  slice_head(n = 5) %>% 
  ungroup()

## ---- slice-sample
set.seed(220)
time_use %>% 
  slice_sample(n = 10)

## ---- arrange
time_use %>% 
  arrange(minutes)

## ---- arrange-desc
time_use %>% 
  arrange(desc(minutes)) # -minutes

## ---- arrange-desc2
time_use %>% 
  arrange(country, desc(minutes))

## ---- filter
time_use %>% 
  filter(minutes == max(minutes))

## ---- filter-gb
time_use %>% 
  group_by(country) %>% 
  filter(minutes == max(minutes))

## ---- filter-in
anz <- c("Australia", "New Zealand")
time_use %>% 
  filter(country %in% anz)

## ---- filter-not
time_use %>% 
  filter(!(country %in% anz))

## ---- filter-and
time_use %>% 
  filter(country %in% anz, minutes > 30)
time_use %>% 
  filter(country %in% anz & minutes > 30)

## ---- filter-or
time_use %>% 
  filter(country %in% anz | minutes > 30)

## ---- filter-anz
time_use_anz <- time_use %>% 
  filter(country %in% anz)

## ---- filter-anz-line
time_use_nz <- time_use_anz %>% 
  filter(country == "New Zealand")
time_use_anz %>% 
  ggplot(aes(as.factor(country), minutes, group = category)) +
  geom_line(aes(colour = category)) +
  geom_point(aes(colour = category)) +
  ggrepel::geom_text_repel(aes(label = category), data = time_use_nz,
    size = 3) +
  theme(legend.position = "none") +
  scale_y_log10()

## ---- select
time_use_anz %>% 
  select(country, category)
time_use_anz %>% 
  select(-minutes) # !minutes
time_use_anz %>% 
  select(country:category)

## ---- select-helpers
time_use_anz %>% 
  select(starts_with("c"))

## ---- relocate
time_use_anz %>% 
  relocate(minutes)

time_use_anz %>% 
  relocate(minutes)

time_use_anz %>% 
  relocate(minutes, .after = country)

## ---- mutate
time_use_anz2 <- time_use_anz %>%
  mutate(
    hours = minutes / 60,
    iso = case_when(
      country == "Australia" ~ "AU", 
      TRUE ~ "NZ"))
time_use_anz2

## ---- summarise
time_use_anz2 %>% 
  summarise( # summarize()
    min = min(hours), 
    max = max(hours),
    avg = max(hours))

## ---- summarise-gb
time_use_anz2 %>% 
  group_by(category) %>% 
  summarise(
    min = min(hours), 
    max = max(hours),
    avg = max(hours))

## ---- chain
time_use %>% 
  filter(country %in% anz) %>% 
  mutate(hours = minutes / 60) %>% 
  group_by(category) %>% 
  summarise(
    min = min(hours), 
    max = max(hours), 
    avg = mean(hours))

## ---- chain-ggplot
time_use %>% 
  filter(country %in% anz) %>% 
  mutate(hours = minutes / 60) %>% 
  group_by(category) %>% 
  summarise(min = min(hours), max = max(hours), avg = mean(hours)) %>% 
  ggplot(aes(x = category, y = avg)) +
  geom_pointrange(aes(ymin = min, ymax = max), colour = "#e6550d") +
  theme(axis.text.x = element_text(angle = 90))

## ---- shortcuts
time_use_anz %>% 
  group_by(country) %>% 
  summarise(n = n())
time_use_anz %>% 
  count(country)
time_use_anz %>% 
  group_by(Country) %>% 
  tally()

## ---- dbplyr-con
library(RSQLite)
con <- dbConnect(SQLite(), dbname = "data/pisa/pisa-student.db")
pisa_db <- tbl(con, "pisa")
pisa_db

## ---- dbplyr-verbs
pisa_sql <- pisa_db %>% 
  filter(country %in% c("NZL", "AUS")) %>% 
  group_by(country) %>% 
  summarise(avg_math = mean(math, na.rm = TRUE)) %>% 
  arrange(desc(math))
pisa_sql

## ---- dbplyr-q
pisa_sql %>% show_query()

## ---- dbplyr-collect
pisa_sql %>% collect()

## ---- countrycode
country_code <- read_csv("data/countrycode.csv")

## ---- inner-join
time_use_raw %>% 
  inner_join(country_code, by = c("Country" = "country_name"))

## ---- left-join
time_use_raw %>% 
  left_join(country_code, by = c("Country" = "country_name"))

## ---- left-join-na
time_use_raw %>% 
  left_join(country_code, by = c("Country" = "country_name")) %>%
  filter(Country %in% c("New Zealand", "USA")) %>% 
  group_by(Country) %>% 
  slice_head()

## ---- right-join
time_use_raw %>% 
  right_join(country_code, by = c("Country" = "country_name"))

## ---- full-join
time_use_raw %>% 
  full_join(country_code, by = c("Country" = "country_name"))

## ---- semi-join
time_use_raw %>% 
  semi_join(country_code, by = c("Country" = "country_name"))

## ---- anti-join
time_use_raw %>% 
  anti_join(country_code, by = c("Country" = "country_name"))

## ---- lookup
time_use_ctr <- unique(time_use_raw$Country)
country_code_name <- unique(country_code$country_name)

time_use_ctr[!time_use_ctr %in% country_code_name]
