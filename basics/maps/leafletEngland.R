library(tidyverse)
library(leaflet)
library(geojsonio)
library(sp)

# set the URL from where the file can be collected
geojson_url <- "https://opendata.arcgis.com/datasets/ae90afc385c04d869bc8cf8890bd1bcd_4.geojson"

# set the file path where we'll download to
file_path <- "data/regions.geojson"

# download from the URL to the filepath specified
download.file(geojson_url, file_path)

lads <- geojsonio::geojson_read(
  x = file_path,  # the same file_path as above
  what = "sp"  # returns the read with spatial class
)

dplyr::glimpse(lads)

lads_eng <- subset(
  x = lads,  # our data
  subset = grepl(  # subset the data where the following pattern is matched
    x = lads@data$lad17cd,  # in this variable in this slot of this SPDF
    pattern = "^E"  # subset anything starting with 'E'
  )
)

length(lads_eng@data$lad17cd)  # check that the number of LADs is reduced