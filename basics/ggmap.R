#==============
# LOAD PACKAGES
#==============

library(tidyverse)
library(ggmap)
library(forcats)


#===================
# INPUT ALPHA CITIES
#===================

df_alpha_plus_plus <- tibble(city = c('London','New York'))
df_alpha_plus <- tibble(city = c('Singapore', 'Hong Kong', 'Paris', 'Beijing'
                                 ,'Tokyo', 'Dubai', 'Shanghai'))
df_alpha <- tibble(city = c('Sydney', 'São Paulo', 'Milan', 'Chicago'
                            ,'Mexico City', 'Mumbai', 'Moscow', 'Frankfurt'
                            ,'Madrid', 'Warsaw', 'Johannesburg', 'Toronto'
                            ,'Seoul', 'Istanbul', 'Kuala Lumpur', 'Jakarta'
                            ,'Amsterdam', 'Brussels', 'Los Angeles'))
df_alpha_minus <- tibble(city = c('Dublin', 'Melbourne', 'Washington', 'New Delhi'
                                  ,'Bangkok', 'Zurich', 'Vienna', 'Taipei'
                                  ,'Buenos Aires', 'Stockholm', 'San Francisco'
                                  ,'Guangzhou', 'Manila', 'Bogotá', 'Miami', 'Luxembourg'
                                  ,'Riyadh', 'Santiago', 'Barcelona', 'Tel Aviv', 'Lisbon'))

#=======================
# ADD GLOBAL CITY RATING
#=======================

df_alpha_plus_plus <- df_alpha_plus_plus %>% mutate(rating = 'alpha++')
df_alpha_plus <- df_alpha_plus %>% mutate(rating = 'alpha+')
df_alpha <- df_alpha %>% mutate(rating = 'alpha')
df_alpha_minus <- df_alpha_minus %>% mutate(rating = 'alpha-')

Next, we’ll combine the different data frames into one using rbind().

#======================================
# COMBINE DATAFRAMES INTO ONE DATAFRAME
#======================================

alpha_cities <- rbind(df_alpha_plus_plus
                      ,df_alpha_plus
                      ,df_alpha
                      ,df_alpha_minus
)


#========
# GEOCODE
#========

latlong <- geocode(alpha_cities$city)



#========
# INSPECT
#========

alpha_cities
latlong


#============================
# BIND LAT/LONG TO CITY NAMES
#============================

alpha_cities <- cbind(alpha_cities, latlong) %>% rename(long = lon)

alpha_cities

#names(alpha_cities)


#================================================
# REORDER LEVELS OF GLOBAL CITY RATING 
# - the global city ratings should be ordered
#   i.e., alpha++, then alpha+ ....
# - to do this, we'll use forecats::fct_relevel()
#================================================

alpha_cities <- mutate(alpha_cities, rating = fct_relevel(rating, 'alpha++','alpha+','alpha','alpha-'))

levels(alpha_cities$rating)


#==============
# GET WORLD MAP
#==============

map_world <- map_data("world")

Ok. We basically have everything we need. Now we will make a simple first draft.

#================
# FIRST DRAFT MAP
#================

ggplot() +
  geom_polygon(data = map_world, aes(x = long, y = lat, group = group)) +
  geom_point(data = alpha_cities, aes(x = long, y = lat), color = 'red')





#==========================
# CREATE SMALL MULTIPLE MAP
#==========================

ggplot() +
  geom_polygon(data = map_world, aes(x = long, y = lat, group = group)) +
  geom_point(data = alpha_cities, aes(x = long, y = lat), color = 'red') +
  #facet_grid(. ~ rating)
  #facet_grid(rating ~ .)
  facet_wrap(~ rating)