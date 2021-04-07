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
