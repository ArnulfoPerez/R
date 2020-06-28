library(leaflet)
library(magrittr)

SFmap <- leaflet() %>% 
  addTiles() %>% 
  setView(-122.42, 37.78, zoom = 13) %>% 
  addMarkers(-122.42, 37.78, popup = 'Bay Area')
SFmap