## ---- dept-chr
dept <- c("Physics", "Mathematics", "Statistics",
  "Computer Science")
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
  mutate(dept = fct_reorder(dept, count)) %>% #<<
  ggplot(aes(dept, count)) +
  geom_col()

## ---- fct-ror2
sci_tbl %>% 
  mutate(dept = fct_reorder(dept, -count)) %>% #<<
  ggplot(aes(dept, count)) +
  geom_col()

## ---- fct-vct
fct_reorder(sci_tbl$dept, sci_tbl$count)

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
  mutate(Major_Genre = fct_infreq(Major_Genre)) %>% 
  ggplot(aes(y = Major_Genre)) +
  geom_bar()

## ---- col-movies-lump
movies %>% 
  mutate(Major_Genre = fct_infreq(fct_lump_n(Major_Genre, 6))) %>% 
  ggplot(aes(y = Major_Genre)) +
  geom_bar()

## ---- lubridate
library(lubridate)

## ---- dt
(td <- today())
class(td)
typeof(td)
as.integer(td)

## ---- dttm
(current <- now())
class(current)
typeof(current)
as.integer(current)

## ---- parse-dttm
ymd(c("2021/03/31", "1921-Jan-21"))
ymd_h(c("2021-03-31 16", "2021-June-04 10"))
ymd_h(c("2021-03-31 16", "2021-June-04 10"), tz = "Pacific/Auckland")
as_date(18713)
as_datetime(1616810967)

## ---- tz-name
set.seed(220)
OlsonNames()[sample(1:length(OlsonNames()), 20)]

## ---- create-dttm
make_date(2021, c(3, 6), c(31, 4))
make_datetime(2021, c(3, 6), c(31, 4), c(16, 10))
dttm <- ymd_h(c("2021-03-31 16", "2021-June-04 10"), tz = "Pacific/Auckland")
dttm

## ---- extract
date(dttm)
year(dttm)
month(dttm)
month(dttm, label = TRUE)
day(dttm) # mday(dttm)
yday(dttm)
wday(dttm)
wday(dttm, label = TRUE)
wday(dttm, label = TRUE, week_start = 1)

## ---- cal
floor_date(dttm, "1 hour")
ceiling_date(dttm, "2 days")
round_date(dttm, "3 months")

## ---- arith
dttm + 1
dttm + minutes(2)
dttm + hours(3)
dttm + days(4)
dttm + weeks(5)
dttm + months(6)
dttm + years(7)

## ---- misc
# data example

# scale_x_date()
