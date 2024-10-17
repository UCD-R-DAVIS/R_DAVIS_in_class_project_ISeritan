# Homework 3 Review -----
#Load your survey data frame with the read.csv() function.
surveys <- read.csv("data/portal_data_joined.csv")

#Create a new data frame called surveys_base with only the species_id,
#the weight, and the plot_type columns. Have this data frame only be the first
#5,000 rows. 
surveys_base <- surveys[, c(6,9,13)]
#other option: surveys_base <- surveys[, c("species_id", "weight", "plot_type")]
#other option: surveys_base <- select(surveys, species_id, weight, plot_type)

#can also combine into one request with both the column ask and the row ask
surveys_base <- surveys[1:5000, c("species_id", "weight", "plot_type")]

#Convert both species_id and plot_type to factors. Remove all rows where there
#is an NA in the weight column. 
surveys_base$species_id <- factor(surveys_base$species_id)



#see week4_lecture2 for the 2nd part of the lecture
#now back to here for 3rd part of lecture


# Data Manipulation Part 1b ----
# Goals: learn about mutate, group_by, and summarize
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)


# Adding a new column
# mutate: adds a new column
surveys <- surveys %>%
  mutate(weight_kg = weight/1000)
head(surveys)
str(surveys) #data frame now has a new column called weight_kg

# Add other columns
surveys <- surveys %>%
  mutate(., 
         weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
str(surveys)
#you can nest the mutations and add multiple columns at once

# Filter out the NA's
ave_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(mean_weight = mean(weight))

str(ave_weight) #we now have filtered out all NAs and have a new mean_weight col

#be aware that complete.cases is different - it would kick out every row that had
#any NA anywhere

# Group_by and summarize ----
# A lot of data manipulation requires us to split the data into groups, apply
#some analysis to each group, and then combine the results
# group_by and summarize functions are often used together to do this
# group_by works for columns with categorical variables 
# we can calculate mean by certain groups
surveys %>%
  group_by(sex) %>%
  mutate(mean_weight = mean(weight, na.rm = TRUE)) 
#this has given us a tibble with all the same data as before but grouped by sex
#but is very messy

surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
#now we can look at the same tibble but with the sexes and the mean_weights
#and nothing else

# multiple groups
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
#compare two groups at once - in this case sex, species, and their mean wt

# remove na's


# sort/arrange order a certain way
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(-mean_weight) #arranges by descending mean_weights


# Challenge
#What was the weight of the heaviest animal measured in each year? Return a
#table with three columns: year, weight of the heaviest animal in grams, and
#weight in kilograms, arranged (arrange()) in descending order, from heaviest to
#lightest. (This table should have 26 rows, one for each year)

surveys %>% group_by(year) %>% max(weight)
str(surveys)
surveys %>% group_by(surveys$year) %>% max(surveys$weight)
surveys %>% group_by(year) %>% max(weight)
surveys %>%
  group_by(year) %>%
  filter(!is.na(weight)) %>%
  summarize(max_weight = max(weight)) %>% 
  mutate(max_weight_kg = max_weight/1000) %>% 
  arrange(-max_weight) #YESSSSSS!!!!!!!!!!!!!!!

#Try out a new function, count(). Group the data by sex and pipe the grouped data
#into the count() function. How could you get the same result using group_by()
#and summarize()? Hint: see ?n.