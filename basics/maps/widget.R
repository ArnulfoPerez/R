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