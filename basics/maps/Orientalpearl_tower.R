

library(dplyr)
library(leaflet)
my_lmap <- leaflet() %>% addTiles()  %>%
  addMarkers(lat=31.245105, lng=121.506377, popup = "The Oriental pearl tower")
print(my_lmap)

Orientalpearl_tower <- c("<a href= 'http://www.orientalpearltower.com/#/' >Orientalpearl_tower </a>")