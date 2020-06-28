
library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-73.546428, lat=45.522660,
             popup="Montréal, Jacques-Cartier",
             label = "lng=-73.546428, lat=45.522660") %>% 
  setView(lng=-73.54, lat=45.52,
          zoom = 15)

m