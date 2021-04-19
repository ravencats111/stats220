# CSS selectors: https://selectorgadget.com/

## ---- read-html
library(rvest)
home <- "https://stats220.earo.me"
stats220 <- read_html(home)
stats220

## ---- html-el
stats220 %>% 
  html_element(".navbar-right")

## ---- html-nm
stats220 %>% 
  html_element(".navbar-right") %>% 
  html_name()

## ---- html-child
stats220 %>% 
  html_element(".navbar-right") %>% 
  html_children()

## ---- html-child-nm
stats220 %>% 
  html_element(".navbar-right") %>% 
  html_children() %>%
  html_name()

## ---- html-attr
stats220 %>% 
  html_element(".navbar-right") %>% 
  html_elements("a") %>% 
  html_attr("href")

## ---- html-url
stats220 %>% 
  html_element(".navbar-right") %>% 
  html_elements("a") %>% 
  html_attr("href") %>% 
  url_absolute(home)

## ---- html-el-i
stats220 %>% 
  html_element(".navbar-right") %>% 
  html_elements("i")

## ---- html-text
stats220 %>% 
  html_element(".navbar-right") %>% 
  html_children() %>%
  html_text2()

## ---- dl
stats220 %>% 
  html_elements(".panel-body .btn") %>% 
  html_attr("href") %>% 
  url_absolute(home)

stats220_urls <- stats220 %>% 
  html_elements(".panel-body .btn") %>% 
  html_attr("href") %>% 
  url_absolute(home)

pdf_urls <- stats220_urls[stringr::str_detect(stats220_urls, "pdf")]
pdf_ursl %>% 
  map(download.file)

stats220_info <- read_html("https://stats220.earo.me/pages/info/")

stats220_info %>% 
  html_elements("h3") %>% 
  html_text()

stats220_info %>% 
  html_elements("#timetable") %>% 
  html_text()

stats220_info %>% 
  html_element("table") %>% 
  html_table()

# https://docs.github.com/en/rest
library(httr)
library(lubridate)
library(tidyverse)
stats220_gh <- "https://api.github.com/repos/STATS-UOA/stats220/commits"
resp <- GET(stats220_gh)
status_code(resp)

lst <- content(resp)
dttm_chr <- map_chr(lst, ~ .$commit$committer$date)
as_datetime(dttm_chr)
as_datetime(dttm_chr, tz = "Pacific/Auckland")
