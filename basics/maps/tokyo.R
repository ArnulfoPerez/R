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