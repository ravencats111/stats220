---
output: 
  md_document:
    preserve_yaml: true
    variant: gfm
layout: page
title: Assignment 2 Solution
---

This assignment is **due 23:59 Friday 30 April (NZST)**.

-   You should submit an R file (i.e. file extension `.R`) containing R
    code that assigns **the appropriate values** to **the appropriate
    symbols**.
-   Your R file will be executed in order and checked against the values
    that have been assigned to the relevant symbols using an
    **automatic** grading system. Marks will be fully deducted for
    **non-identical** results.
-   Intermediate steps to achieve the final results will NOT be checked.
-   Each question is worth 1 point.
-   You should submit your R file on Canvas.
-   Late assignments are NOT accepted unless prior arrangement for
    medical/compassionate reasons.

------------------------------------------------------------------------

In this assignment, you will continue working with 2018 Citi Bike trip
data in New York City (`2018-citibike-tripdata.csv`). The data includes:

-   Trip Duration (seconds)
-   Start Time and Date
-   Stop Time and Date
-   Start Station Name
-   End Station Name
-   Station ID
-   Station Lat/Long
-   Bike ID
-   User Type (Customer = 24-hour pass or 3-day pass user; Subscriber =
    Annual Member)
-   Gender (0=unknown; 1=male; 2=female)
-   Year of Birth

You shall use the following code snippet (and **include them upfront in
your R file**) to start with this assignment:

``` r
library(lubridate)
library(tidyverse)
nycbikes18 <- read_csv("data/2018-citibike-tripdata.csv",
  locale = locale(tz = "America/New_York"))
nycbikes18
```

    #> # A tibble: 333,687 x 15
    #>    tripduration starttime           stoptime           
    #>           <dbl> <dttm>              <dttm>             
    #>  1          932 2018-01-01 02:06:17 2018-01-01 02:21:50
    #>  2          550 2018-01-01 12:06:18 2018-01-01 12:15:28
    #>  3          510 2018-01-01 12:06:56 2018-01-01 12:15:27
    #>  4          354 2018-01-01 14:53:10 2018-01-01 14:59:05
    #>  5          250 2018-01-01 17:34:30 2018-01-01 17:38:40
    #>  6          613 2018-01-01 22:05:05 2018-01-01 22:15:19
    #>  7          290 2018-01-02 12:13:51 2018-01-02 12:18:42
    #>  8          381 2018-01-02 12:50:03 2018-01-02 12:56:24
    #>  9          318 2018-01-02 13:55:58 2018-01-02 14:01:16
    #> 10         1852 2018-01-02 16:55:29 2018-01-02 17:26:22
    #> # … with 333,677 more rows, and 12 more variables:
    #> #   start_station_id <dbl>, start_station_name <chr>,
    #> #   start_station_latitude <dbl>, start_station_longitude <dbl>,
    #> #   end_station_id <dbl>, end_station_name <chr>,
    #> #   end_station_latitude <dbl>, end_station_longitude <dbl>,
    #> #   bikeid <dbl>, usertype <chr>, birth_year <dbl>, gender <dbl>

Suppose that you have created an `Rproj` for this course. You need to
download `2018-citibike-tripdata.csv`
[here](https://github.com/STATS-UOA/stats220/releases/download/v1.0/2018-citibike-tripdata.csv)
to `data/` under your `Rproj` folder.

-   You’re required to use **relative file paths
    `data/2018-citibike-tripdata.csv`** to import the data. **NO marks
    will be given for using URL links or different file paths for this
    assignment.**
-   NO marks given to the question, in which you apply `theme()` and
    aesthetics other than what I instruct to the plot.

### Question 1

Let’s take a second look 😉 at where Citi bike stations are located.
Visualise the following layered bubble charts:

1.  points of all start stations. Sizes vary with the total number of
    pickups.
2.  points of all end stations. Sizes vary with the total number of
    returns.

You should end up with a **ggplot** object named `p1`, with
`alpha = 0.5` to both layers.

<details>
<summary>
HINTS
</summary>

1.  Check out the
    [{ggplot2}](https://ggplot2.tidyverse.org/reference/index.html#section-layers)
    reference page for a handy `geom_*()` to quickly get this done.

</details>

<br>

``` r
p1 <- nycbikes18 %>%
  ggplot() +
  geom_count(aes(start_station_longitude, start_station_latitude),
    alpha = 0.5) +
  geom_count(aes(end_station_longitude, end_station_latitude),
    alpha = 0.5)
p1
```

<img src="/figures/a2-q1-1.png" width="840" />

### Question 2

Find **the most frequently used bike**’s data records.

You should end up with a **tibble** called `top_bike_trips`.

``` r
most_used_bike <- nycbikes18 %>% 
  count(bikeid, sort = TRUE) %>% 
  pull(bikeid) %>% 
  first()
top_bike_trips <- nycbikes18 %>% 
  filter(bikeid == most_used_bike)
top_bike_trips
```

    #> # A tibble: 825 x 15
    #>    tripduration starttime           stoptime           
    #>           <dbl> <dttm>              <dttm>             
    #>  1          520 2018-01-03 13:06:21 2018-01-03 13:15:01
    #>  2          232 2018-01-03 17:01:21 2018-01-03 17:05:14
    #>  3          315 2018-01-14 15:08:14 2018-01-14 15:13:30
    #>  4          266 2018-01-23 14:57:30 2018-01-23 15:01:57
    #>  5          162 2018-01-24 17:01:10 2018-01-24 17:03:53
    #>  6          150 2018-01-25 18:26:58 2018-01-25 18:29:29
    #>  7          272 2018-01-03 08:49:11 2018-01-03 08:53:43
    #>  8          315 2018-01-20 14:06:28 2018-01-20 14:11:44
    #>  9          322 2018-01-02 15:43:42 2018-01-02 15:49:04
    #> 10          251 2018-01-10 17:48:03 2018-01-10 17:52:14
    #> # … with 815 more rows, and 12 more variables:
    #> #   start_station_id <dbl>, start_station_name <chr>,
    #> #   start_station_latitude <dbl>, start_station_longitude <dbl>,
    #> #   end_station_id <dbl>, end_station_name <chr>,
    #> #   end_station_latitude <dbl>, end_station_longitude <dbl>,
    #> #   bikeid <dbl>, usertype <chr>, birth_year <dbl>, gender <dbl>

### Question 3

Plot all journeys that the most frequently used bike has travelled on.

You should end up with a **ggplot** called `p2`, with `alpha = 0.5`.

``` r
p2 <- top_bike_trips %>% 
  ggplot(aes(start_station_longitude, start_station_latitude)) +
  geom_segment(
    aes(xend = end_station_longitude, yend = end_station_latitude),
    alpha = 0.5)
p2
```

<img src="/figures/a2-q3-1.png" width="840" />

### Question 4

In order to study different riding behaviours by age groups, you’ll
transform `nycbikes18` to a **tibble** called `nycbikes18_age`:

1.  modify `tripduration` to be converted in minutes.
2.  when `birth_year` is less than 1900, replace values with `NA_real_`.
3.  add a new column `age` derived from user’s birth year based on 2018.
4.  add a new column `age_group` that bins `age` into groups: 0-14,
    15-24, 25-44, 45-64, 65+.

``` r
age_brk <- c(0, 14, 24, 44, 64, Inf)
nycbikes18_age <- nycbikes18 %>% 
  mutate(
    tripduration = tripduration / 60,
    birth_year = case_when(birth_year < 1900 ~ NA_real_, TRUE ~ birth_year),
    age = 2018 - birth_year,
    age_group = cut(age, age_brk, include.lowest = TRUE),
    age_group = fct_recode(age_group, "65+" = "(64,Inf]")
  )
glimpse(nycbikes18_age)
```

    #> Rows: 333,687
    #> Columns: 17
    #> $ tripduration            <dbl> 15.533333, 9.166667, 8.500000, 5.900…
    #> $ starttime               <dttm> 2018-01-01 02:06:17, 2018-01-01 12:…
    #> $ stoptime                <dttm> 2018-01-01 02:21:50, 2018-01-01 12:…
    #> $ start_station_id        <dbl> 3183, 3183, 3183, 3183, 3183, 3183, …
    #> $ start_station_name      <chr> "Exchange Place", "Exchange Place", …
    #> $ start_station_latitude  <dbl> 40.71625, 40.71625, 40.71625, 40.716…
    #> $ start_station_longitude <dbl> -74.03346, -74.03346, -74.03346, -74…
    #> $ end_station_id          <dbl> 3199, 3199, 3199, 3267, 3639, 3203, …
    #> $ end_station_name        <chr> "Newport Pkwy", "Newport Pkwy", "New…
    #> $ end_station_latitude    <dbl> 40.72874, 40.72874, 40.72874, 40.712…
    #> $ end_station_longitude   <dbl> -74.03211, -74.03211, -74.03211, -74…
    #> $ bikeid                  <dbl> 31929, 31845, 31708, 31697, 31861, 3…
    #> $ usertype                <chr> "Subscriber", "Subscriber", "Subscri…
    #> $ birth_year              <dbl> 1992, 1969, 1946, 1994, 1991, 1982, …
    #> $ gender                  <dbl> 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, …
    #> $ age                     <dbl> 26, 49, 72, 24, 27, 36, 60, 29, 58, …
    #> $ age_group               <fct> "(24,44]", "(44,64]", "65+", "(14,24…

``` r
sum(is.na(nycbikes18_age$birth_year))
```

    #> [1] 126

``` r
mean(nycbikes18_age$age, na.rm = TRUE)
```

    #> [1] 37.63694

``` r
levels(nycbikes18_age$age_group)
```

    #> [1] "[0,14]"  "(14,24]" "(24,44]" "(44,64]" "65+"

### Question 5

Generate a side-by-side boxplot to demonstrate the differences of trip
durations across age groups coloured by user types. (**NOTE:** you need
to modify labels of this plot.)

You should end up with a **ggplot** called `p3`, with

-   labeling `"Age Group"` to x axis
-   labeling `"Trip in minutes (on log10)"` to y axis

``` r
p3 <- nycbikes18_age %>% 
  ggplot(aes(age_group, tripduration)) +
  geom_boxplot(aes(colour = usertype)) +
  scale_y_log10() +
  labs(x = "Age Group", y = "Trip in minutes (on log10)")
p3
```

<img src="/figures/a2-q5-1.png" width="840" />

### Question 6

Plot a grouped bar chart that sums up the number of trips by months of
`startime` and gender.

You should end up with a **ggplot** called `p4`.

<details>
<summary>
HINTS
</summary>

Key steps:

1.  extract months of `starttime`.
2.  modify `gender`.

</details>

<br>

``` r
p4 <- nycbikes18 %>% 
  group_by(month = month(starttime, label = TRUE), gender) %>% 
  summarise(ntrips = n()) %>% 
  ungroup() %>% 
  mutate(gender = fct_recode(fct_reorder(as_factor(gender), ntrips),
    "unknown" = "0", "male" = "1", "female" = "2")) %>% 
  ggplot(aes(gender, ntrips)) +
  geom_col(aes(fill = month), position = "dodge")
p4
```

<img src="/figures/a2-q6-1.png" width="840" />

### Question 7

Produce a line graph depicting **the 3rd quantile of trip durations** by
months of `starttime` and age groups. (**NOTE:** check out the legend
order that matches to the last value of each line.)

You should end up with a **ggplot** called `p5`.

<details>
<summary>
HINTS
</summary>

1.  Check out the
    [{forcats}](https://forcats.tidyverse.org/reference/index.html#section-change-order-of-levels)
    reference page for a function that you can reorder the levels of
    `age_group` as required.
2.  You need to use `aes(group = <GROUP>)` to show lines.

</details>

<br>

``` r
p5 <- nycbikes18_age %>% 
  group_by(month = month(starttime, label = TRUE), age_group) %>% 
  summarise(qtl_tripd = quantile(tripduration, 0.75)) %>% 
  mutate(age_group = fct_reorder2(age_group, month, qtl_tripd)) %>% 
  ungroup() %>% 
  ggplot(aes(month, qtl_tripd, group = age_group)) +
  geom_line(aes(colour = age_group))
p5
```

<img src="/figures/a2-q7-1.png" width="840" />

### Question 8

Present the following pivot table that counts the number of trips by
upper-tail user’s types and age groups. **Upper-tail users are defined
as the ones who ride for longer periods than 90% of users of the same
age group.** (**NOTE:** the column headers of `user_behaviours`)

You should end up with a **tibble** called `user_behaviours`.

<details>
<summary>
HINTS
</summary>

Key steps:

1.  subset.
2.  summarise.
3.  pivot.

</details>

<br>

``` r
user_behaviours <- nycbikes18_age %>% 
  group_by(age_group) %>% 
  filter(tripduration > quantile(tripduration, 0.9)) %>% 
  group_by(usertype, age_group) %>% 
  summarise(ntrips = n()) %>% 
  rename(`Age Group` = age_group) %>% 
  pivot_wider(names_from = usertype, values_from = ntrips)
user_behaviours
```

    #> # A tibble: 5 x 3
    #>   `Age Group` Customer Subscriber
    #>   <fct>          <int>      <int>
    #> 1 (14,24]          641        706
    #> 2 (24,44]         3749      19864
    #> 3 (44,64]         4760       3275
    #> 4 65+               25        289
    #> 5 <NA>              NA         13

### Question 9

You’re going to get `nycbikes18` prepared in a form for the final
question:

1.  modify `starttime` down to the nearest hour.
2.  aggregate to hourly number of trips (denoted as `ntrips`) by user
    types.
3.  add new columns `startdate`, `starthour`, and `startwday` that
    contain dates, hours of the day, and weekdays respectively extracted
    from `starttime`.

You should end up with a **tibble** called `hourly_ntrips`.

``` r
hourly_ntrips <- nycbikes18 %>% 
  mutate(starttime = floor_date(starttime, "1 hour")) %>% 
  group_by(starttime, usertype) %>% 
  summarise(ntrips = n()) %>% 
  ungroup() %>% 
  mutate(
    startdate = as_date(starttime),
    starthour = hour(starttime),
    startwday = wday(starttime, label = TRUE, week_start = 1)
  )
hourly_ntrips
```

    #> # A tibble: 11,739 x 6
    #>    starttime           usertype  ntrips startdate  starthour startwday
    #>    <dttm>              <chr>      <int> <date>         <int> <ord>    
    #>  1 2018-01-01 00:00:00 Subscrib…      1 2018-01-01         0 Mon      
    #>  2 2018-01-01 01:00:00 Subscrib…      3 2018-01-01         1 Mon      
    #>  3 2018-01-01 02:00:00 Subscrib…      3 2018-01-01         2 Mon      
    #>  4 2018-01-01 03:00:00 Subscrib…      7 2018-01-01         3 Mon      
    #>  5 2018-01-01 04:00:00 Subscrib…      1 2018-01-01         4 Mon      
    #>  6 2018-01-01 06:00:00 Subscrib…      2 2018-01-01         6 Mon      
    #>  7 2018-01-01 08:00:00 Subscrib…      5 2018-01-01         8 Mon      
    #>  8 2018-01-01 09:00:00 Subscrib…      2 2018-01-01         9 Mon      
    #>  9 2018-01-01 10:00:00 Subscrib…      4 2018-01-01        10 Mon      
    #> 10 2018-01-01 11:00:00 Subscrib…      3 2018-01-01        11 Mon      
    #> # … with 11,729 more rows

``` r
mean(hourly_ntrips$starttime)
```

    #> [1] "2018-06-29 14:11:53 EDT"

``` r
mean(hourly_ntrips$ntrips)
```

    #> [1] 28.4255

``` r
levels(hourly_ntrips$startwday)
```

    #> [1] "Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun"

### Question 10

Let’s look at user behaviours between Subscriber and Customer in
temporal context. Visualise the following layered graphics, faceted by
weekdays and user types:

1.  grey lines indicating the hourly number of trips against time of the
    day from `hourly_ntrips`, with `colour = "#bdbdbd"` and
    `alpha = 0.5`.
2.  superimposed lines indicating the average number of trips by hours
    of the day, weekdays, and user types, with `size = 1`.

You should end up with a **ggplot** object named `p6` with a
black-and-white theme.

<details>
<summary>
HINTS
</summary>
Oops! No hints for this question.
</details>

<br>

``` r
avg_ntrips <- hourly_ntrips %>% 
  group_by(starthour, startwday, usertype) %>% 
  summarise(ntrips = mean(ntrips))
p6 <- hourly_ntrips %>% 
  ggplot(aes(starthour, ntrips)) +
  geom_line(aes(group = startdate), colour = "#bdbdbd", alpha = 0.5) +
  geom_line(aes(group = startwday, colour = startwday), size = 1,
    data = avg_ntrips) +
  facet_grid(usertype ~ startwday, scales = "free_y") +
  theme_bw()
p6
```

<img src="/figures/a2-q10-1.png" width="840" />

### Question4fun (NO marks)

Create an interactive map that marks all bike stations in clusters. By
zooming in and out, you can see how clusters change. By hovering
individual markers, you should be able to query the station name.

``` r
library(leaflet)
start_station <- nycbikes18 %>% 
  distinct(start_station_longitude, start_station_latitude, 
    start_station_name) %>% 
  rename_with(~ c("station", "lat", "long"))
end_station <- nycbikes18 %>% 
  distinct(end_station_longitude, end_station_latitude,
    end_station_name) %>% 
  rename_with(~ c("station", "lat", "long"))
stations <- bind_rows(start_station, end_station) %>% 
  distinct(lat, long, station)
stations %>% 
  leaflet() %>% 
  addTiles() %>% 
  addMarkers(label = ~ station, clusterOptions = markerClusterOptions()) %>% 
  addProviderTiles(providers$CartoDB.Positron)
```

<div id="htmlwidget-83c17411b505829fdc4f" class="leaflet html-widget"
style="width:740px;height:480px;">

</div>

<script type="application/json" data-for="htmlwidget-83c17411b505829fdc4f">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addMarkers","args":[[40.7162469,40.7141454,40.7177325,40.7195861164717,40.7211236,40.7101087,40.714402,40.7104670233797,40.7182113,40.7112423,40.7246050998869,40.7253399253558,40.7307426253066,40.7443187,40.7487159453802,40.7287448,40.7111305,40.737711,40.7272235,40.727595966,40.7165397809919,40.7311689,40.7376037,40.7241765,40.742677141,40.72152515,40.734785818,40.71848892,40.7127742,40.6970299,40.698650544,40.7349610200095,40.7236589,40.7124188237569,40.7134638266919,40.7260117296463,40.7252891078113,40.6926399661833,40.7233315864644,40.72165072488,40.7049575167286,40.7183551982321,40.7145840353589,40.7143583687043,40.725685483629,40.7216301426384,40.719282200707,40.7459099663156,40.7096508336406,40.71649,40.7242941,40.7192517,40.73367,40.71942,40.7275514673001,40.7257261374256,40.722103786686,40.7151776773203,40.71113,40.75992262,40.76087502,40.7153379,40.72362738,40.72243797,40.7149787,40.74691959,40.813358,40.74025878,40.701907,40.7457121,40.6793307,40.711512,40.744219,40.71754834,40.70463334,40.711066,40.76695317,40.75594159,40.74334935,40.805973,40.76370739,40.74901271,40.69089272,40.68763155,40.8143256,40.76590936,40.7734066,40.7277140777778,40.71748752,40.7249467235942,40.71173107,40.69165183,40.74765947,40.7462009,40.76341379,40.76030096,40.75510267,40.7148515052625,40.70862144,40.768254,40.74854862,40.73649403,40.8067581,40.7489006,40.70706456,40.74475148,40.71291224,40.73172428,40.70823502,40.7746671,40.770513,40.71625008,40.68539567,40.73401143,40.70255065,40.73047747,40.75968085,40.7961535,40.75660359,40.70122128,40.7757937668367],[-74.0334588,-74.0335519,-74.043845,-74.0431174635887,-74.03805095,-74.0858489,-74.0887723,-74.0700387954712,-74.0836394,-74.0557013,-74.0784059464931,-74.0676221251488,-74.0637838840485,-74.0439909,-74.0404433012009,-74.0321082,-74.0788855,-74.066921,-74.0337589,-74.044247311,-74.0496379137039,-74.0575736,-74.0524783,-74.0506564,-74.051788633,-74.046304543,-74.050443636,-74.047726625,-74.0364857,-74.0969366,-74.082079678,-74.0595030784607,-74.0641943,-74.0385255217552,-74.0628585219383,-74.0503889322281,-74.0455716848373,-74.08801227808,-74.0459525585174,-74.0428841114044,-74.0859308838844,-74.0389144420624,-74.042817056179,-74.0666109323502,-74.0487903356552,-74.0499678254128,-74.071261882782,-74.0572714805603,-74.0686011314392,-74.04105,-74.0354826,-74.034234,-74.0625,-74.05099,-74.0710607171059,-74.0719592571259,-74.0714550018311,-74.0376833081245,-74.0789,-73.97648516,-74.00277668,-74.01658354,-73.99949601,-74.00566443,-74.013012,-74.00451887,-73.956461,-73.98409214,-74.013942,-73.98194829,-73.97519523,-74.015756,-73.97121214,-74.01322069,-74.01361706,-74.009447,-73.98169333,-74.0021163,-74.00681753,-73.964928,-73.9851615,-73.98848395,-73.99612349,-74.0016256,-73.9590255,-73.97634151,-73.97782542,-74.011295735836,-74.0104554,-74.0016585588455,-73.99193043,-73.9999786,-73.98490707,-73.98855723,-73.99667444,-73.99884222,-73.97498696,-74.0112233161926,-74.00722156,-73.988639,-73.98808416,-73.99704374,-73.9607082,-73.97604882,-74.00731853,-73.99915362,-74.01020234,-74.00674436,-74.00530063,-73.98470567,-73.988038,-74.0091059,-73.97431458,-74.00293877,-74.0127234,-73.99906065,-73.97031366,-73.94782145,-73.9979009,-74.01234218,-73.9762057363987],null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},null,null,{"showCoverageOnHover":true,"zoomToBoundsOnClick":true,"spiderfyOnMaxZoom":true,"removeOutsideVisibleBounds":true,"spiderLegPolylineOptions":{"weight":1.5,"color":"#222","opacity":0.5},"freezeAtZoom":false},null,["Exchange Place","Paulus Hook","City Hall","Grove St PATH","Warren St","NJCU","West Side Light Rail","Garfield Ave Station","Union St","Liberty Light Rail","Lincoln Park","McGinley Square","Sip Ave","Riverview Park","Heights Elevator","Newport Pkwy","MLK Light Rail","Dey St","Newport PATH","Hamilton Park","JC Medical Center","Hilltop","Oakland Ave","Brunswick St","Pershing Field","Newark Ave","Christ Hospital","Van Vorst Park","Essex Light Rail","Columbia Park","Bayside Park","5 Corners Library","Baldwin at Montgomery","Morris Canal","Lafayette Park","Brunswick &amp; 6th","Jersey &amp; 6th St","Danforth Light Rail","Jersey &amp; 3rd","Manila &amp; 1st","Bethune Center","Columbus Drive","Marin Light Rail","Communipaw &amp; Berry Lane","Monmouth and 6th","Dixon Mills","Astor Place","Leonard Gordon Park","JCBS Depot","York St","Washington St","Harborside","Journal Square","Montgomery St","Glenwood Ave","Fairmount Ave","Bergen Ave","Grand St","Jackson Square","W 52 St &amp; 5 Ave","12 Ave &amp; W 40 St","Vesey Pl &amp; River Terrace","Mercer St &amp; Spring St","6 Ave &amp; Canal St","Murray St &amp; West St","W 22 St &amp; 10 Ave","Amsterdam Ave &amp; W 125 St","Lexington Ave &amp; E 24 St","Bus Slip &amp; State St","E 32 St &amp; Park Ave","Prospect Pl &amp; 6 Ave","South End Ave &amp; Liberty St","FDR Drive &amp; E 35 St","West St &amp; Chambers St","Broadway &amp; Battery Pl","Fulton St &amp; Broadway","Broadway &amp; W 58 St","W 34 St &amp; 11 Ave","W 16 St &amp; The High Line","W 113 St &amp; Broadway","8 Ave &amp; W 52 St","6 Ave &amp; W 33 St","Henry St &amp; Atlantic Ave","Columbia St &amp; Kane St","Broadway &amp; Moylan Pl","Central Park S &amp; 6 Ave","Central Park West &amp; W 68 St","Pier 40 - Hudson River Park","Duane St &amp; Greenwich St","W Broadway &amp; Spring Street","Pike St &amp; Monroe St","Atlantic Ave &amp; Furman St","E 33 St &amp; 5 Ave","Broadway &amp; W 29 St","W 46 St &amp; 11 Ave","11 Ave &amp; W 41 St","E 47 St &amp; Park Ave","Murray St &amp; Greenwich St","John St &amp; William St","W 56 St &amp; 10 Ave","Broadway &amp; W 32 St","W 13 St &amp; 6 Ave","W 116 St &amp; Amsterdam Ave","E 39 St &amp; 3 Ave","Maiden Ln &amp; Pearl St","W 22 St &amp; 8 Ave","Barclay St &amp; Church St","Barrow St &amp; Hudson St","Cliff St &amp; Fulton St_1","Amsterdam Ave &amp; W 66 St","W 59 St &amp; 10 Ave","Hudson St &amp; Reade St","S Portland Ave &amp; Hanson Pl","W 4 St &amp; 7 Ave S","Water - Whitehall Plaza","Sullivan St &amp; Washington Sq","E 55 St &amp; Lexington Ave","E 110 St &amp; Madison Ave","W 37 St &amp; 10 Ave","South St &amp; Whitehall St","Central Park West &amp; W 72 St"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addProviderTiles","args":["CartoDB.Positron",null,null,{"errorTileUrl":"","noWrap":false,"detectRetina":false}]}],"limits":{"lat":[40.6793307,40.8143256],"lng":[-74.0969366,-73.94782145]}},"evals":[],"jsHooks":[]}</script>
