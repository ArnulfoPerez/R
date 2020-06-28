library(tidyverse)
library(leaflet)

m <- leaflet(options = leafletOptions(minZoom = 0, maxZoom = 13)) %>%
  addTiles() %>%  # add default OpenStreetMap map tiles
  addMarkers(lng=-73.546428, lat=45.522660, 
             popup="Montréal, Jacques-Cartier",
             label = "lng=-73.546428, lat=45.522660")

m  # print the map
