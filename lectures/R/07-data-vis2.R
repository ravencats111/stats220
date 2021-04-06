# Graphical perception
library(tidyverse)
covid19 <- read_csv("data/covid19-daily-cases.csv")

covid19 %>% 
  ggplot(aes(x = date, y = confirmed, colour = country_region)) +
  geom_line() +
  theme(legend.position = "none")

covid19 %>% 
  ggplot(aes(x = date, y = confirmed, colour = country_region)) +
  geom_line() +
  scale_y_log10() +
  theme(legend.position = "none")

covid19 %>% 
  group_by(country_region) %>% 
  mutate(days = as.numeric(date - min(date))) %>% 
  ggplot(aes(x = days, y = confirmed, colour = country_region)) +
  geom_line() +
  scale_y_log10() +
  theme(legend.position = "none")
