#homework review----
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

#weight between 30 and 60
surveys %>%
  filter(weight > 30 & weight <60) %>%
  head(n=6)

#making new tibble showing max weight for each species + sex combo
biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarize(max_weight = max(weight))
#or mutate, but mutate creates a tibble with same number of rows while summarize
#shrinks the rows down which makes for a neater data frame
biggest_critters

#to look at the max weights in descending order
biggest_critters %>% 
  arrange(-max_weight) %>% 
  head()
#or arrange(desc(max_weight)), desc = descending

#to look at where the NAs are accumulated
surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally() %>% 
  arrange(-n)