library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-73.546428, lat=45.522660,
             popup="Montréal, Jacques-Cartier",
             label = "lng=-73.546428, lat=45.522660") %>% 
  fitBounds(-73, 45, -74, 46)

m

library(htmlwidgets)

saveWidget(m, file="m.html")
