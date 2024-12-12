library(tidyverse)

#part 1----
#Read in the file tyler_activity_laps_12-6.csv from the class github page. This file is at url https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.

activities <- read.csv("https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv")

#part 2----
#Filter out any non-running activities.
activities <- activities %>% 
  filter(sport=="running")

#part 3----
#We are interested in normal running. You can assume that any lap with a pace above 10 minutes_per_mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute_per_mile pace) and abnormally short records where the total elapsed time is one minute or less.
activities <- activities %>% 
  filter(minutes_per_mile <= 10 & minutes_per_mile >= 5 & total_elapsed_time_s > 60)

#part 4----
#Group observations into three time periods corresponding to pre-2024 running, Tyler’s initial rehab efforts from January to June of this year, and activities from July to the present.
activities_rehab <- activities %>% 
  mutate(period = case_when(
    year<2024 ~ "Pre-2024",
    month<7 ~ "Initial Rehab",
    TRUE ~ "Present Rehab"))

#part 5----
#Make a scatter plot that graphs SPM over speed by lap.
ggplot(activities_rehab, aes(x=minutes_per_mile, y=steps_per_minute))+
  geom_point()

#part 6----
#Make 5 aesthetic changes to the plot to improve the visual.
install.packages('ggthemes')
library(ggthemes)
library("RColorBrewer")
display.brewer.all(colorblindFriendly = TRUE)

ggplot(activities_rehab, aes(x=minutes_per_mile, y=steps_per_minute, color=period))+
  geom_point(shape=17)+
  theme_clean()+
  ggtitle("Minutes per Mile vs. Steps per Minute") +
  xlab("Minutes per Mile") + ylab("Steps per Minute")+
  scale_color_brewer(palette="Dark2", 
                     name="Rehabilitation Period", 
                     breaks=c('Pre-2024', 'Initial Rehab', 'Present Rehab'))
#yay! happy with that plot

#part 7----
#Add linear (i.e., straight) trendlines to the plot to show the relationship between speed and SPM for each of the three time periods (hint: you might want to check out the options for geom_smooth())
ggplot(activities_rehab, aes(x=minutes_per_mile, y=steps_per_minute, color=period))+
  geom_point(shape=17)+
  geom_smooth(method=lm)+
  theme_clean()+
  ggtitle("Minutes per Mile vs. Steps per Minute") +
  xlab("Minutes per Mile") + ylab("Steps per Minute")+
  scale_color_brewer(palette="Dark2", 
                     name="Rehabilitation Period", 
                     breaks=c('Pre-2024', 'Initial Rehab', 'Present Rehab'))

#part 8
#Does this relationship maintain or break down as Tyler gets tired? Focus just on post-intervention runs (after July 1, 2024). Make a plot (of your choosing) that shows SPM vs. speed by lap. Use the timestamp indicator to assign lap numbers, assuming that all laps on a given day correspond to the same run (hint: check out the rank() function). Select only laps 1-3 (Tyler never runs more than three miles these days). Make a plot that shows SPM, speed, and lap number (pick a visualization that you think best shows these three variables).
activities_present <- activities_rehab %>% 
  filter(period=="Present Rehab") %>% 
  mutate(datetime=paste(year, "-", month, "-", day, sep = ""))
#filtered for current rehab period, added column with ymd so that I can deal with each day at a time. my issue now is that i can get rank() to rank every single timestamp in the whole dataframe, but i don't understand how to get it to rank laps from each individual day. i thought i could do it with a for loop and/or a function that basically ranks laps in one day then starts over again the next day but i spent a long time trying to figure out my for loop and/or function and couldn't get them to work. i also tried doing it more simply by just grouping by my datetime, but that gave me an error message that i was grouping across different data types. i tried for over an hour and looked at all my lecture notes, homeworks, and relevant slack overflow posts, but couldn't figure it out before hitting 2 hours. 

#here's my best attempt at a for loop - what this one does is rank the first day 2024-7-4's timestamps, but it doesn't keep going to the next day
for(i in unique(activities_present$datetime)){
  dayatatime <- activities_present[activities_present$datetime == i, ]
  df <- dayatatime$timestamp %>%
    rank(na.last=NA, ties.method=c("first"))
  return(df)
}

#this for loop still only returns the lap numbers for day 1 but at least now i've put them in a neat little column lol
for(i in unique(activities_present$datetime)){
  dayatatime <- activities_present[activities_present$datetime == i, ]
  k <- dayatatime %>%
    summarize(lapnumber=rank(timestamp, na.last=NA, ties.method=c("first")))
  return(k)
}
k
