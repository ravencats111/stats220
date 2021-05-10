## ---- read-html
library(rvest)
course <- "https://stats220.earo.me"
stats220 <- read_html(course)
stats220

## ---- html-el
navbar <- stats220 %>% 
  html_element(".navbar-right")
navbar

## ---- html-nm
navbar %>% 
  html_name()

## ---- html-child
navbar %>% 
  html_children()

## ---- html-child-nm
navbar %>% 
  html_children() %>%
  html_name()

## ---- html-text
navbar %>% 
  html_children() %>%
  html_text2()

## ---- html-attr
navbar %>% 
  html_elements("a") %>% 
  html_attr("href")

## ---- html-url
navbar %>% 
  html_elements("a") %>% 
  html_attr("href") %>% 
  url_absolute(course)

## ---- html-el-i
navbar %>% 
  html_elements("i")

## ---- html-info
stats220_info <- read_html(
  "https://stats220.earo.me/pages/info/")

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
  html_attr("href")
stats220_urls

## ---- pdf-links
library(stringr) # manipulate strings in week 10
(pdf_urls <- stats220_urls[str_detect(stats220_urls, "pdf")])

## ---- pdf-links-dl
pdf_files <- str_remove(pdf_urls, "/")
purrr::walk2( # below for week 11
  url_absolute(pdf_urls, course), pdf_files,
  ~ download.file(url = .x, destfile = .y))

## ---- root-endpoint
library(httr)
endpoint <- "https://api.github.com"
GET(endpoint)

## ---- endpoint
path <- "/repos/STATS-UOA/stats220"
resp <- GET(modify_url(endpoint, 
  path = path))
resp

## ---- http-type
http_type(resp)

## ---- content
content(resp)

## ---- status
status_code(resp)

## ---- status-lst1
http_status(200) # OK
http_status(201) # Created
http_status(204) # NO CONTENT

## ---- status-lst2
http_status(400) # BAD REQUEST
http_status(403) # Forbidden
http_status(404) # NOT FOUND

## ---- bus-stop
endpoint <- "https://services2.arcgis.com"
path <- "/JkPEgZJGxhSjYOo0/arcgis/rest/services/BusService/FeatureServer/0/"
query <- "query?where=1%3D1&outFields=*&outSR=4326&f=geojson"
bus_url <- parse_url(paste0(endpoint, path, query))
resp <- GET(bus_url)
cnt <- geojson::as.geojson(content(resp))
cnt

## ---- bus-stop-plot
library(tidyverse)
library(sf)
bus_sf <- geojsonsf::geojson_sf(cnt)
ggplot() +
  geom_sf(data = bus_sf, pch = 1, 
    colour = "#3182bd")
