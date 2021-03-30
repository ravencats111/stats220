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
factor(dept, levels = dist_dept) # in first appearance order
factor(dept, levels = rev(dist_dept)) # in reverse order

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
fct_reorder(sci_tbl$dept, -sci_tbl$count)

## ---- box-movies
movies <- as_tibble(jsonlite::read_json(
  "https://vega.github.io/vega-editor/app/data/movies.json",
  simplifyVector = TRUE))
ggplot(movies, aes(Rotten_Tomatoes_Rating, Major_Genre)) +
  geom_boxplot()

## ---- box-movies-med
movies %>% 
  mutate(
    Major_Genre = fct_reorder(
      Major_Genre, 
      Rotten_Tomatoes_Rating,
      .fun = median, na.rm = TRUE)) %>% #<<
  ggplot(aes(
    Rotten_Tomatoes_Rating, 
    Major_Genre)) +
  geom_boxplot()

## ---- col-movies
movies %>% 
  mutate(Major_Genre = fct_infreq(
    Major_Genre)) %>% 
  ggplot(aes(y = Major_Genre)) +
  geom_bar()

## ---- col-movies-lump
movies %>% 
  mutate(Major_Genre = fct_infreq(
    fct_lump(Major_Genre, n = 6))) %>% #<<
  ggplot(aes(y = Major_Genre)) +
  geom_bar()

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
  geom_histogram() +
  geom_vline(xintercept = 70, 
    colour = "red")

## ---- cut
(rng <- c(0, seq(39, 89, by = 5), 100))
scores_tbl %>% 
  mutate(range = cut(score, breaks = rng, include.lowest = TRUE))

## ---- recode
scores_schemes <- scores_tbl %>% 
  mutate(
    range = cut(score, breaks = rng, include.lowest = TRUE),
    grade = fct_recode(range, # new_lvl = old_lvl
      "D-" = "[0,39]", "D" = "(39,44]", "D+" = "(44,49]",
      "C-" = "(49,54]", "C" = "(54,59]", "C+" = "(59,64]",
      "B-" = "(64,69]", "B" = "(69,74]", "B+" = "(74,79]",
      "A-" = "(79,84]", "A" = "(84,89]", "A+" = "(89,100]"))
scores_schemes

## ---- bar-range
scores_schemes %>% 
  ggplot(aes(x = range)) +
  geom_bar()

## ---- bar-grade
scores_schemes %>% 
  ggplot(aes(x = grade)) +
  geom_bar()

## ---- lubridate
library(lubridate)

## ---- dt
(td <- today())
class(td)
typeof(td)
as.integer(td) # 1970-01-01

## ---- dttm
(current <- now())
class(current)
typeof(current)
as.integer(current) # 1970-01-01 00:00:00

## ---- create-dttm
make_date(2021, c(3, 6), c(31, 4))
make_datetime(2021, c(3, 6), c(31, 4), c(16, 10))
make_datetime(2021, c(3, 6), c(31, 4), c(16, 10), tz = "Pacific/Auckland")

## ---- tz-name
set.seed(220)
OlsonNames()[sample(1:length(OlsonNames()), 32)]

## ---- parse-dttm
ymd(c("2021/03/31", "2021-June-04"))
ymd_h(c("2021-03-31 16", "2021-June-04 10"))
(dttm <- ymd_h(c("2021-03-31 16", "2021-June-04 10"), tz = "Pacific/Auckland"))

## ---- convert-dttm
# origin: 1970-01-01
as_date(18713)
as_datetime(1616810967) 

## ---- extract
date(dttm)
year(dttm)
yday(dttm)
week(dttm)

## ---- extract2
day(dttm) # mday(dttm)
hour(dttm)
minute(dttm)
second(dttm)

## ---- extract-mth
month(dttm)
month(dttm, label = TRUE)

## ---- extract-wday
wday(dttm, week_start = 1)
wday(dttm, label = TRUE)
wday(dttm, label = TRUE, week_start = 1)

## ---- cal
floor_date(dttm, "3 hours")
ceiling_date(dttm, "2 days")
round_date(dttm, "1 month")

## ---- arith
dttm + 1
dttm + minutes(2)
dttm + hours(3)

## ---- arith1
dttm + days(4)

## ---- arith2
dttm + weeks(5)

## ---- arith3
dttm + months(6)

## ---- arith4
dttm + years(7)

## ---- fmt
format(dttm)
format(dttm, "%Y/%b/%d")
format(dttm, "%y/%b/%d %H:%M:%S")
format(dttm, "on %d %B (%a)")

## ---- release-date-chr
movies$Release_Date[c(38:39, 268)]

## ---- release-date
movies %>% 
  mutate(
    Release_Date = parse_date_time( #<<
      Release_Date, c("%d-%b-%y", "%Y-%m-%d")), #<<
    Year = year(Release_Date) #<<
  ) %>% 
  filter(Year < 2012) %>% 
  ggplot(aes(Year, IMDB_Rating)) +
  geom_hex()

