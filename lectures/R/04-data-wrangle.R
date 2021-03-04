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
  filter(country %in% c("Australia", "New Zealand"))

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

pisa <- read_csv("data/pisa/pisa-student.csv", n_max = 2929621)

pisa_nz <- pisa %>% 
  filter(
    country == "NZL",
    wealth >= median(wealth, na.rm = TRUE) |
    !is.na(internet)
  )

pisa_nz_reorder <- pisa_nz %>% 
  arrange(desc(year), science)

pisa_nz_select <- pisa_nz_reorder %>% 
  select(year, gender, internet:escs)
  # select(-c(country:father_educ, computer))

pisa_nz_mutate <- pisa_nz_select %>% 
  mutate(
    average_score = (math + read + science) / 3,
    internet = if_else(internet == "yes", TRUE, FALSE),
    year = as.integer(year)
  )

pisa_nz_mutate %>% 
  summarise(
    internet_n = sum(internet, na.rm = TRUE),
    avg_math = mean(math, na.rm = TRUE),
    avg_read = mean(read),
    avg_science = mean(science)
  )

pisa %>% 
  filter(
    country == "NZL",
    wealth >= median(wealth, na.rm = TRUE) |
    !is.na(internet)
  ) %>% 
  arrange(desc(year), science) %>% 
  select(year, gender, internet:escs) %>% 
  mutate(
    average_score = (math + read + science) / 3,
    year = as.integer(year)
  ) %>% 
  summarise(
    internet_n = sum(internet == "yes", na.rm = TRUE),
    avg_math = mean(math, na.rm = TRUE),
    avg_read = mean(read),
    avg_science = mean(science)
  )

pisa_nz %>% 
  group_by(year)

pisa_nz_byyear <- pisa %>% 
  filter(country == "NZL") %>% 
  group_by(year) %>% 
  summarise(
    med_math = median(math, na.rm = TRUE),
    med_read = median(read),
    med_science = median(science)
  )

pisa_nz_byyear %>% 
  ggplot(aes(x = year)) +
  geom_line(aes(y = med_math)) +
  geom_point(aes(y = med_math)) +
  geom_line(aes(y = med_read)) +
  geom_point(aes(y = med_read)) +
  geom_line(aes(y = med_science)) +
  geom_point(aes(y = med_science))

# rename
pisa_nz %>% 
  rename(
    school = school_id,
    student = student_id
  )

pisa_nz %>% 
  transmute(
    average_score = (math + read + science) / 3,
    year = as.integer(year)
  )

# slice
pisa_nz %>% 
  slice(1:10, 21:30)

# shortcuts
pisa_nz %>% 
  count(gender)

pisa_nz %>% 
  group_by(gender) %>% 
  summarise(n = n())

pisa_nz %>% 
  group_by(gender) %>% 
  tally()

# join
pisa_nzau <- pisa %>% 
  filter(country %in% c("NZL", "AUS")) %>% 
  select(year, country, science)

countrycode <- read_csv("data/pisa/countrycode.csv")
countrycode

pisa_nzau %>% 
  left_join(countrycode, by = "country")

pisa_nzau %>% 
  right_join(countrycode, by = "country") %>% 
  slice_tail(n = 5)

pisa_nzau %>% 
  anti_join(countrycode, by = "country")

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
