## ---- dept-chr
dept <- c("Physics", "Mathematics",
  "Statistics", "Computer Science")
dept

## ---- dept-fct
library(tidyverse) # library(forcats)
dept_fct <- as_factor(dept)
dept_fct

## ---- chr
typeof(dept)
class(dept)
as.integer(dept)
sort(dept)

## ---- fct
typeof(dept_fct)
class(dept_fct)
as.integer(dept_fct)
sort(dept_fct)

## ---- fct-lvls
dept_fct
levels(dept_fct)
rep(dept_fct, 3)

## ---- fct-create
dist_dept <- unique(dept)
factor(dept, levels = dist_dept)
factor(dept, levels = rev(dist_dept))

## ---- fct-vis
nstaff <- c(12L, 8L, 20L, 23L)
sci_tbl <- tibble(dept = dept, count = nstaff)
sci_tbl %>% 
  ggplot(aes(dept, count)) +
  geom_col()

## ---- fct-ror
sci_tbl %>% 
  mutate(dept = fct_reorder(dept, count)) %>% 
  ggplot(aes(dept, count)) +
  geom_col()

## ---- fct-ror2
sci_tbl %>% 
  mutate(dept = fct_reorder(dept, count)) %>% 
  pull(dept)

## ---- fct-ino
sci_tbl %>% 
  mutate(dept = fct_inorder(dept)) %>% 
  ggplot(aes(dept, count)) +
  geom_col()

## ---- scores-sim
set.seed(220)
scores_sim <- round(
  rnorm(309, mean = 70, sd = 10),
  digits = 2)
scores_tbl <- tibble(score = scores_sim)
scores_tbl

## ---- hist
scores_tbl %>% 
  ggplot(aes(x = score)) +
  geom_histogram()

## ---- cut
scores_tbl %>% 
  mutate(
    range = cut(score, breaks = c(0, seq(39, 89, by = 5), 100), 
      include.lowest = TRUE))

## ---- recode
scores_more <- scores_tbl %>% 
  mutate(
    range = cut(score, breaks = c(0, seq(39, 89, by = 5), 100), 
      include.lowest = TRUE),
    grade = fct_recode(range,
      "D-" = "[0,39]", "D" = "(39,44]", "D+" = "(44,49]",
      "C-" = "(49,54]", "C" = "(54,59]", "C+" = "(59,64]",
      "B-" = "(64,69]", "B" = "(69,74]", "B+" = "(74,79]",
      "A-" = "(79,84]", "A" = "(84,89]", "A+" = "(89,100]"))
scores_more

## ---- bar-range
scores_more %>% 
  ggplot(aes(x = range)) +
  geom_bar()

## ---- bar-grade
scores_more %>% 
  ggplot(aes(x = grade)) +
  geom_bar()

## ---- box-movies
movies <- as_tibble(jsonlite::read_json(
  "https://vega.github.io/vega-editor/app/data/movies.json",
  simplifyVector = TRUE))
ggplot(movies, aes(Rotten_Tomatoes_Rating, Major_Genre)) +
  geom_boxplot()

## ---- box-movies-med
movies %>% 
  mutate(
    Major_Genre = fct_reorder(Major_Genre, Rotten_Tomatoes_Rating,
      .fun = median, na.rm = TRUE)) %>% 
  ggplot(aes(Rotten_Tomatoes_Rating, Major_Genre)) +
  geom_boxplot()

## ---- col-movies
movies %>% 
  count(Major_Genre) %>% 
  ggplot(aes(n, Major_Genre)) +
  geom_col()

## ---- col-movies-lump
movies %>% 
  mutate(Major_Genre = fct_lump_n(Major_Genre, 5)) %>% 
  ggplot(aes(y = Major_Genre)) +
  geom_bar()

## ---- col-movies-lump-reord
movies %>% 
  mutate(Major_Genre = fct_lump_n(Major_Genre, 5)) %>% 
  count(Major_Genre) %>% 
  mutate(Major_Genre = fct_reorder(Major_Genre, n)) %>% 
  ggplot(aes(n, Major_Genre)) +
  geom_col()

## ---- lubridate
library(lubridate)

(td <- today())
class(td)
typeof(td)

(current <- now())
class(current)
typeof(current)

dt_chr <- c("2021/03/11", "2021-April-21")
(dt <- ymd(dt_chr))

ymd_h("2021-03-21 14")
ymd_h("2021-03-21 14", tz = "Pacific/Auckland")

make_date(2021, 3, 21)
make_datetime(2021, 3, 21, 14)

year(dt)
month(dt)
month(dt, label = TRUE)
day(dt) # mday(dt)
yday(dt)
wday(dt)
wday(dt, label = TRUE)
wday(dt, label = TRUE, week_start = 1)

floor_date(dt, "1 month")
ceiling_date(dt, "1 month")
round_date(dt, "1 month")

# data example

# scale_x_date()
