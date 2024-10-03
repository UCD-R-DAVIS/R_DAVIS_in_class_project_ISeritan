# arithmetic ----
3+4
3 + 4
2 *

# order of operations ----
4+8*3^2
4 + 8 * 3 ^ 2  
4+8*3^2
?log

# values ----
#setting and removing values, not recommended to use x or any other variable
#that will be otherwise present in your work
x <- 1
rm(x)

# nesting functions ----
sqrt(exp(4))

#setting variables - you can use an = or an <- but <- is preferable to reduce
#confusion with = and ==. == is asking a question
mynumber <- 6
mynumber == 5
mynumber != 5
mynumber > 4

# elephants ----
#c = concatenate
elephant1_kg <- 3492
elephant2_lb <- 7757
elephant1_lb <- elephant1_kg * 2.2
elephant2_lb > elephant1_lb
myelephants <- c(elephant1_lb, elephant2_lb)
myelephants
which(myelephants == max (myelephants))

# working directories ----
getwd
getwd()

#you can set a new working directory with setwd() if you have data that you
#want r to pull out of a different folder than you're currently working out of

# dir.create("./lectures") - once you make the directory, can comment it out

# vectors ----
weight_g <- c(50,60,65,82)
weight_one_value <- c(50)

animals <- c("mouse", "rat", "dog")

## inspecting vectors ----
length(weight_g)
str(weight_g)

### changing vectors ----
weight_g <- c(weight_g, 90)
weight_g
#now the weight vector has a 5th number which is 90

#### num or char vectors ----
num_char <- c(1,2,3, "a")
num_char
num_logical <- c(1,2,3,TRUE)
num_logical
char_logical <- c("a", "b", "c", TRUE)
char_logical
tricky <- c(1,2,3, "4")
tricky
#everything in a vector needs to be the same class, either a number or a char.
#if you put in a bunch of numbers and one char, r cannot turn the char into a
#num so it will interpret (or the more technical term "coerce") everything into
#char. however in the 1,2,3,TRUE vector, TRUE is interpreted as 1 in binary
#and FALSE is interpreted as 0 in binary, so this whole vector can be num

# subsetting ----
animals
animals[2] #taking items out of the set
animals[c(2,3)]
animals[c(2,2,2)] #rat rat rat

## conditional subsetting ----
weight_g <- c(21, 34, 39, 54, 55)
weight_g > 50 #telling us which values in weight_g are above 50
weight_g[weight_g > 50] #giving us only the parts of weight_g that are above 50

# symbols
# %in%$ = is my search term wthin this other category
# == is pairwise matching, order matters, as opposed to %in% which is like
#shaking up a bucket and seeing if the terms match at all
animals %in% c("rat", "cat", "dog", "duck", "goat")
#this works backwards to how I thought it was going to work - rather than saying
#that "rat" is TRUE bc it's in the animals list, it says FALSE bc my animals
#list is mouse" "rat"   "dog" and mouse is NOT in this list that i'm searching in
animals


