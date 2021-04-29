## ---- t-shape
library(tidyverse)
set.seed(220)
n <- 30
tbl_pre <- tibble(
  x = runif(n), y = runif(n),
  type = sample(c(TRUE, FALSE), replace = TRUE, size = n, prob = c(0.1, 0.9)))

ggplot(tbl_pre, aes(x, y)) + 
  geom_text(aes(angle = ifelse(type, 0, 90), label = "T"), 
    size = 3, fontface = "bold") + 
  labs(x = "", y = "") + 
  guides(angle = FALSE) +
  theme(axis.text = element_blank(), axis.ticks = element_blank())

## ---- shape
ggplot(tbl_pre, aes(x, y)) + 
  geom_point(aes(shape = type), size = 3) + 
  labs(x = "", y = "") + 
  guides(shape = FALSE) +
  theme(axis.text = element_blank(), axis.ticks = element_blank())

## ---- colour
ggplot(tbl_pre, aes(x, y)) + 
  geom_point(aes(color = type), size = 3) + 
  labs(x = "", y = "") + 
  guides(color = FALSE) +
  scale_color_manual(values = c("black", "#e6550d")) +
  theme(axis.text = element_blank(), axis.ticks = element_blank())

## ---- time-use
time_use <- readxl::read_xlsx("data/time-use-oecd.xlsx") %>% 
  rename_with(janitor::make_clean_names) %>% 
  filter(country %in% c("Australia", "New Zealand", "USA")) %>% 
  mutate(category = fct_lump(category, n = 5, w = time_minutes, 
    other_level = "Misc")) %>% 
  group_by(country, category) %>% 
  summarise(time_minutes = sum(time_minutes)) %>% 
  ungroup() %>% 
  mutate(category = fct_reorder(category, time_minutes))

## ---- fill-cat
time_use %>% 
  ggplot(aes(country, time_minutes)) +
  geom_col(aes(fill = category), position = "dodge") +
  scale_fill_viridis_d() +
  labs(y = "") +
  theme(legend.position = "bottom")

## ---- fill-country
time_use %>% 
  ggplot(aes(category, time_minutes)) +
  geom_col(aes(fill = country), position = "dodge") +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  scale_fill_viridis_d() +
  labs(y = "") +
  theme(legend.position = "bottom")

## ---- angle
time_use %>% 
  group_by(category) %>% 
  mutate(time_minutes = time_minutes / sum(time_minutes)) %>% 
  ungroup() %>% 
  ggplot(aes(x = "", time_minutes)) +
  geom_col(aes(fill = country)) +
  facet_wrap(~ category) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  labs(x = "", y = "") +
  theme(
    legend.position = "bottom", 
    axis.text.x = element_blank())

## ---- rel-pos
time_use %>% 
  ggplot(aes(category, time_minutes)) +
  geom_col(aes(fill = country), position = "fill") +
  labs(y = "") +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  scale_fill_viridis_d() +
  theme(legend.position = "bottom")

## ---- time-use-bad
readxl::read_xlsx("data/time-use-oecd.xlsx") %>% 
  rename_with(janitor::make_clean_names) %>% 
  filter(country %in% c("Australia", "New Zealand", "USA")) %>% 
  group_by(country, category) %>% 
  summarise(time_minutes = sum(time_minutes)) %>% 
  ungroup() %>% 
  mutate(category = fct_reorder(category, time_minutes)) %>% 
  ggplot(aes(country, time_minutes)) +
  geom_col(aes(fill = category), position = "dodge") +
  guides(fill = guide_legend(nrow = 4)) +
  labs(y = "") +
  theme(legend.position = "bottom")

## ---- colorspace-q
colorspace::hcl_palettes("Qualitative", plot = TRUE, n = 7)

## ---- colorspace-s
colorspace::hcl_palettes("Sequential", plot = TRUE, n = 7)

## ---- colorspace-d
colorspace::hcl_palettes("Diverging", plot = TRUE, n = 7)

## ---- gg-palette
time_use %>% 
  ggplot(aes(country, time_minutes)) +
  geom_col(
    aes(fill = category), 
    position = "dodge") +
  scale_fill_brewer(palette = "Dark2") + #<<
  labs(y = "") +
  theme(legend.position = "bottom")

## ---- gg-manual
time_use %>% 
  ggplot(aes(country, time_minutes)) +
  geom_col(
    aes(fill = category),
    position = "dodge") +
  scale_fill_manual( #<<
    values = c("#EF476F", "#FFD166", #<<
               "#06D6A0", "#118AB2", #<<
               "#073B4C", "grey")) + #<<
  labs(y = "") +
  theme(legend.position = "bottom")

## ---- covid
covid19 <- read_csv("data/covid19-daily-cases.csv")
covid19

## ---- covid-scale0
covid19 %>% 
  ggplot(aes(
    x = date, 
    y = confirmed, 
    colour = country_region)) +
  geom_line() +
  guides(colour = FALSE) # rm colour legend #<<

## ---- covid-scale1
covid19 %>% 
  ggplot(aes(
    x = date, 
    y = log10(confirmed), #<<
    colour = country_region)) +
  geom_line() +
  guides(colour = FALSE)

## ---- covid-scale-log10
covid19 %>% 
  ggplot(aes(
    x = date, 
    y = confirmed, 
    colour = country_region)) +
  geom_line() +
  guides(colour = FALSE) +
  scale_y_log10() #<<

## ---- covid-rel
covid19_rel <- covid19 %>% 
  group_by(country_region) %>% 
  mutate(days = as.numeric(date - min(date))) %>% 
  ungroup()
covid19_rel

## ---- covid-rel-p
covid19_rel %>% 
  ggplot(aes(
    x = days,
    y = confirmed, 
    colour = country_region)) +
  geom_line() +
  scale_y_log10() +
  guides(colour = FALSE)

## ---- covid-rel-nz
covid19_nz <- covid19_rel %>% 
  filter(country_region == "New Zealand")
p_nz <- covid19_rel %>% 
  ggplot(aes(x = days, y = confirmed, 
    group = country_region)) + #<<
  geom_line(colour = "grey", alpha = 0.5) +
  geom_line(colour = "#238b45", size = 1, data = covid19_nz) +
  scale_y_log10() +
  guides(colour = FALSE)
p_nz

## ---- covid-rel-nz-lab
p_nz <- p_nz +
  geom_label(aes(
    x = max(days), y = max(confirmed), #<<
    label = country_region), data = covid19_nz,
    colour = "#238b45", nudge_x = 3, nudge_y = .5)
p_nz

## ---- covid-rel-nz-lim
p_nz <- p_nz +
  scale_y_log10(labels = scales::label_comma()) + #<<
  xlim(c(0, 100)) #<<
p_nz

## ---- covid-rel-nz-title
p_nz <- p_nz +
  labs(
    x = "Days since March 1",
    y = "Confirmed cases (on log10)",
    title = "Worldwide coronavirus confirmed cases",
    subtitle = "highlighting New Zealand",
    caption = "Data source: John Hopkins University, CSSE"
  )
p_nz

## ---- covid-rel-nz-theme
# remotes::install_github("Financial-Times/ftplottools")
p_nz +
  ftplottools::ft_theme() +
  theme(
    plot.title.position = "plot", 
    plot.background = element_rect(fill = "#FFF1E0"))

## ---- plotly
library(plotly)
ggplotly(p_nz) #<<
