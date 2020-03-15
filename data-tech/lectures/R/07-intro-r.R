## ---- memer
# remotes::install_github("sctyner/memer")
library(memer)
meme_get("DistractedBf") %>% 
  meme_text_distbf("data science", "new\nstudents",
    "statistics")

## ---- store-values
akl_lon <- 174.76
akl_lat <- -36.85

## ---- retrieve-values
akl_lon
akl_lat

## ---- retrieve-error
akl_Lon
akl.lat

## ---- arithmetic
akl_lon_region <- akl_lon + c(-1, 1)
akl_lat_region <- akl_lat + c(-.5, .5)

akl_lon_region
akl_lat_region

## ---- mass-storage
library(sf)
akl_bus <- st_read("data/Bus_Route/Bus_Route.shp")

## ---- mass-storage-print
akl_bus[1:4, ]

## ---- screen
library(ggplot2)
ggplot() +
  geom_sf(data = akl_bus, aes(colour = AGENCYNAME))

## ---- network
# https://data-atgis.opendata.arcgis.com/datasets/bus-route/data?geometry=169.841%2C-37.610%2C179.685%2C-36.072
library(leaflet)
leaflet(data = st_transform(akl_bus, crs = 4326)) %>% 
  addTiles() %>% 
  addPolylines(
    weight = 2,
    popup = ~ paste("Routenumber:", ROUTENUMBE)
  )
