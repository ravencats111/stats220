---
output: 
  md_document:
    preserve_yaml: true
    variant: gfm
layout: page
title: Lab 11 Solution
---

This lab exercise is **due 23:59 Monday 7 June (NZST)**.

-   You should submit an R file (i.e. file extension `.R`) containing R
    code that assigns **the appropriate values** to **the appropriate
    symbols**.
-   Your R file will be executed in order and checked against the values
    that have been assigned to the symbols using an **automatic**
    grading system. Marks will be fully deducted for **non-identical**
    results.
-   Intermediate steps to achieve the final results will NOT be checked.
-   Each question is worth 0.2 points.
-   You should submit your R file on Canvas.
-   Late assignments are NOT accepted unless prior arrangement for
    medical/compassionate reasons.

------------------------------------------------------------------------

In this lab exercise, you are going to work with bus status data that
was collected on 2017-03-09 from Auckland Transport. You shall use the
following code snippet (and **include them upfront in your R file**) for
this lab session:

``` r
library(fs)
library(lubridate)
library(tidyverse)
csv_files <- dir_ls("data/aklbus2017", glob = "*.csv")
head(csv_files)
```

    #> data/aklbus2017/2017-03-09-05-14.csv
    #> data/aklbus2017/2017-03-09-05-24.csv
    #> data/aklbus2017/2017-03-09-05-34.csv
    #> data/aklbus2017/2017-03-09-05-44.csv
    #> data/aklbus2017/2017-03-09-05-54.csv
    #> data/aklbus2017/2017-03-09-06-04.csv

Suppose that you have created an `Rproj` for this course. You need to
download and unzip `aklbus2017.zip`
[here](https://raw.githubusercontent.com/STATS-UOA/stats220/master/lectures/data/aklbus2017.zip)
to `data/` under your `Rproj` folder.

Each file represents a snapshot of bus status information, where each
snapshot was taken approximately 10 minutes apart. Within each file,
each row of data gives the status of one bus. The `delay` is how many
seconds ahead or behind schedule the bus is (a positive value is behind
schedule and a negative value is ahead of schedule). The `stop.id`
identifies which bus stop the delay applies to. The `stop.sequence` is
the order of the bus stop within the bus route. The `route` identifies
the bus route.

-   You’re required to use **`csv_files`** to import these data. **NO
    marks will be given to this lab for using URL links or different
    file paths.**

### Question 1

Import all CSV files from the `data/aklbus2017`, with their unique
identifiers as `"path"`.

You should end up with a **tibble** called `aklbus`.

``` r
aklbus <- map_dfr(csv_files, read_csv, .id = "path")
aklbus
```

    #> # A tibble: 43,793 x 5
    #>    path                   delay stop.id stop.sequence route           
    #>    <chr>                  <dbl>   <dbl>         <dbl> <chr>           
    #>  1 data/aklbus2017/2017-…   150    5050            28 15401-201702141…
    #>  2 data/aklbus2017/2017-…    97    3093             6 83401-201702141…
    #>  3 data/aklbus2017/2017-…    50    4810            13 98105-201702141…
    #>  4 data/aklbus2017/2017-…    58    6838             5 36201-201702141…
    #>  5 data/aklbus2017/2017-…  -186    2745            11 37301-201702141…
    #>  6 data/aklbus2017/2017-…   183    2635            14 03301-201702141…
    #>  7 data/aklbus2017/2017-…  -144    3360             4 10001-201702141…
    #>  8 data/aklbus2017/2017-…  -151    2206            20 38011-201702141…
    #>  9 data/aklbus2017/2017-…   -46    2419            38 38011-201702141…
    #> 10 data/aklbus2017/2017-…  -513    6906            42 38012-201702141…
    #> # … with 43,783 more rows

### Question 2

Transform `aklbus`:

1.  replace `route` with their first 5 digits as the route identifier
2.  create a new column `datetime` that contains the recorded
    date-times, derived from the `path`
3.  remove the `path` column
4.  change the column positions as shown in `aklbus_time`

You should end up with a **tibble** called `aklbus_time`.

``` r
aklbus_time <- aklbus %>% 
  mutate(
    route = str_extract(route, "\\d{5}"),
    datetime = str_extract(path, "\\d{4}-.*[^.csv]"),
    datetime = ymd_hm(datetime, tz = "Pacific/Auckland"),
    path = NULL
  ) %>% 
  relocate(datetime)
aklbus_time
```

    #> # A tibble: 43,793 x 5
    #>    datetime            delay stop.id stop.sequence route
    #>    <dttm>              <dbl>   <dbl>         <dbl> <chr>
    #>  1 2017-03-09 05:14:00   150    5050            28 15401
    #>  2 2017-03-09 05:14:00    97    3093             6 83401
    #>  3 2017-03-09 05:14:00    50    4810            13 98105
    #>  4 2017-03-09 05:14:00    58    6838             5 36201
    #>  5 2017-03-09 05:14:00  -186    2745            11 37301
    #>  6 2017-03-09 05:14:00   183    2635            14 03301
    #>  7 2017-03-09 05:14:00  -144    3360             4 10001
    #>  8 2017-03-09 05:14:00  -151    2206            20 38011
    #>  9 2017-03-09 05:14:00   -46    2419            38 38011
    #> 10 2017-03-09 05:14:00  -513    6906            42 38012
    #> # … with 43,783 more rows

``` r
mean(aklbus_time$datetime)
```

    #> [1] "2017-03-09 13:30:23 NZDT"

### Question 3

Compute the percentage of on-time bus status (as `ontime_prop`) for each
route given that day. If the bus is ahead or behind schedule within 5
minutes, it is classified as on-time; otherwise late. Then arrange their
rows in ascending order by `ontime_prop`.

You should end up with a **tibble** called `aklbus_ontime`.

``` r
aklbus_ontime <- aklbus_time %>% 
  mutate(ontime = between(delay, -5 * 60, 5 * 60)) %>% 
  group_by(route) %>% 
  summarise(ontime_prop = sum(ontime) / n()) %>% 
  arrange(ontime_prop)
aklbus_ontime
```

    #> # A tibble: 1,082 x 2
    #>    route ontime_prop
    #>    <chr>       <dbl>
    #>  1 00152           0
    #>  2 00154           0
    #>  3 00164           0
    #>  4 00170           0
    #>  5 00452           0
    #>  6 00553           0
    #>  7 00651           0
    #>  8 00652           0
    #>  9 00653           0
    #> 10 00660           0
    #> # … with 1,072 more rows

``` r
mean(aklbus_ontime$ontime_prop)
```

    #> [1] 0.5356871

### Question 4

Exclude these bus routes from `aklbus_time`, if their on-time
percentages are either 0 or 1 during the day. Then split the rest of bus
routes into separate tibbles in a list.

You should end up with a **list** of tibbles called `aklbus_lst`.

``` r
aklbus_lst <- aklbus_time %>% 
  filter(route %in% (aklbus_ontime %>% 
    filter(!ontime_prop %in% c(0, 1)) %>% pull(route))) %>% 
  group_by(route) %>% 
  group_split()
aklbus_lst[[220]]
```

    #> # A tibble: 32 x 5
    #>    datetime            delay stop.id stop.sequence route
    #>    <dttm>              <dbl>   <dbl>         <dbl> <chr>
    #>  1 2017-03-09 05:54:00     6    4935            13 06001
    #>  2 2017-03-09 06:04:00   154    4890            18 06001
    #>  3 2017-03-09 06:14:00    97    4872            27 06001
    #>  4 2017-03-09 06:14:00  -104    4904             2 06001
    #>  5 2017-03-09 06:24:00   208    4862            32 06001
    #>  6 2017-03-09 06:24:00   121    4908            14 06001
    #>  7 2017-03-09 06:34:00   802    4885            34 06001
    #>  8 2017-03-09 06:34:00   197    4890            18 06001
    #>  9 2017-03-09 06:34:00   -31    4904             2 06001
    #> 10 2017-03-09 06:45:00   907    5640            42 06001
    #> # … with 22 more rows

``` r
length(aklbus_lst)
```

    #> [1] 817

### Question 5

Get the dimension (the number of rows and colums) of each tibble in the
`aklbus_lst`.

You should end up with a **list** of integers called `aklbus_size`. Each
element of the list is an **integer** vector of length two.

``` r
aklbus_size <- aklbus_lst %>% 
  map(dim)
head(aklbus_size)
```

    #> [[1]]
    #> [1] 64  5
    #> 
    #> [[2]]
    #> [1] 88  5
    #> 
    #> [[3]]
    #> [1] 12  5
    #> 
    #> [[4]]
    #> [1] 24  5
    #> 
    #> [[5]]
    #> [1] 5 5
    #> 
    #> [[6]]
    #> [1] 3 5

``` r
typeof(aklbus_size[[1]])
```

    #> [1] "integer"
