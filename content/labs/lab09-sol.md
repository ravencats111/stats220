---
output: 
  md_document:
    preserve_yaml: true
    variant: gfm
layout: page
title: Lab 09 Solution
---

This lab exercise is **due 23:59 Monday 24 May (NZST)**.

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

In this lab exercise, you are going to scrape [top 50 horror films rated
by users from
IMDB](https://www.imdb.com/search/title/?title_type=feature&num_votes=25000,&genres=horror&sort=user_rating,desc&view=simple&sort=user_rating).
You shall use the following code snippet (and **include them upfront in
your R file**) for this lab session:

``` r
library(rvest)
library(tidyverse)
link <- "https://www.imdb.com/search/title/?title_type=feature&num_votes=25000,&genres=horror&sort=user_rating,desc&view=simple&sort=user_rating"
horror <- read_html(link)
horror
```

    #> {html_document}
    #> <html xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml">
    #> [1] <head>\n<meta http-equiv="Content-Type" content="text/html; cha ...
    #> [2] <body id="styleguide-v2" class="fixed">\n            <img heigh ...

### Question 1

Scrape top 50 horror films’ posters.

You should end up with a **character** vector of length 50, called
`film_poster`.

``` r
film_poster <- horror %>% 
  html_elements(".loadlate") %>% 
  html_attr("loadlate")
head(film_poster)
```

    #> [1] "https://m.media-amazon.com/images/M/MV5BNTQwNDM1YzItNDAxZC00NWY2LTk0M2UtNDIwNWI5OGUyNWUxXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg"
    #> [2] "https://m.media-amazon.com/images/M/MV5BZWFlYmY2MGEtZjVkYS00YzU4LTg0YjQtYzY1ZGE3NTA5NGQxXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UX34_CR0,0,34,50_AL_.jpg"
    #> [3] "https://m.media-amazon.com/images/M/MV5BMmQ2MmU3NzktZjAxOC00ZDZhLTk4YzEtMDMyMzcxY2IwMDAyXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg"
    #> [4] "https://m.media-amazon.com/images/M/MV5BYmQxNmU4ZjgtYzE5Mi00ZDlhLTlhOTctMzJkNjk2ZGUyZGEwXkEyXkFqcGdeQXVyMzgxMDA0Nzk@._V1_UY50_CR0,0,34,50_AL_.jpg"
    #> [5] "https://m.media-amazon.com/images/M/MV5BNDkxMzk2ODU4N15BMl5BanBnXkFtZTgwNTM4NjIzMjE@._V1_UY50_CR0,0,34,50_AL_.jpg"                                
    #> [6] "https://m.media-amazon.com/images/M/MV5BNGViZWZmM2EtNGYzZi00ZDAyLTk3ODMtNzIyZTBjN2Y1NmM1XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_UX34_CR0,0,34,50_AL_.jpg"

### Question 2

Scrape top 50 horror films’ titles.

You should end up with a **character** vector of length 50, called
`movie`.

``` r
movie <- horror %>% 
  html_elements(".col-title a") %>% 
  html_text2()
head(movie)
```

    #> [1] "Psycho"            "The Shining"       "Alien"            
    #> [4] "Tumbbad"           "The Blue Elephant" "The Thing"

### Question 3

Scrape top 50 horror films’ release years.

You should end up with a **double** vector of length 50, called `year`.

<details>
<summary>
HINTS
</summary>

1.  You may find one of [{readr}’s `parse_*()`
    functions](https://readr.tidyverse.org/reference/index.html#section-column-parsers)
    useful for extracting numbers.

</details>

<br>

``` r
year <- horror %>% 
  html_elements(".text-muted") %>% 
  html_text2() %>% 
  parse_number()
year
```

    #>  [1] 1960 1980 1979 2018 2014 1982 1962 1955 1920 1973 1968 2008 2004
    #> [14] 1978 1968 1933 1932 1922 2010 1961 1935 1931 2017 2014 2000 1987
    #> [27] 1978 1965 1963 1960 1960 1956 1933 2018 2016 2011 2009 2004 2002
    #> [40] 2001 1986 1975 1954 2019 2018 2010 2013 2007 1994 1992

### Question 4

Scrape top 50 horror films’ user ratings.

You should end up with a **double** vector of length 50, called
`rating`.

``` r
rating <- horror %>% 
  html_elements(".col-imdb-rating") %>% 
  html_text2() %>% 
  parse_number()
rating
```

    #>  [1] 8.5 8.4 8.4 8.3 8.2 8.1 8.1 8.1 8.1 8.0 8.0 7.9 7.9 7.9 7.9 7.9
    #> [17] 7.9 7.9 7.8 7.8 7.8 7.8 7.7 7.7 7.7 7.7 7.7 7.7 7.7 7.7 7.7 7.7
    #> [33] 7.7 7.6 7.6 7.6 7.6 7.6 7.6 7.6 7.6 7.6 7.6 7.5 7.5 7.5 7.5 7.5
    #> [49] 7.5 7.5

### Question 5

Create a tibble that contains these scraped films’ information ordered
by their ranks. The column names are `Rank`, `Poster`, `Movie`, `Year`,
`Rating` respectively.

You should end up with a **tibble**, called `top50_horror`.

**NOTE:** the `Rank` column is of integers.

``` r
top50_horror <- tibble(
  Rank = seq_along(film_poster),
  Poster = film_poster,
  Movie = movie,
  Year = year,
  Rating = rating)
top50_horror
```

    #> # A tibble: 50 x 5
    #>     Rank Poster                          Movie             Year Rating
    #>    <int> <chr>                           <chr>            <dbl>  <dbl>
    #>  1     1 https://m.media-amazon.com/ima… Psycho            1960    8.5
    #>  2     2 https://m.media-amazon.com/ima… The Shining       1980    8.4
    #>  3     3 https://m.media-amazon.com/ima… Alien             1979    8.4
    #>  4     4 https://m.media-amazon.com/ima… Tumbbad           2018    8.3
    #>  5     5 https://m.media-amazon.com/ima… The Blue Elepha…  2014    8.2
    #>  6     6 https://m.media-amazon.com/ima… The Thing         1982    8.1
    #>  7     7 https://m.media-amazon.com/ima… What Ever Happe…  1962    8.1
    #>  8     8 https://m.media-amazon.com/ima… Les diaboliques   1955    8.1
    #>  9     9 https://m.media-amazon.com/ima… Das Cabinet des…  1920    8.1
    #> 10    10 https://m.media-amazon.com/ima… The Exorcist      1973    8  
    #> # … with 40 more rows

### Question4fun (NO marks)

Turn `top50_horror` into a searchable paged HTML table as follows.

``` r
library(reactable)
library(htmltools)

get_rating_colour <- function(rating) {
  orange_pal <- function(x) 
    rgb(colorRamp(c("#fdae6b", "#d94801"))(x), maxColorValue = 255)
  normalized <- rating / 10
  orange_pal(normalized)
}

col_img <- function() {
  colDef(
    maxWidth = 70,
    cell = function(value) { div(img(src = value)) })
}

col_text <- function() {
  colDef(minWidth = 70, maxWidth = 90, align = "center")
}

col_rate <- function() {
  colDef(
    defaultSortOrder = "desc",
    cell = JS("function(cellInfo) {
      const sliceColor = cellInfo.row['rating_colour']
      const sliceLength = 2 * Math.PI * 24
      const sliceOffset = sliceLength * (1 - cellInfo.value / 10)
      const donutChart = (
        '<svg width=60 height=60 style=\"transform: rotate(-90deg)\">' +
          '<circle cx=30 cy=30 r=24 fill=none stroke-width=4 stroke=rgba(0,0,0,0.1)></circle>' +
          '<circle cx=30 cy=30 r=24 fill=none stroke-width=4 stroke=' + sliceColor +
          ' stroke-dasharray=' + sliceLength + ' stroke-dashoffset=' + sliceOffset + '></circle>' +
        '</svg>'
      )
      const label = '<div style=\"position: absolute; top: 50%; left: 50%; ' +
        'transform: translate(-50%, -50%)\">' + cellInfo.value + '</div>'
      return '<div style=\"display: inline-flex; position: relative\">' + donutChart + label + '</div>'
    }"),
    html = TRUE,
    align = "center",
    width = 140)
}

top50_horror %>% 
  mutate(
    Year = as.character(Year),
    rating_colour = get_rating_colour(Rating)
  ) %>% 
  reactable(
    defaultColDef = colDef(headerStyle = list(background = "#f7f7f8")),
    defaultSorted = "Rank",
    searchable = TRUE,
    columns = list(
      Rank = col_text(),
      Poster = col_img(),
      Movie = colDef(maxWidth = 300),
      Year = col_text(),
      Rating = col_rate(),
      rating_colour = colDef(show = FALSE)
    ),
    highlight = TRUE,
    width = 690,
    theme = reactableTheme(
      cellStyle = list(
        display = "flex", 
        flexDirection = "column", 
        justifyContent = "center")
  ))
```

<div id="htmlwidget-55954100c66b26dc0aa6" class="reactable html-widget"
style="width:690px;height:auto;">

</div>

<script type="application/json" data-for="htmlwidget-55954100c66b26dc0aa6">{"x":{"tag":{"name":"Reactable","attribs":{"data":{"Rank":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],"Poster":["https://m.media-amazon.com/images/M/MV5BNTQwNDM1YzItNDAxZC00NWY2LTk0M2UtNDIwNWI5OGUyNWUxXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BZWFlYmY2MGEtZjVkYS00YzU4LTg0YjQtYzY1ZGE3NTA5NGQxXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMmQ2MmU3NzktZjAxOC00ZDZhLTk4YzEtMDMyMzcxY2IwMDAyXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BYmQxNmU4ZjgtYzE5Mi00ZDlhLTlhOTctMzJkNjk2ZGUyZGEwXkEyXkFqcGdeQXVyMzgxMDA0Nzk@._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BNDkxMzk2ODU4N15BMl5BanBnXkFtZTgwNTM4NjIzMjE@._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BNGViZWZmM2EtNGYzZi00ZDAyLTk3ODMtNzIyZTBjN2Y1NmM1XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BZmI0M2VmNTgtMWVhYS00Zjg1LTk1YTYtNmJmMjRkZmMwYTc2XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BZDVlZDdjNDktN2M4ZC00NjdkLThiMDctM2FiZWNlYjIzNDExXkEyXkFqcGdeQXVyMTA1NTM1NDI2._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BNWJiNGJiMTEtMGM3OC00ZWNlLTgwZTgtMzdhNTRiZjk5MTQ1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BYjhmMGMxZDYtMTkyNy00YWVmLTgyYmUtYTU3ZjcwNTBjN2I1XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BZmEwZGU2NzctYzlmNi00MGJkLWE3N2MtYjBlN2ZhMGJkZTZiXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BOWM4NTY2NTMtZDZlZS00NTgyLWEzZDMtODE3ZGI1MzI3ZmU5XkEyXkFqcGdeQXVyNzI1NzMxNzM@._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMTg5Mjk2NDMtZTk0Ny00YTQ0LWIzYWEtMWI5MGQ0Mjg1OTNkXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMzc1YTIyNjctYzhlNy00ZmYzLWI2ZWQtMzk4MmQwYzA0NGQ1XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMzRmN2E1ZDUtZDc2ZC00ZmI3LTkwOTctNzE2ZDIzMGJiMTYzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BZTY3YjYxZGQtMTM2YS00ZmYwLWFlM2QtOWFlMTU1NTAyZDQ2XkEyXkFqcGdeQXVyNTgyNTA4MjM@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMjMyYjgyOTQtZDVlZS00NTQ0LWJiNDItNGRlZmM3Yzc0N2Y0XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMTAxYjEyMTctZTg3Ni00MGZmLWIxMmMtOGM2NTFiY2U3MmExXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BZjRmNjc5MTYtYjc3My00ZjNiLTg4YjUtMTQ0ZTFkZmMxMDUzXkEyXkFqcGdeQXVyNDY5MTUyNjU@._V1_UY50_CR2,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BYTYxZTQwOGQtNTJjNC00ZmVhLWJjNTQtYzY0M2VjYzI5MmU1L2ltYWdlXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BOTUzMzAzMzEzNV5BMl5BanBnXkFtZTgwOTg1NTAwMjE@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMTQ0Njc1MjM0OF5BMl5BanBnXkFtZTgwNTY2NTUyMjE@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMjUxMDQwNjcyNl5BMl5BanBnXkFtZTgwNzcwMzc0MTI@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMjAwNDA5NzEwM15BMl5BanBnXkFtZTgwMTA1MDUyNDE@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BNTIyNThlMjMtMzUyMi00YmEyLTljMmYtMWRhN2Q3ZTllZjA4XkEyXkFqcGdeQXVyMzM4MjM0Nzg@._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMWY3ODZlOGMtNzJmOS00ZTNjLWI3ZWEtZTJhZTk5NDZjYWRjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BNzk1OGU2NmMtNTdhZC00NjdlLWE5YTMtZTQ0MGExZTQzOGQyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BZTU5ZThjNzAtNjc4NC00OTViLWIxYTYtODFmMTk5Y2NjZjZiL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMTAxNDA1ODc5MDleQTJeQWpwZ15BbWU4MDg2MDA4OTEx._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BZjM3ZTAzZDYtZmFjZS00YmQ1LWJlOWEtN2I4MDRmYzY5YmRlL2ltYWdlXkEyXkFqcGdeQXVyMjgyNjk3MzE@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BNzBiMWRhNzQtMjZhZS00NzFmLWE5YWMtOWY4NzIxMjYzZTEyXkEyXkFqcGdeQXVyMzg2MzE2OTE@._V1_UY50_CR2,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BYTExYjM3MDYtMzg4MC00MjU4LTljZjAtYzdlMTFmYTJmYTE4XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BYjllMmE0Y2YtYWIwZi00OWY1LWJhNWItYzM2MmNiYmFiZmRmXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMjk4NGZiMzAtODU1NS00MmQ4LWJiNmQtNWU5ZWU4Y2VmNWI0XkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMTkwOTQ4OTg0OV5BMl5BanBnXkFtZTgwMzQyOTM0OTE@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMjMwOTYyNDY4NV5BMl5BanBnXkFtZTcwNDI1ODk0Ng@@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMTU5MDg0NTQ1N15BMl5BanBnXkFtZTcwMjA4Mjg3Mg@@._V1_UY50_CR1,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMzQ2ZTBhNmEtZDBmYi00ODU0LTgzZmQtNmMxM2M4NzM1ZjE4XkEyXkFqcGdeQXVyNjE5MjUyOTM@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BYTFkM2ViMmQtZmI5NS00MjQ2LWEyN2EtMTI1ZmNlZDU3MTZjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMTAxMDE4Mzc3ODNeQTJeQWpwZ15BbWU4MDY2Mjg4MDcx._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BODcxMGMwOGEtMDUxMi00MzE5LTg4YTYtYjk1YjA4MzQxNTNlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BYTQyMmUwMjgtOTU0Yy00YTJiLWFlZjMtOWM5NGQ0OWY5YThjXkEyXkFqcGdeQXVyNjQ2MjQ5NzM@._V1_UY50_CR1,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMjAzNTk3MTc2OF5BMl5BanBnXkFtZTgwNzI5MzU5MTE@._V1_UY50_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BZmE0MGJhNmYtOWNjYi00Njc5LWE2YjEtMWMxZTVmODUwMmMxXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMjI0MDMzNTQ0M15BMl5BanBnXkFtZTgwMTM5NzM3NDM@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BODkwMTgxNjA2NF5BMl5BanBnXkFtZTgwMDc0OTcwOTE@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BODQ5NDQ0MjkwMF5BMl5BanBnXkFtZTcwNDg1OTU4NQ@@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMTM3NjA1NDMyMV5BMl5BanBnXkFtZTcwMDQzNDMzOQ@@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BMjA0MzExNzc3MV5BMl5BanBnXkFtZTcwODAxMzM0MQ@@._V1_UX34_CR0,0,34,50_AL_.jpg","https://m.media-amazon.com/images/M/MV5BYThmYjJhMGItNjlmOC00ZDRiLWEzNjUtZjU4MjA3MzY0MzFmXkEyXkFqcGdeQXVyNTI4MjkwNjA@._V1_UX34_CR0,0,34,50_AL_.jpg"],"Movie":["Psycho","The Shining","Alien","Tumbbad","The Blue Elephant","The Thing","What Ever Happened to Baby Jane?","Les diaboliques","Das Cabinet des Dr. Caligari","The Exorcist","Rosemary's Baby","Låt den rätte komma in","Shaun of the Dead","Dawn of the Dead","Night of the Living Dead","King Kong","Freaks","Nosferatu","Ang-ma-reul bo-at-da","The Innocents","Bride of Frankenstein","Frankenstein","Get Out","What We Do in the Shadows","Vampire Hunter D: Bloodlust","Evil Dead II","Halloween","Repulsion","The Birds","Peeping Tom","Les yeux sans visage","Invasion of the Body Snatchers","The Invisible Man","Stree","Busanhaeng","La piel que habito","Zombieland","Saw","28 Days Later...","The Others","The Fly","Profondo rosso","Gojira","The Lighthouse","A Quiet Place","Gokseong","Tucker and Dale vs Evil","The Conjuring","Grindhouse","Interview with the Vampire: The Vampire Chronicles"],"Year":["1960","1980","1979","2018","2014","1982","1962","1955","1920","1973","1968","2008","2004","1978","1968","1933","1932","1922","2010","1961","1935","1931","2017","2014","2000","1987","1978","1965","1963","1960","1960","1956","1933","2018","2016","2011","2009","2004","2002","2001","1986","1975","1954","2019","2018","2016","2010","2013","2007","1994"],"Rating":[8.5,8.4,8.4,8.3,8.2,8.1,8.1,8.1,8.1,8,8,7.9,7.9,7.9,7.9,7.9,7.9,7.9,7.8,7.8,7.8,7.8,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.6,7.5,7.5,7.5,7.5,7.5,7.5,7.5],"rating_colour":["#DE5710","#DE5811","#DE5811","#DF5913","#DF5A14","#DF5B15","#DF5B15","#DF5B15","#DF5B15","#E05C16","#E05C16","#E05D17","#E05D17","#E05D17","#E05D17","#E05D17","#E05D17","#E05D17","#E05E18","#E05E18","#E05E18","#E05E18","#E15F19","#E15F19","#E15F19","#E15F19","#E15F19","#E15F19","#E15F19","#E15F19","#E15F19","#E15F19","#E15F19","#E1601A","#E1601A","#E1601A","#E1601A","#E1601A","#E1601A","#E1601A","#E1601A","#E1601A","#E1601A","#E2611B","#E2611B","#E2611B","#E2611B","#E2611B","#E2611B","#E2611B"]},"columns":[{"accessor":"Rank","name":"Rank","type":"numeric","headerStyle":{"background":"#f7f7f8"},"minWidth":70,"maxWidth":90,"align":"center"},{"accessor":"Poster","name":"Poster","type":"character","headerStyle":{"background":"#f7f7f8"},"cell":[{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BNTQwNDM1YzItNDAxZC00NWY2LTk0M2UtNDIwNWI5OGUyNWUxXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BZWFlYmY2MGEtZjVkYS00YzU4LTg0YjQtYzY1ZGE3NTA5NGQxXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMmQ2MmU3NzktZjAxOC00ZDZhLTk4YzEtMDMyMzcxY2IwMDAyXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BYmQxNmU4ZjgtYzE5Mi00ZDlhLTlhOTctMzJkNjk2ZGUyZGEwXkEyXkFqcGdeQXVyMzgxMDA0Nzk@._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BNDkxMzk2ODU4N15BMl5BanBnXkFtZTgwNTM4NjIzMjE@._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BNGViZWZmM2EtNGYzZi00ZDAyLTk3ODMtNzIyZTBjN2Y1NmM1XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BZmI0M2VmNTgtMWVhYS00Zjg1LTk1YTYtNmJmMjRkZmMwYTc2XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BZDVlZDdjNDktN2M4ZC00NjdkLThiMDctM2FiZWNlYjIzNDExXkEyXkFqcGdeQXVyMTA1NTM1NDI2._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BNWJiNGJiMTEtMGM3OC00ZWNlLTgwZTgtMzdhNTRiZjk5MTQ1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BYjhmMGMxZDYtMTkyNy00YWVmLTgyYmUtYTU3ZjcwNTBjN2I1XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BZmEwZGU2NzctYzlmNi00MGJkLWE3N2MtYjBlN2ZhMGJkZTZiXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BOWM4NTY2NTMtZDZlZS00NTgyLWEzZDMtODE3ZGI1MzI3ZmU5XkEyXkFqcGdeQXVyNzI1NzMxNzM@._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMTg5Mjk2NDMtZTk0Ny00YTQ0LWIzYWEtMWI5MGQ0Mjg1OTNkXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMzc1YTIyNjctYzhlNy00ZmYzLWI2ZWQtMzk4MmQwYzA0NGQ1XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMzRmN2E1ZDUtZDc2ZC00ZmI3LTkwOTctNzE2ZDIzMGJiMTYzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BZTY3YjYxZGQtMTM2YS00ZmYwLWFlM2QtOWFlMTU1NTAyZDQ2XkEyXkFqcGdeQXVyNTgyNTA4MjM@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMjMyYjgyOTQtZDVlZS00NTQ0LWJiNDItNGRlZmM3Yzc0N2Y0XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMTAxYjEyMTctZTg3Ni00MGZmLWIxMmMtOGM2NTFiY2U3MmExXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BZjRmNjc5MTYtYjc3My00ZjNiLTg4YjUtMTQ0ZTFkZmMxMDUzXkEyXkFqcGdeQXVyNDY5MTUyNjU@._V1_UY50_CR2,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BYTYxZTQwOGQtNTJjNC00ZmVhLWJjNTQtYzY0M2VjYzI5MmU1L2ltYWdlXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BOTUzMzAzMzEzNV5BMl5BanBnXkFtZTgwOTg1NTAwMjE@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMTQ0Njc1MjM0OF5BMl5BanBnXkFtZTgwNTY2NTUyMjE@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMjUxMDQwNjcyNl5BMl5BanBnXkFtZTgwNzcwMzc0MTI@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMjAwNDA5NzEwM15BMl5BanBnXkFtZTgwMTA1MDUyNDE@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BNTIyNThlMjMtMzUyMi00YmEyLTljMmYtMWRhN2Q3ZTllZjA4XkEyXkFqcGdeQXVyMzM4MjM0Nzg@._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMWY3ODZlOGMtNzJmOS00ZTNjLWI3ZWEtZTJhZTk5NDZjYWRjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BNzk1OGU2NmMtNTdhZC00NjdlLWE5YTMtZTQ0MGExZTQzOGQyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BZTU5ZThjNzAtNjc4NC00OTViLWIxYTYtODFmMTk5Y2NjZjZiL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMTAxNDA1ODc5MDleQTJeQWpwZ15BbWU4MDg2MDA4OTEx._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BZjM3ZTAzZDYtZmFjZS00YmQ1LWJlOWEtN2I4MDRmYzY5YmRlL2ltYWdlXkEyXkFqcGdeQXVyMjgyNjk3MzE@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BNzBiMWRhNzQtMjZhZS00NzFmLWE5YWMtOWY4NzIxMjYzZTEyXkEyXkFqcGdeQXVyMzg2MzE2OTE@._V1_UY50_CR2,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BYTExYjM3MDYtMzg4MC00MjU4LTljZjAtYzdlMTFmYTJmYTE4XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BYjllMmE0Y2YtYWIwZi00OWY1LWJhNWItYzM2MmNiYmFiZmRmXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMjk4NGZiMzAtODU1NS00MmQ4LWJiNmQtNWU5ZWU4Y2VmNWI0XkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMTkwOTQ4OTg0OV5BMl5BanBnXkFtZTgwMzQyOTM0OTE@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMjMwOTYyNDY4NV5BMl5BanBnXkFtZTcwNDI1ODk0Ng@@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMTU5MDg0NTQ1N15BMl5BanBnXkFtZTcwMjA4Mjg3Mg@@._V1_UY50_CR1,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMzQ2ZTBhNmEtZDBmYi00ODU0LTgzZmQtNmMxM2M4NzM1ZjE4XkEyXkFqcGdeQXVyNjE5MjUyOTM@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BYTFkM2ViMmQtZmI5NS00MjQ2LWEyN2EtMTI1ZmNlZDU3MTZjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMTAxMDE4Mzc3ODNeQTJeQWpwZ15BbWU4MDY2Mjg4MDcx._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BODcxMGMwOGEtMDUxMi00MzE5LTg4YTYtYjk1YjA4MzQxNTNlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BYTQyMmUwMjgtOTU0Yy00YTJiLWFlZjMtOWM5NGQ0OWY5YThjXkEyXkFqcGdeQXVyNjQ2MjQ5NzM@._V1_UY50_CR1,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMjAzNTk3MTc2OF5BMl5BanBnXkFtZTgwNzI5MzU5MTE@._V1_UY50_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BZmE0MGJhNmYtOWNjYi00Njc5LWE2YjEtMWMxZTVmODUwMmMxXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMjI0MDMzNTQ0M15BMl5BanBnXkFtZTgwMTM5NzM3NDM@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BODkwMTgxNjA2NF5BMl5BanBnXkFtZTgwMDc0OTcwOTE@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BODQ5NDQ0MjkwMF5BMl5BanBnXkFtZTcwNDg1OTU4NQ@@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMTM3NjA1NDMyMV5BMl5BanBnXkFtZTcwMDQzNDMzOQ@@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BMjA0MzExNzc3MV5BMl5BanBnXkFtZTcwODAxMzM0MQ@@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]},{"name":"div","attribs":{},"children":[{"name":"img","attribs":{"src":"https://m.media-amazon.com/images/M/MV5BYThmYjJhMGItNjlmOC00ZDRiLWEzNjUtZjU4MjA3MzY0MzFmXkEyXkFqcGdeQXVyNTI4MjkwNjA@._V1_UX34_CR0,0,34,50_AL_.jpg"},"children":[]}]}],"maxWidth":70},{"accessor":"Movie","name":"Movie","type":"character","headerStyle":{"background":"#f7f7f8"},"maxWidth":300},{"accessor":"Year","name":"Year","type":"character","headerStyle":{"background":"#f7f7f8"},"minWidth":70,"maxWidth":90,"align":"center"},{"accessor":"Rating","name":"Rating","type":"numeric","headerStyle":{"background":"#f7f7f8"},"defaultSortDesc":true,"cell":"function(cellInfo) {\n      const sliceColor = cellInfo.row['rating_colour']\n      const sliceLength = 2 * Math.PI * 24\n      const sliceOffset = sliceLength * (1 - cellInfo.value / 10)\n      const donutChart = (\n        '<svg width=60 height=60 style=\"transform: rotate(-90deg)\">' +\n          '<circle cx=30 cy=30 r=24 fill=none stroke-width=4 stroke=rgba(0,0,0,0.1)><\/circle>' +\n          '<circle cx=30 cy=30 r=24 fill=none stroke-width=4 stroke=' + sliceColor +\n          ' stroke-dasharray=' + sliceLength + ' stroke-dashoffset=' + sliceOffset + '><\/circle>' +\n        '<\/svg>'\n      )\n      const label = '<div style=\"position: absolute; top: 50%; left: 50%; ' +\n        'transform: translate(-50%, -50%)\">' + cellInfo.value + '<\/div>'\n      return '<div style=\"display: inline-flex; position: relative\">' + donutChart + label + '<\/div>'\n    }","html":true,"width":140,"align":"center"},{"accessor":"rating_colour","name":"rating_colour","type":"character","headerStyle":{"background":"#f7f7f8"},"show":false}],"searchable":true,"defaultSorted":[{"id":"Rank","desc":false}],"defaultPageSize":10,"paginationType":"numbers","showPageInfo":true,"minRows":1,"highlight":true,"width":"690px","theme":{"cellStyle":{"display":"flex","flexDirection":"column","justifyContent":"center"}},"dataKey":"7a021d2ed0cb0ec6d6320cfcf4485b8b","key":"7a021d2ed0cb0ec6d6320cfcf4485b8b"},"children":[]},"class":"reactR_markup"},"evals":["tag.attribs.columns.4.cell"],"jsHooks":[]}</script>
</div>
