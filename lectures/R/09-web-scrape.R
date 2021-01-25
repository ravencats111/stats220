library(rvest)

stats220 <- read_html("https://stats220.earo.me")

stats220 %>% 
  html_nodes(".panel-body .btn") %>% 
  html_attr("href")
