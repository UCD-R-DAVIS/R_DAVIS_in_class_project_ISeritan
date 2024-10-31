#task 1----
library(tidyverse)
activity <- read.csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")
activity
str(activity)

#task 2----
#Filter out any non-running activities.
activity_run <- activity %>% filter(sport=="running")

#task 3----
#Next, Tyler often has to take walk breaks between laps right now because trying to change how you’ve run for 25 years is hard. You can assume that any lap with a pace above 10 minute-per-mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute-per-mile pace) and abnormally short records where the total elapsed time is one minute or less.
activity_run <- activity_run %>% 
  filter(minutes_per_mile<10 & minutes_per_mile>5 & total_elapsed_time_s>=60)

#task 4----
#Create a new categorical variable, pace, that categorizes laps by pace: “fast” (< 6 minutes-per-mile), “medium” (6:00 to 8:00), and “slow” ( > 8:00). Create a second categorical variable, form that distinguishes between laps run in the year 2024 (“new”, as Tyler started his rehab in January 2024) and all prior years (“old”).
activity_run <- activity_run %>% 
  mutate(pace = case_when(
    minutes_per_mile<6 ~ "fast",
    minutes_per_mile<8 ~ "medium",
    TRUE ~ "slow"))
#created pace column and added to data frame

activity_run <- activity_run %>% 
  mutate(form = ifelse(year>=2024, "new", "old"))
#created form column and added to data frame

#task 5----
#Identify the average steps per minute for laps by form and pace, and generate a table showing these values with old and new as separate rows and pace categories as columns. Make sure that slow speed is the second column, medium speed is the third column, and fast speed is the fourth column (hint: think about what the select() function does).
head(activity_run, n=6)
activity_steps <- activity_run %>%
  group_by(form, pace) %>% 
  summarize(avg_steps = mean(steps_per_minute)) %>% 
  select(form, pace, avg_steps)
#okay so far this has given  me a data frame w columns of form, pace, and avg_steps for the various combos of form & pace. originally I used mutate, then switched to summarize, so that I had just one avg value listed for each category instead of a whole column of them. saved as a new data frame
activity_steps <- activity_steps %>% 
  pivot_wider(id_cols='form',
              names_from = 'pace',
              values_from='avg_steps')
#okay this gives me a data frame w the columns in order fast, medium, slow
activity_steps <- activity_steps[, c("form", "slow", "medium", "fast")]
activity_steps
#successfully reordered to form, slow, medium, fast! I can see that Tyler really does have more steps per minute overall in the new form rather than the old form, and there are the most steps per minute (172) in the fast category of the new form than in any other category

#task 6----
#Finally, Tyler thinks he’s been doing better since July after the doctors filmed him running again and provided new advice. Summarize the minimum, mean, median, and maximum steps per minute results for all laps (regardless of pace category) run between January - June 2024 and July - October 2024 for comparison.
activity_advice <- activity_run %>% 
  filter(year>=2024) %>% 
  mutate(advice = case_when(
    month>=7 ~ "after",
    TRUE ~ "before"))
activity_advice
#okay I made the category of "before" and "after" advice - and I ran out of time. my next step was going to be to group the steps per minute by before or after advice, then run summary on those categories. but that's it! 