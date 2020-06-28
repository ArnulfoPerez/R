l# load the relevant tidymodels libraries
library(tidymodels)
library(tidyverse)
library(workflows)
library(tune)

# load the Pima Indians dataset from the mlbench dataset
library(mlbench)
data(PimaIndiansDiabetes)
# rename dataset to have shorter name because lazy
diabetes_orig <- PimaIndiansDiabetes
head(diabetes_orig)
ggplot(diabetes_orig) + geom_histogram(aes(x = triceps))

diabetes_clean <- diabetes_orig %>%
  mutate_at(vars(triceps, glucose, pressure, insulin, mass), 
            function(.var) { 
              if_else(condition = (.var == 0), # if true (i.e. the entry is 0)
                      true = as.numeric(NA),  # replace the value with NA
                      false = .var # otherwise leave it as it is
              )
            })

set.seed(234589)
# split the data into trainng (75%) and testing (25%)
diabetes_split <- initial_split(diabetes_clean, 
                                prop = 3/4)
diabetes_split

# extract training and testing sets
diabetes_train <- training(diabetes_split)
diabetes_test <- testing(diabetes_split)

# create CV object from training data
diabetes_cv <- vfold_cv(diabetes_train)

# define the recipe
diabetes_recipe <- 
  # which consists of the formula (outcome ~ predictors)
  recipe(diabetes ~ pregnant + glucose + pressure + triceps + 
           insulin + mass + pedigree + age, 
         data = diabetes_clean) %>%
  # and some pre-processing steps
  step_normalize(all_numeric()) %>%
  step_knnimpute(all_predictors())

diabetes_recipe
