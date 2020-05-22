library(tidyverse)
library(ggmap)
library(RColorBrewer)
library(here)

options(digits = 3)
set.seed(1234)
theme_set(theme_minimal())

chi_311 <- read_csv("https://cfss.uchicago.edu/data/chi-311.csv")

glimpse(chi_311)
# store bounding box coordinates
chi_bb <- c(left = -87.936287,
            bottom = 41.679835,
            right = -87.447052,
            top = 42.000835)

# retrieve bounding box
chicago <- get_stamenmap(bbox = chi_bb,
                         zoom = 11)

# plot the raster map
ggmap(chicago)

# initialize map
ggmap(chicago) +
  # add layer with scatterplot
  # use alpha to show density of points
  geom_point(data = filter(chi_311, sr_type == "Pothole in Street Complaint"),
             mapping = aes(x = longitude,
                           y = latitude),
             size = .25,
             alpha = .05)

ggmap(chicago) +
  # add the heatmap
  stat_density_2d(data = filter(chi_311, sr_type == "Pothole in Street Complaint"),
                  mapping = aes(x = longitude,
                                y = latitude,
                                fill = stat(level)),
                  alpha = .1,
                  bins = 50,
                  geom = "polygon") +
  # customize the color gradient
  scale_fill_gradientn(colors = brewer.pal(9, "YlOrRd"))

# store bounding box coordinates
hp_bb <- c(left = -87.608221,
           bottom = 41.783249,
           right = -87.577643,
           top = 41.803038)

# retrieve bounding box
hyde_park <- get_stamenmap(bbox = hp_bb,
                           zoom = 15)

# plot the raster map
ggmap(hyde_park)

# initialize the map
ggmap(hyde_park) +
  # add a scatterplot layer
  geom_point(data = filter(chi_311, sr_type == "Dead Animal Pick-Up Request"),
             mapping = aes(x = longitude,
                           y = latitude))

devtools::session_info()
