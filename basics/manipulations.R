library(dplyr)
iris_char <- iris %>%
  mutate(Species=as.character(Species),
         char_column=sample(letters[1:5], nrow(iris), replace=TRUE))
sum(sapply(iris_char, is.character)) # 2

iris_factor <- iris_char %>%
  mutate_if(sapply(iris_char, is.character), as.factor)


sapply(iris_factor, class)

iris_factor <- iris_char %>% type.convert()
sapply(iris_factor, class)

my_data <- as_tibble(iris)
my_data

my_data %>% pull(Species)

my_data %>% select(1:3)

my_data %>% select(1, 3)

my_data %>% select(Sepal.Length, Petal.Length)
my_data %>% select(Sepal.Length:Petal.Length)

# Select column whose name starts with "Petal"
my_data %>% select(starts_with("Petal"))

# Select column whose name ends with "Width"
my_data %>% select(ends_with("Width"))

# Select columns whose names contains "etal"
my_data %>% select(contains("etal"))

# Select columns whose name maches a regular expression
my_data %>% select(matches(".t."))

# selects variables provided in a character vector.
my_data %>% select(one_of(c("Sepal.Length", "Petal.Length")))

my_data %>% select_if(is.numeric)


my_data %>% select(-Sepal.Length, -Petal.Length)

# Drop column 1
my_data %>% select(-1)

# Drop columns 1 to 3
my_data %>% select(-(1:3))

# Drop columns 1 and 3 but not 2
my_data %>% select(-1, -3)