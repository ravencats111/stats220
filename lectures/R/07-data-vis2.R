library(tidyverse)
# Graphical perception

# Preattentive processing
set.seed(220)
n <- 30
tbl_pre <- tibble(
  x = runif(n), y = runif(n),
  type = sample(c(TRUE, FALSE), replace = TRUE, size = n, prob = c(0.1, 0.9)))

ggplot(tbl_pre, aes(x, y)) + 
  geom_text(aes(angle = ifelse(type, 0, 90), label = "T"), 
    size = 4, fontface = "bold") + 
  labs(x = "", y = "") + 
  guides(angle = FALSE) +
  theme(axis.text = element_blank(), axis.ticks = element_blank())

ggplot(tbl_pre, aes(x, y)) + 
  geom_point(aes(shape = type), size = 4) + 
  labs(x = "", y = "") + 
  guides(shape = FALSE) +
  theme(axis.text = element_blank(), axis.ticks = element_blank())

ggplot(tbl_pre, aes(x, y)) + 
  geom_point(aes(color = type), size = 4) + 
  labs(x = "", y = "") + 
  guides(color = FALSE) +
  scale_color_manual(values = c("black", "#e6550d")) +
  theme(axis.text = element_blank(), axis.ticks = element_blank())

# Proximity
time_use <- readxl::read_xlsx("data/time-use-oecd.xlsx") %>% 
  rename_with(janitor::make_clean_names) %>% 
  filter(country %in% c("Australia", "New Zealand")) %>% 
  mutate(category = fct_lump(category, n = 5, w = time_minutes)) %>% 
  group_by(country, category) %>% 
  summarise(time_minutes = sum(time_minutes)) %>% 
  ungroup() %>% 
  mutate(category = fct_reorder(category, time_minutes))

time_use %>% 
  ggplot(aes(country, time_minutes)) +
  geom_col(aes(fill = category), position = "dodge") +
  scale_fill_viridis_d()

time_use %>% 
  ggplot(aes(category, time_minutes)) +
  geom_col(aes(fill = country), position = "dodge") +
  scale_fill_viridis_d()

# position > area
time_use %>% 
  ggplot(aes(x = "", time_minutes)) +
  geom_col(aes(fill = category)) +
  facet_grid(~ country) +
  scale_fill_viridis_d() +
  coord_polar("y")

time_use %>% 
  ggplot(aes(country, time_minutes)) +
  geom_col(aes(fill = category), position = "fill") +
  scale_fill_viridis_d()

time_use %>% 
  ggplot(aes(category, time_minutes)) +
  geom_col(aes(fill = country), position = "dodge") +
  scale_fill_viridis_d()

time_use %>% 
  ggplot(aes(category, time_minutes)) +
  geom_col(aes(fill = country), position = "fill") +
  scale_fill_viridis_d()

# Colour matters
library(colorspace)
hcl_palettes("Qualitative", plot = TRUE, n = 7)
hcl_palettes("Sequential", plot = TRUE, n = 7)
hcl_palettes("Diverging", plot = TRUE, n = 7)

time_use %>% 
  ggplot(aes(country, time_minutes)) +
  geom_col(aes(fill = category), position = "dodge") +
  scale_fill_brewer(palette = "Dark2")

# hclwizard()
# hcl_color_picker()
# https://coolors.co
time_use %>% 
  ggplot(aes(country, time_minutes)) +
  geom_col(aes(fill = category), position = "dodge") +
  scale_fill_manual(values = c("#EF476F", "#FFD166", "#06D6A0",
                               "#118AB2", "#073B4C", "grey"))

# Towards publication-ready plots
# Generative arts
# interactive graphics
covid19 <- read_csv("data/covid19-daily-cases.csv")
covid19 %>% 
  group_by(country_region) %>% 
  slice_head() %>% 
  ungroup() %>% 
  slice_max(confirmed)

p <- covid19 %>% 
  ggplot(aes(x = date, y = confirmed, colour = country_region)) +
  geom_line() +
  guides(colour = FALSE)

p + scale_y_log10()

covid19 %>% 
  group_by(country_region) %>% 
  mutate(days = as.numeric(date - min(date))) %>% 
  ggplot(aes(x = days, y = confirmed, colour = country_region)) +
  geom_line() +
  scale_y_log10() +
  guides(colour = FALSE)
