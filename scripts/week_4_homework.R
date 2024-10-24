#number 1----
library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")


#number 2----
str(surveys)
surveys %>%
  surveys[1:6, filter(weight >= 30 & weight <= 60)]
#hm. getting an error that object 'weight' cannot be found. need to try something new
surveys %>% 
  surveys[1:6, filter(surveys, weight >= 30 & weight <= 60)]
#still getting an error but I did at least define the surveys. how about...
surveys %>% 
  surveys[1:6, filter(surveys, surveys$weight>= 30 & surveys$weight<= 60)]
#it's telling me i have an invalid 'x' type
surveys %>% 
  filter(!is.na(weight)) %>% 
  surveys[1:6, filter(surveys, weight>= 30 & weight<= 60)]
#dang. that didn't fix it
surveys %>% 
  filter(!is.na(weight)) %>% 
  surveys[1:6, filter(surveys, surveys$weight>= 30 & surveys$weight<= 60)]
#arrrgghhh. not sure why i'm getting this error. need to fiddle
surveys %>% 
  filter(!is.na(weight)) %>% 
  surveys[1:6, filter(weight>= 30 & weight<= 60)]
#i thought maybe going simpler would work but still getting object 'weight' not found
surveys %>% 
  filter(!is.na(weight)) %>% 
  surveys[1:6, surveys[weight >= 30 & weight <= 60]]
#okay let's try something else. trying to figure out this object thing
filter(surveys, weight ==30)
#damn what the hell! that worked. so it can find weight, i'm just doing something wrong
surveys[1:6, ]
#okay and that does pull the first 6 rows. lemme see if i can find where i'm messing up
surveys[1:6, filter(surveys, weight==30)]
#okay that's one spot where i'm messing it up. let me do it in two different rows
surveys %>% 
  filter(!is.na(weight)) %>% 
  surveys[1:6, ] %>% 
  filter(weight>=30 & weight<=60)
#arrrghhhhh no i just can't do the weights for some reason. getting invalid subscript type
summarize(surveys, weight >= 30 & weight <= 60)
head(summarize(surveys, weight >= 30 & weight <= 60))
summarize(surveys, weight)
#was trying to see if summarize could help me but now
filter(surveys, weight>=30)
filter(surveys, (weight>=30 & weight<=60))
#oh my god. this worked. was i just missing a pair of parentheses this entire time?
surveys %>% 
  filter(!is.na(weight)) %>% 
  surveys[1:6, ] %>% 
  filter(surveys, (weight>=30 & weight<=60))
#okay now hang on bc this gave me the invalid subscript type again
surveys %>% 
  filter(weight>=30 & weight<=60)
#omg this worked. let me subset to just first 6 rows  
surveys %>% 
  filter(weight>=30 & weight<=60) %>% 
  surveys[1:6, ]
#oh my god it's here that i'm getting the error.

##finally got it----
surveys %>% 
  filter(weight>=30 & weight<=60) %>% 
  slice(1:6)
#OH MY GOD. so i was overcomplicating my weight selection AND just slicing wrong
#well we're 66 rows in and i finally completed step 2. what next

#number 3----
biggest_critters <- surveys %>% 
  filter(weight>=30 & weight<=60) %>% 
  slice(1:6) %>% 
  group_by(species_id, sex)
biggest_critters #oh wait. I thought they wanted us to use the data from step 2
#but in reading the next instructions, it seems like they want us to start entirely
#over?
surveys %>% 
  group_by(species_id, sex) %>% 
  filter(!is.na(weight)) %>% 
  summarize(max_weight = max(weight)) %>% 
  arrange(-max_weight) #figuring out my pipeline
biggest_critters <-surveys %>% 
  group_by(species_id, sex) %>% 
  filter(!is.na(weight)) %>% 
  summarize(max_weight = max(weight)) %>% 
  arrange(-max_weight) #saving it as the dataframe
biggest_critters #done! 

#number 4----
surveys %>% filter(is.na(weight))
#okay i've pulled all the rows with NA weights
surveys %>%
  group_by(species_id) %>% 
  tally(is.na(weight)) %>% 
  arrange(-n)
#for species_id, AH (n=437), DM (334), and AB (303) have the highest NA weights
surveys %>%
  group_by(sex) %>% 
  tally(is.na(weight)) %>% 
  arrange(-n)
#males have more NA weights than females, but not by a huge amount - 469vs.387
surveys %>%
  group_by(plot_id) %>% 
  tally(is.na(weight)) %>% 
  arrange(-n)
#plots 13 (n=160), 15 (155), 14 (152) are the top locations with NA weights
surveys %>%
  group_by(year) %>% 
  tally(is.na(weight)) %>% 
  arrange(-n)
#for years, 1977 (n=221), 1998 (195), 1987 (151) have the most NA weights

#number 5----
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight=mean(weight, na.rm=TRUE)) %>% 
  select(species_id, sex, weight, avg_weight)
#yeaaaaahhh! now just need to save it as a data frame
surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight=mean(weight, na.rm=TRUE)) %>% 
  select(species_id, sex, weight, avg_weight)
surveys_avg_weight #yesssss success

#number 6----
surveys_avg_weight %>% 
  mutate(above_average=ifelse(weight<avg_weight, "below", "above"))
#hell yeah. figured that one out in about 10 mins