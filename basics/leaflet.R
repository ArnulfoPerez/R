library(tidyverse)
library(leaflet)
library(stringr)
library(sf)
library(here)
library(widgetframe)

options(digits = 3)
set.seed(1234)
theme_set(theme_minimal())

crimes <- here("data", "Crimes_-_2017.csv") %>%
  read_csv()
glimpse(crimes)

m <- leaflet() %>%
  addTiles() %>%
  addMarkers(lng = -87.597241, lat = 41.789829,
             popup = "Saieh Hall of Economics")
m %>%
  frameWidget()

library(dplyr)
library(leaflet)
my_lmap <- leaflet() %>% addTiles()  %>%
  addMarkers(lat=31.245105, lng=121.506377, popup = "The Oriental pearl tower")
print(my_lmap)

Orientalpearl_tower <- c("<a href= 'http://www.orientalpearltower.com/#/' >Orientalpearl_tower </a>")

library(jsonlite)
library(dplyr)
jsonData <- fromJSON("http://bit.ly/covid19tokyo")
tokyo <- jsonData %>% as.data.frame()
tokyo_df <- tokyo$features.properties  # extract only necessary data set
colnames(tokyo_df)[1:6]<- c("city_code","city","date","comulative_cases","lng","lag") # change colname to english
tokyo_df_latest <- tokyo_df[tokyo_df$date == max(tokyo_df$date),]  # subset only latest data
#
# COVID19 - the geographic plot of latest number of comulative confirmed cases in Tokyo.

tokyo_map <- leaflet(tokyo_df_latest) %>% addTiles() %>% 
  addProviderTiles("CartoDB.Positron") %>%
  setView(lat=35.6, lng=139.6, zoom=10) %>% 
  addCircles(weight = 1, radius =~comulative_cases*20, 
             popup = paste(tokyo_df_latest$city,as.character(tokyo_df_latest$comulative_cases)),
             lng=~lng,lat=~lag)
tokyo_map

library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map

# add some circles to a map
df = data.frame(Lat = 1:10, Long = rnorm(10))
leaflet(df) %>% addCircles()

leaflet(df) %>% addCircles(lng = ~Long, lat = ~Lat)

library(sp)
Sr1 = Polygon(cbind(c(2, 4, 4, 1, 2), c(2, 3, 5, 4, 2)))
Sr2 = Polygon(cbind(c(5, 4, 2, 5), c(2, 3, 2, 2)))
Sr3 = Polygon(cbind(c(4, 4, 5, 10, 4), c(5, 3, 2, 5, 5)))
Sr4 = Polygon(cbind(c(5, 6, 6, 5, 5), c(4, 4, 3, 3, 4)), hole = TRUE)
Srs1 = Polygons(list(Sr1), "s1")
Srs2 = Polygons(list(Sr2), "s2")
Srs3 = Polygons(list(Sr4, Sr3), "s3/4")
SpP = SpatialPolygons(list(Srs1, Srs2, Srs3), 1:3)
leaflet(height = "300px") %>% addPolygons(data = SpP)

library(maps)
mapStates = map("state", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)

library(tidyverse)
library(maps)
library(leaflet)

world.cities %>% leaflet() %>% addTiles() %>% addMarkers()
