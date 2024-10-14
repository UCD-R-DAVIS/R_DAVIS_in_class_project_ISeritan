#attempting homework----
surveys <- read.csv("data/portal_data_joined.csv")
str(surveys)
surveys_base <- surveys %>% select(species_id, weight, plot_type) 
library("tidyverse") #needed to load tidyverse for R to understand %>% 
surveys_base <- surveys %>% select(species_id, weight, plot_type)
surveys_base
head(surveys_base) #just checking my work. successfully selected the columns
data.frame(surveys_base)
class(surveys_base) #checking to make sure I made the data frame right
surveys_base[1:5000,] #selecting first 5000 rows
surveys_base <- surveys_base[1:5000,] #saving surveys_base as first 5000 rows
species_id <- factor(species_id)
summarize(species_id) #figuring out how to isolate 1 column
summary(surveys_base)
surveys_base$species_id <- as.factor(surveys_base$species_id)
class(surveys_base$species_id) #checking my work. species_id is now factor
surveys_base$plot_type <- as.factor(surveys_base$plot_type)
class(surveys_base$plot_type) #checking work again. plot_type is factor
surveys_base <- surveys_base(!is.na(surveys_base$weight))
surveys_base <- surveys_base(!is.na(weight))
surveys_base <- surveys_base[!is.na(weight)]
surveys_base[!is.na(surveys_base$weight)]
surveys_base$weight[!is.na(surveys_base$weight)] #puzzling through the !is.na
surveys_base <- surveys_base$weight[!is.na(surveys_base$weight)] #oops. i
#accidentally turned my entire data frame into the weights. restarting from top

#starting over----
#alright. redid my surveys_base data frame up to the factors. redoing the !is.na
surveys_base$weight <- surveys_base$weight[!is.na(surveys_base$weight)]
#hm. gives an error bc there is a different number of rows. trying again
surveys_base %>% filter(!is.na(surveys_base$weight)) #different tactic
surveys_base <- surveys_base %>% filter(!is.na(surveys_base$weight))
#okay I believe the data frame has now filtered out all rows w/ NA values for wt.
#to the best of my knowledge, this should be the completion of my homework


#exploring my data frame----
surveys_base
summary(surveys_base)
summary(surveys_base$species_id) #species_id are alphabetized
summary(surveys_base$plot_type) #plot_type are alphabetized
as.character(surveys_base$species_id)
#I think that changing the species_id and plot_type columns to factors makes it
#easier to see and manipulate the data rather than keeping them as characters. The
#categories are sorted into levels which are then alphabetized, so we can quickly
#see what the different species_ids are and how many individuals are in each
#species_id, and same for the plot_types. From there, we could continue to sort
#out specific species or compare the two plot_types to each other by adjusting
#the factors rather than having to wrestle with unsorted characters. 

#challenge----
challenge_base <- surveys_base %>% filter(surveys_base$weight > 150)
challenge_base #okay that should be it :)