library(tidyverse)
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
