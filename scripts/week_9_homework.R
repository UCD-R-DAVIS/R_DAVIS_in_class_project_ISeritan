surveys <- read.csv("data/portal_data_joined.csv")
library(tidyverse)

#Using a for loop, print to the console the longest species name of each taxon. Hint: the function nchar() gets you the number of characters in a string.

head(surveys)
x <- unique(surveys$taxa)
x

#part 1----
for(i in unique(surveys$taxa)){
  taxon_names <- surveys[surveys$taxa == i, ]
  longest_names <- taxon_names[nchar(taxon_names$species)==
                                 max(nchar(taxon_names$species)),] %>% 
    select(species)
  print(paste0("The longest species name(s) among the taxon ", i, " is/are: "))
  print(unique(longest_names$species))
}
#I'm gonna be honest, I needed to look at the answer for this one. I had figured out the first two lines in order to isolate the 4 taxa of Rodent, Rabbit, Bird, and Reptile. I had figured out that I needed the function max(nchar(taxon_names$species)) to identify which species names had the most characters, and I knew I needed the function to print species names, but I couldn't figure out how to get the function to print species names instead of printing the number of characters. It was lines 10, 11, and 12 that stumped me, but in looking at them now, I can understand the order of events. In line 10 & 11 we ask R to check if the number of characters in each species names matches the maximum number of characters in each species name, and in line 12, we select the species that do match the max. Lines 13 and 14 print nice sentences with our results.


mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
str(mloa)

#part 2----
#Use the map function from purrr to print the max of each of the following columns: “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”.

map(mloa %>% select(windDir, windSpeed_m_s, baro_hPa, temp_C_2m, temp_C_10m, temp_C_towertop, rel_humid, precip_intens_mm_hr), max)
#lol it's funny that I struggled with the first question for an hour and a half but this one took me 2 minutes.

#part 3----
#Make a function called C_to_F that converts Celsius to Fahrenheit. Hint: first you need to multiply the Celsius temperature by 1.8, then add 32. Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”. Bonus: can you do this by using map_df? Don’t forget to name your new columns “temp_F…” and not “temp_C…”!

C_to_F <- function(tempC){
  f <- (tempC*1.8)+32
  return(f)
}
C_to_F(8)
#this is my function for temp conversion, and I checked that it works

mloa %>% 
  select(temp_C_2m, temp_C_10m, temp_C_towertop) %>% 
  map_df(., C_to_F) %>% 
  rename(
    temp_F_2m = temp_C_2m,
    temp_F_10m = temp_C_10m,
    temp_F_towertop = temp_C_towertop)
#tada! this selected the three C columns, applied my new C_to_F function to convert the temp, then renamed the columns to be F instead of C. 

#challenge----
#Use lapply to create a new column of the surveys dataframe that includes the genus and species name together as one string.

latin_name <- function(sp){
  lapply(seq_len(nrow(sp)),
         function(i) paste0(sp[i,"genus"], " ", sp[i, "species"]))
}
#created a new function called latin_name that pulls each sequential row out of a data frame and pastes genus & species together

surveys$LatinName <- latin_name(surveys)
#made a new column called LatinName that is filled with information from the latin_name function

head(surveys)
#looked at the data frame and it does indeed have the new column!