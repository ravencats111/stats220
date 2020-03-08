## ---- memer
# remotes::install_github("sctyner/memer")
library(memer)
meme_get("DistractedBf") %>% 
  meme_text_distbf("tidyverse", "new R users",
    "base R")

## ---- varible
akl_lon <- 174.76
akl_lat <- -36.85

akl_lon
akl_lat

akl_lon_region <- akl_lon + c(-1, 1)
akl_lat_region <- akl_lat + c(-.5, .5)

library(sf)
library(ggplot2)

akl_bus <- st_read("data/Bus_Route/Bus_Route.shp")

ggplot() +
  geom_sf(data = akl_bus, aes(colour = AGENCYNAME))

# https://data-atgis.opendata.arcgis.com/datasets/bus-route/data?geometry=169.841%2C-37.610%2C179.685%2C-36.072
library(leaflet)
leaflet() %>% 
  addProviderTiles("Stamen.Toner") %>% 
  addPolylines(data = st_transform(akl_bus, crs = 4326),
    popup = ~ paste("Routenumber:", ROUTENUMBE))
