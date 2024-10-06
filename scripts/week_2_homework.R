set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2
rm(hw2)  #got confused about what exactly was happening, started over
set.seed(15)
hw2 <- runif(50, 4, 50) #okay this is the function that gives me the matrix
hw2
hw2 <- replace(hw2, c(4,12,22,27), NA) # this is replacing the values in
#spots 4, 12, 22, 27 with char NA
hw2
hw2[ !hw2 == NA] #oops that created a string of NAs instead of removing them
hw2 #checking to see if the hw2 vector itself was changed, no it wasn't
hw2[-c(4,12,22,27)] #ok this is 1 way to get rid of NA elements (by location)
hw2[!is.na(hw2)] #this is a nicer way to get rid of NAs - by selecting them out
y <- hw2[!is.na(hw2)] #for the sake of clarity, made a non-NA matrix called y
y[c(14:38)] #checking if this selects for values in locations 14-38 in y
prob1 <- y[c[14:38]] #setting the selected values in y as prob 1
prob1 <- y[c(14:38)] #oops used wrong brackets above, fixed to parentheses here
prob1*3 #shocked this worked tbh, I just guessed
times3 <- prob1*3
plus10 <- times3+10 #multiplied each value in matrix by 3 and added 10 
#okay something has occurred and i don't have the right numbers. i think maybe
#what has happened is that when i removed the NAs, that changed what values are
#in spots 14-38 so everything after selecting spots 14-38 is off. trying again
hw2
y #okay so i need to select everything from 36.504914 to 27.733004 which are
#now spots 12 to 34. let's try this again
prob1 <- y[c(12:34)]
prob1 #great this does seem to give me the correct spots. redoing the above
times3 <- prob1*3
plus10 <- times3+10 #OH MY GOD I FINALLY FIGURED OUT WHAT I'M DOING WRONG. the
#problem is not asking me to select the values in spots 14-38, they are asking
#me to select the numbers that are of value between 14-38. dang. okay let's
#start over AGAIN from y
y >= 14 | y <= 38
y[y >= 14 | y <= 38] #oops the | is for or. let's try &
y[y >= 14 & y <= 38] #YEAAAHHH successfully pulled values between 14 & 38
prob1 <- y[y >= 14 & y <= 38] #here we go. 3rd time's the charm
times3 <- prob1*3
plus10 <- times3+10 #GREAT! finally have the correct numbers, now just need to
#select only every other number
final <- plus10[c(1,3,5,7,9,11,13,15,17,19,21,23)] #i'm sure there's a more
#elegant way to do this but oh well. chose just to pick the locations by hand
final #YAAAAY
