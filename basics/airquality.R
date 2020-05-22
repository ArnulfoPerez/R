library(tidyverse)

df <- read.csv("C:\\Users\\arnul\\OneDrive\\data\\covid\\waqi-covid19-airqualitydata-2020.csv",skip = 4) %>%
#  type.convert() %>%
  mutate(Date = as.Date(Date)) %>%
  mutate_if(is.character, as.factor) %>%
  as_tibble()

df

str(df)
str(df$Specie)
head(df$City)

plot(median ~Specie,data = df)
