# CSS selectors: https://selectorgadget.com/
library(rvest)

stats220 <- read_html("https://stats220.earo.me")
stats220

stats220 %>% 
  html_element(".navbar-right")

stats220 %>% 
  html_element(".navbar-right") %>% 
  html_name()

stats220 %>% 
  html_element(".navbar-right") %>% 
  html_children()

stats220 %>% 
  html_element(".navbar-right") %>% 
  html_children() %>%
  html_name()

stats220 %>% 
  html_element(".navbar-right") %>% 
  html_elements("a") %>% 
  html_attr("href") # relative path

stats220 %>% 
  html_element(".navbar-right") %>% 
  html_elements("a") %>% 
  html_attr("href") %>% 
  url_absolute("https://stats220.earo.me") # absolute path

stats220 %>% 
  html_element(".navbar-right") %>% 
  html_elements("i")

stats220 %>% 
  html_element(".navbar-right") %>% 
  html_children() %>%
  html_text2()

stats220 %>% 
  html_elements(".panel-body .btn") %>% 
  html_attr("href") %>% 
  url_absolute("https://stats220.earo.me")

stats220_urls <- stats220 %>% 
  html_elements(".panel-body .btn") %>% 
  html_attr("href") %>% 
  url_absolute("https://stats220.earo.me")

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
