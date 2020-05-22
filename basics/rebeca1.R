library(tidyverse)

# to download the data directly:
gapminder_orig <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv")
# define a copy of the original dataset that we will clean and play with 
gapminder <- gapminder_orig

gapminder %>%
  filter(continent == "Americas", year == "2007") %>%
  select(country, lifeExp)

# take the gapminder dataset
gapminder %>%
  # and filter to the rows whose continent is Americas and year is 2007
  filter(continent == "Americas", year == 2007) %>%
  # show the country and lifeExp values for these rows
  select(country, lifeExp)