# ggplot2 ----
## Grammar of Graphics plotting package (included in tidyverse package - you can see this when you call library(tidyverse)!)
library(tidyverse)
## easy to use functions to produce pretty plots
## ?ggplot2 will take you to the package helpfile where there is a link to the website: https://ggplot2.tidyverse.org - this is where you'll find the cheatsheet with visuals of what the package can do!

## ggplot basics
## every plot can be made from these three components: data, the coordinate system (ie what gets mapped), and the geoms (how to graphical represent the data)
## Syntax: ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPING>))

## tips and tricks
## think about the type of data and how many data  variables you are working with -- is it continuous, categorical, a combo of both? is it just one variable or three? this will help you settle on what type of geom you want to plot
## order matters! ggplot works by layering each geom on top of the other
## also aesthetics like color & size of text matters! make your plots accessible 


## example ----
library(tidyverse)
## load in data
surveys <- read_csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.)) # remove all NA's

## Let's look at two continuous variables: weight & hindfoot length
## Specific geom settings

ggplot(data = surveys, mapping = aes(x=weight, y=hindfoot_length)) +
  geom_point(aes(color=genus))+
  geom_smooth(aes(color=genus))

## Universal geom settings

ggplot(data = surveys, mapping = aes(x=weight, y=hindfoot_length, color=genus)) +
  geom_point()+
  geom_smooth()
#can specify colors, we'll be talking about that in later lectures

## Visualize weight categories and the range of hindfoot lengths in each group
## Bonus from hw: 
sum_weight <- summary(surveys$weight)
surveys_wt_cat <- surveys %>% 
  mutate(weight_cat = case_when(
    weight <= sum_weight[[2]] ~ "small", 
    weight > sum_weight[[2]] & weight < sum_weight[[5]] ~ "medium",
    weight >= sum_weight[[5]] ~ "large"
  )) 

table(surveys_wt_cat$weight_cat)

## We have one categorical variable and one continuous variable - what type of plot is best?
ggplot(data=surveys_wt_cat, mapping = aes(x=weight_cat, y=hindfoot_length))+
  geom_boxplot(aes(color=weight_cat), alpha=0.8)+
  geom_point(alpha=0.1)
#alpha is transparency


## What if I want to switch order of weight_cat? factor!
surveys_wt_cat$weight_cat <-
  factor(surveys_wt_cat$weight_cat, c("small", "medium", "large"))

#jitter plots
ggplot(data=surveys_wt_cat, mapping = aes(x=weight_cat, y=hindfoot_length))+
  geom_boxplot(aes(color=weight_cat), alpha=0.8)+
  geom_jitter(alpha=0.1)

#time series----
library(tidyverse)

surveys_complete <- read_csv('data/portal_data_joined.csv') %>%
  filter(complete.cases(.))

# these are two different ways of doing the same thing
head(surveys_complete %>% count(year,species_id))
head(surveys_complete %>% group_by(year,species_id) %>% tally())

yearly_counts <- surveys_complete %>% count(year,species_id)
head(yearly_counts)
#now we have a data frame w yearly counts

ggplot(data=yearly_counts, mapping=aes(x=year, y=n))+
  geom_line()
#this looks horrible because we're telling R to draw a line between every single point in each year. we can fix this by grouping or telling R to use dif colors

ggplot(data = yearly_counts,mapping = aes(x = year, y= n, group=species_id)) +
  geom_line()
#this already looks better because we're mapping by species

ggplot(data = yearly_counts,mapping = aes(x = year, y= n, group=species_id)) +
  geom_line(aes(color=species_id))
#now have colors for each species but all the colors are hard to tell apart. here's where facetting comes in

ggplot(data = yearly_counts,mapping = aes(x = year, y= n, colour = species_id)) +
  geom_line()
#same way of plotting as above but with universal setting, not fixing facet problem

#facetting----
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)
#what's inside the facet_wrap parentheses is a formula for mapping species_id. this has split up the lines onto one plot per line, but obviously this can create a shitton of plots - in this case, 24 plots

ggplot(data = yearly_counts[yearly_counts$species_id%in%c('BA', 'DM', 'DO', 'DS'),], mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id,scales = 'free_y')
#pulled just the firs 4 plots so we're not looking at 24. also can have R adjust the scaling so that each line is easy to see but it can become confusing once the scales are different - we don't want to be manipulative about how we present data

ggplot(data = yearly_counts[yearly_counts$species_id%in%c('BA', 'DM', 'DO', 'DS'),], mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)+
  scale_y_continuous(name='obs',n.breaks=12)+
  theme_clean()
#scaling with n.breaks created 12 visible columns in the graph to make the years easier to see
#and theme allows us to make the graphs look nicer - changing backgrounds, moving legend, etc etc

#we can also make maps with ggplot, tyler showed us how with some libraries that we do not have downloaded
install.packages('ggthemes')
library(ggthemes)
#now we can call up fun themes
