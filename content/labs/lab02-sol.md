---
output: 
  md_document:
    preserve_yaml: true
    variant: gfm
layout: page
title: Lab 02 Solution
---

This lab exercise is **due 23:59 Monday 22 March (NZDT)**.

-   You should submit an R file (i.e. file extension `.R`) containing R
    code that assigns values to **the appropriate symbols**.
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

In this lab exercise, you are going to work with two data sets: user
reviews for Animal Crossing - New Horizons as in `user_reviews.tsv` and
Gapminder as in `gapminder.rds`. You shall use the following packages
for this lab session:

``` r
library(tidyverse)
```

-   Make sure to include the snippet above upfront in your R file.
-   DO NOT include `install.packages()` in your R file.

Suppose that you have created an `Rproj` for this course. You need to
download `user_reviews.tsv`
[here](https://github.com/rfordatascience/tidytuesday/raw/master/data/2020/2020-05-05/user_reviews.tsv)
(right click, select “Download Linked File As”) to
`data/animal-crossing/` and `gapminder.rds`
[here](https://github.com/STATS-UOA/stats220/raw/master/lectures/data/gapminder.rds)
to `data/` under your `Rproj`.

-   You’re required to use **relative file paths
    `data/animal-crossing/user_reviews.tsv` and `data/gapminder.rds`**
    to import these data.
-   NO marks will be given for using URL links or different file paths.
-   Code below is only there to help you to verify your results. You DO
    NOT need to include the code like `sum(good_grade)`, and print these
    objects.

### Question 1

Import `data/animal-crossing/user_reviews.tsv` to R. You should end up
with a **tibble** called `user_reviews`.

``` r
user_reviews <- read_tsv("data/animal-crossing/user_reviews.tsv")
user_reviews
```

    #> # A tibble: 2,999 x 4
    #>    grade user_name   text                                   date      
    #>    <dbl> <chr>       <chr>                                  <date>    
    #>  1     4 mds27272    My gf started playing before me. No o… 2020-03-20
    #>  2     5 lolo2178    While the game itself is great, reall… 2020-03-20
    #>  3     0 Roachant    My wife and I were looking forward to… 2020-03-20
    #>  4     0 Houndf      We need equal values and opportunitie… 2020-03-20
    #>  5     0 ProfessorF… BEWARE!  If you have multiple people … 2020-03-20
    #>  6     0 tb726       The limitation of one island per Swit… 2020-03-20
    #>  7     0 Outryder86  I was very excited for this new insta… 2020-03-20
    #>  8     0 Subby89     It's 2020 and for some reason Nintend… 2020-03-20
    #>  9     0 RocketRon   This is so annoying. Only one player … 2020-03-20
    #> 10     0 chankills   I purchased this game for my househol… 2020-03-20
    #> # … with 2,989 more rows

### Question 2

Extract the `grade` column from the `user_reviews` tibble. You should
end up with **a double vector** called `user_grade`.

``` r
user_grade <- user_reviews[["grade"]]
mean(user_grade)
```

    #> [1] 4.217406

### Question 3

Compare `user_grade` to be greater than or equal to `7`. You should end
up with **a logical vector** called `good_grade`.

``` r
good_grade <- user_grade >= 7
typeof(good_grade)
```

    #> [1] "logical"

``` r
sum(good_grade)
```

    #> [1] 1130

### Question 4

Subset `user_reviews` given `user_grade` greater than or equal to `7`,
and the `text` column to be excluded. You should end up with a
**tibble** called `user_good_grade`.

``` r
user_good_grade <- user_reviews[good_grade, -3]
user_good_grade
```

    #> # A tibble: 1,130 x 3
    #>    grade user_name       date      
    #>    <dbl> <chr>           <date>    
    #>  1    10 000PLAYER000    2020-03-20
    #>  2     7 Drud            2020-03-20
    #>  3     9 AlexKidd        2020-03-20
    #>  4     8 ThornBattleborn 2020-03-20
    #>  5     8 Skideye         2020-03-20
    #>  6    10 GooMatt         2020-03-20
    #>  7    10 Aladis          2020-03-20
    #>  8    10 sknight1213     2020-03-20
    #>  9    10 Fliff           2020-03-20
    #> 10    10 dr_heartless    2020-03-20
    #> # … with 1,120 more rows

### Question 5

Find the function from
[{readr}](https://readr.tidyverse.org/reference/index.html) to import an
R data format `data/gapminder.rds` to R. You should end up with a
**tibble** called `gapminder`.

``` r
gapminder <- read_rds("data/gapminder.rds")
gapminder
```

    #> # A tibble: 1,704 x 6
    #>    country     continent  year lifeExp      pop gdpPercap
    #>    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
    #>  1 Afghanistan Asia       1952    28.8  8425333      779.
    #>  2 Afghanistan Asia       1957    30.3  9240934      821.
    #>  3 Afghanistan Asia       1962    32.0 10267083      853.
    #>  4 Afghanistan Asia       1967    34.0 11537966      836.
    #>  5 Afghanistan Asia       1972    36.1 13079460      740.
    #>  6 Afghanistan Asia       1977    38.4 14880372      786.
    #>  7 Afghanistan Asia       1982    39.9 12881816      978.
    #>  8 Afghanistan Asia       1987    40.8 13867957      852.
    #>  9 Afghanistan Asia       1992    41.7 16317921      649.
    #> 10 Afghanistan Asia       1997    41.8 22227415      635.
    #> # … with 1,694 more rows
