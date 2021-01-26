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
    year = as.integer(year)
  )

pisa_nz_mutate %>% 
  summarise(
    internet_n = sum(internet == "yes", na.rm = TRUE),
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

# join

# dbplyr
