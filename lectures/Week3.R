#week2 vectors----
#more elegant way to select every other value is to use plus10[c(TRUE, FALSE)]
#as that tells R that we want first number, not second number, third, etc etc.

#also other ways to get rid of NAs besides !is.na are na.omit and complete.cases
#but beware of complete.cases - that may cause problems with your data

#also also another way to do multiple functions at once is just to include them
#all in same brackets. as in hw2[!is.na(hw2) & hw2 >= 14 & hw2 <= 38] rather than
#doing the !is.na first and then the subsetting second

#other data types ----
##lists----
c(4, 6, "Dog") #putting all values into one vector
list(4, 6, "dog") #every value becomes its own vector
a <- list(4,6,"Dog") #R doesn't care about spaces
class(a) #can use the same functions for vectors on lists
a
str(a)

##data.frames ----
letters
data.frame(letters) #turns the letters of the alphabet into a column of data
df <- data.frame(letters)
length(df)
dim(df) #dim is better for exploring data frames than length
nrow(df) #how many rows?
ncol(df) #how many columns?
t(df) #function for transposing matrices, so this coerced the data frame
as.data.frame(t(df)) #this transposed it but still as a data frame

##factors----
animals <- factor(c("pigs", "duck", "duck", "goose", "goose"))
animals #R assigns levels alphabetically
levels(animals) #what are the levels?
nlevels(animals) #how many levels?
animals <- factor(x = animals, levels = c("goose", "pigs", "duck"))
animals #we reordered the levels to our specifications

year <- factor(c(1978, 1980, 1934, 1979))
year #this time the factor orders the years numerically 
class(year)
as.numeric(year) #gives us the order of levels as in the chronological order,
#this can be helpful OR confusing so pay attention
as.numeric(animals) #for ex. now we're getting numbers instead of animals
as.character(animals) #now R is giving us the characters 

#surveys----
#now downloading data to work with instead of making up strings ourselves

getwd()
'' #if i get lost in where my data is, do these 2 lines and hit tab between ''

?read.csv
surveys <- read.csv("data/portal_data_joined.csv")
nrow(surveys)
ncol(surveys)
dim(surveys)

str(surveys) #tells us all the columns and what sorts of data are in them
summary(surveys) #summary is a generic function. R first looks at what class
#is under the hood and then uses that class' specific summary function

surveys[1,5] #this indexes a location in the data frame. 1st row, 5th column
surveys[1:5] #this indexes first 5 rows
surveys[1:5,] #this indexes first 5 rows from all columns bc we didn't specify
surveys[c(1,5,24, 3001),] #this gives specifically those rows for all columns
surveys[,1:5] #pulls all rows for first 5 columns
surveys[1] #data frames are a 2d chart with an x/y but one# alone is just column
surveys['record_id'] #this is a more specific method to pull just the 1st column
colnames(surveys)
surveys[c('record_id', 'year', 'day')]
dim(surveys[c('record_id', 'year', 'day')]) #giving us just the col. we asked
#for by name - helpful in case you're moving stuff around
#functions are ( ) and pulling data out of objects are [ ] (think of as a grid)

head(surveys) #use to look at top of survey
head(surveys,n=10) #giving top 10 rows
head(surveys[1:10,]) #can call just the top to see if R is doing what we want
tail(surveys[1:10,]) #or can call bottom

###fun with brackets----
head(surveys["genus"]) #pulling the data out of the top of the genus column.
#comes with metadata
head(surveys[["genus"]]) #pulling JUST the vector of genera out of the data
#frame. loses its metadata
head(surveys[c("genus", "species")]) #pulling genus & species
head(surveys[["genus", "species"]]) #throws error bc now R is looking for genus
#species VECTOR
head(surveys['genus',]) #gives NAs bc we asked for genus as a row
head(surveys[,'genus']) #gives top genera from the genus column

surveys$record_id #dollar sign looks through the next level of the list
surveys$hindfoot_length

install.packages('tindyverse')
install.packages('tidyverse')
library(tidyverse)

t_surveys <- read_csv('data/portal_data_joined.csv')
class(t_surveys) #this is still a data frame but now has some special stuff
#along with it to help it show data nicely. the special stuff = tibble

t_surveys
