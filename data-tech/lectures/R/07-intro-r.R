## ---- cowsay
library(cowsay)
say("Kia Ora!")

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
library(leaflet)
leaflet(data = st_transform(akl_bus, crs = 4326)) %>% 
  addTiles() %>% 
  addPolylines(
    weight = 2,
    popup = ~ paste("Routenumber:", ROUTENUMBE)
  )

## ---- vectors
lgl_vec <- c(TRUE, FALSE)
int_vec <- c(174L, -36L)
dbl_vec <- c(174.76, -36.85)
chr_vec <- c("long", "lat")

## ---- subsetting
(x <- c(akl_lon_region, akl_lat_region))

## ---- positive-indices
x[c(1, 3)]

## ---- negative-indices
x[-c(3, 1)]

## ---- logical-indices
x[c(TRUE, FALSE, TRUE, FALSE)]
x[c(TRUE, FALSE)] # recycling
x[x > 0]

## ---- special-subsetting
x[]
x[1:4]
x[0]

## ---- function-args-pos
mean(x, 0.1, TRUE)

## ---- function-args-names
mean(x, na.rm = TRUE, trim = 0.1)
