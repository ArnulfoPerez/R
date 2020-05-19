install.packages("dplyr")
install.packages("ggplot2")
install.packages("purrr")
install.packages("tidyr")
install.packages("readr")
install.packages("tibble")
install.packages("tidyverse")

library(tidyverse)

# to download the data directly:
gapminder_orig <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv")
# define a copy of the original dataset that we will clean and play with 
gapminder <- gapminder_orig

dim(gapminder)

head(gapminder)

gapminder %>%
  filter(continent == "Americas", year == "2007") %>%
  select(country, lifeExp)