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

## ---- arithmetic
akl_lon_region <- akl_lon + c(-1, 1)
akl_lat_region <- akl_lat + c(-.5, .5)

akl_lon_region
akl_lat_region

## ---- mass-storage
library(sf)
akl_bus <- st_read("data/BusService/BusService.shp")

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
x <- c(akl_lon_region, akl_lat_region)
x

## ---- positive-indices
x[c(1, 3)]

## ---- negative-indices
x[-c(3, 1)]

## ---- logical-indices
x[c(TRUE, FALSE, TRUE, FALSE)]
x[lgl_vec] # recycling
x[x > 0]

## ---- special-subsetting
x[0]
x[]

## ---- function-mean
mean(x = x)

## ---- function-args-pos
mean(x, 0.1, TRUE)

## ---- function-args-names
mean(x, na.rm = TRUE, trim = 0.1)

## ---- cummean
# install.packages("dplyr")
library(dplyr)
cummean(x)
first(x)
last(x)

## ---- custom-mean
# function_name <- function(arguments) {
#   function_body
# }

my_mean <- function(x, na.rm = FALSE) {
  summation <- sum(x, na.rm = na.rm)
  summation / length(x)
}

my_mean(x)
