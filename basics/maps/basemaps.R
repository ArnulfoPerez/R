library(leaflet)

m <- leaflet() %>%
  setView(lng=-73.546428, lat=45.522660, zoom = 12)

m %>% 
  addTiles() # with no arguments; by default, OpenStreetMap 

library(leaflet)
m %>% 
  addProviderTiles(providers$Stamen.Toner)