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
COVID19 - the geographic plot of latest number of comulative confirmed cases in Tokyo.

tokyo_map <- leaflet(tokyo_df_latest) %>% addTiles() %>% 
  addProviderTiles("CartoDB.Positron") %>%
  setView(lat=35.6, lng=139.6, zoom=10) %>% 
  addCircles(weight = 1, radius =~comulative_cases*20, 
             popup = paste(tokyo_df_latest$city,as.character(tokyo_df_latest$comulative_cases)),
             lng=~lng,lat=~lag)
tokyo_map
