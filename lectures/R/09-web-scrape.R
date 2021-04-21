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

## ---- html-info
stats220_info <- read_html("https://stats220.earo.me/pages/info/")

## ---- html-h3
stats220_info %>% 
  html_elements("h3") %>% 
  html_text()

## ---- html-id
stats220_info %>% 
  html_elements("#timetable") %>% 
  html_text()

## ---- html-table
stats220_info %>% 
  html_element("table") %>% 
  html_table()

## ---- links
stats220_urls <- stats220 %>% 
  html_elements(".panel-body .btn") %>% 
  html_attr("href") %>% 
  url_absolute(home)
stats220_urls

## ---- pdf-links
(pdf_urls <- stats220_urls[stringr::str_detect(stats220_urls, "pdf")])

## ---- pdf-links-dl
pdf_ursl %>% 
  map(download.file)

## ---- root-endpoint
library(httr)
endpoint <- "https://api.github.com"
GET(endpoint)

## ---- endpoint
path <- "/repos/STATS-UOA/stats220"
resp <- GET(modify_url(endpoint, path = path))
resp

## ---- content-type
http_type(resp)
content(resp)

## ---- status
status_code(resp)
http_status(200)
http_status(404)

## ---- commits
path_commits <- "/repos/STATS-UOA/stats220/commits"
resp_commits <- GET(modify_url(endpoint, path = path_commits))
dat <- content(resp_commits)
dat

## ---- commits-dttm
library(lubridate)
library(tidyverse)
dttm_chr <- map_chr(dat, ~ .$commit$committer$date)
as_datetime(dttm_chr, tz = "Pacific/Auckland")
