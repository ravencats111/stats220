## ---- read-time-use
library(readxl)
library(tidyverse)
time_use_raw <- read_xlsx("data/time-use-oced.xlsx")
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
an <- c("Australia", "New Zealand")
time_use %>% 
  filter(country %in% an)

## ---- filter-not
time_use %>% 
  filter(!(country %in% an))

## ---- filter-and
# time_use %>% 
#   filter(country %in% an & minutes > 30)
time_use %>% 
  filter(country %in% an, minutes > 30)

## ---- filter-or
time_use %>% 
  filter(country %in% an | minutes > 30)

## ---- filter-an
time_use_an <- time_use %>% 
  filter(country %in% an)

## ---- filter-an-line
time_use_nz <- time_use_an %>% 
  filter(country == "New Zealand")
time_use_an %>% 
  ggplot(aes(as.factor(country), minutes, group = category)) +
  geom_line(aes(colour = category)) +
  geom_point(aes(colour = category)) +
  ggrepel::geom_text_repel(aes(label = category), data = time_use_nz,
    size = 3) +
  theme(legend.position = "none")

time_use_an %>% 
  select(country, category)

time_use_an %>% 
  select(-minutes)

time_use_an %>% 
  select(country:category)

time_use_an %>% 
  relocate(minutes)

time_use_an %>% 
  relocate(minutes)

time_use_an %>% 
  relocate(minutes, .after = country)

time_use_an2 <- time_use_an %>%
  mutate(
    hours = minutes / 60,
    iso = case_when(
      country == "Australia" ~ "AU", 
      TRUE ~ "NZ"))

time_use_an2 %>% 
  summarise(
    avg_mins = mean(minutes),
    ttl_hrs = sum(hours))

time_use_an2 %>% 
  group_by(category) %>% 
  summarise(min = min(hours), max = max(hours))

time_use %>% 
  filter(country %in% an) %>% 
  mutate(hours = minutes / 60) %>% 
  group_by(category) %>% 
  summarise(min = min(hours), max = max(hours), avg = mean(hours))

time_use %>% 
  filter(country %in% an) %>% 
  mutate(hours = minutes / 60) %>% 
  group_by(category) %>% 
  summarise(min = min(hours), max = max(hours), avg = mean(hours)) %>% 
  ggplot(aes(x = category, y = avg)) +
  geom_pointrange(aes(ymin = min, ymax = max), colour = "#e6550d") +
  theme(axis.text.x = element_text(angle = 90))

time_use_an %>% 
  group_by(country) %>% 
  summarise(n = n())

# shortcuts
time_use_an %>% 
  count(country) # tally()

time_use_an %>% 
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
