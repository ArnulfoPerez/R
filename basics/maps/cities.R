

library(tidyverse)
library(maps)
library(leaflet)

world.cities %>% leaflet() %>% addTiles() %>% addMarkers()
