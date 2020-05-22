library(leaflet)
library(widgetframe)
l <- leaflet() %>% addTiles() %>% setView(0,0,1)
frameWidget(l, width='90%')

library(dygraphs)
ts <- dygraph(nhtemp, main = "New Haven Temperatures")
frameWidget(ts, height = 350, width = '95%')