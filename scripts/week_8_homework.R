library(tidyverse)
library(lubridate)
library("RColorBrewer")
mloa<- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

#Use the README file associated with the Mauna Loa dataset to determine in what time zone the data are reported, and how missing values are reported in each column. With the mloa data.frame, remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s. Generate a column called “datetime” using the year, month, day, hour24, and min columns. Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()). Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()). Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.

#time zone: UTC
mloa_DateTime <- mloa %>% 
  filter(!(rel_humid==-99 | temp_C_2m==-999.9 | windSpeed_m_s==-999.9)) %>% 
  mutate(datetime=paste(year, "-", month,
                        "-", day, ", ", hour24, ":",
                        min, sep = "")) %>% 
  mutate(datetime=as_datetime(datetime, 
                              tz="UTC", 
                              format="%Y-%m-%d, %H:%M")) %>% 
  mutate(datetimeLocal=with_tz(datetime, "HST"))
#okay that took a while to figure out because I forgot to include the "format" line and R was parsing my minutes as seconds. got it now lol

mloa_DateTime %>% 
  mutate(monthly = month(datetimeLocal, label=TRUE),
         hourly=hour(datetimeLocal)) %>% 
  group_by(monthly, hourly) %>%
  summarize(mean_hourly_t = mean(temp_C_2m)) %>% 
  ggplot(aes(x=monthly,y=mean_hourly_t, color=hourly))+
  geom_point()+
  ggtitle("Mean Hourly Temperatures by Month")+
  xlab("Month")+ylab("Mean Temperature")+
  labs(col="Hour")+
  theme_bw()
#i really struggled with how to use month() & hour() so i looked only at those lines in the answers and figured out the rest through trial and error
ggsave("figures/hourlytempsbymonth.png")
