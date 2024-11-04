library(tidyverse)
gapminder <- read.csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")
str(gapminder)

#part 1----
#First calculates mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)
gapminder %>% 
  group_by(continent) %>% 
  summarize(lifeExp_mean=mean(lifeExp))
#so I have successfully calculated the mean life expectancy, but this question is written confusingly - am I supposed to include the mean life expectancy on the plot with life expectancy change? or is that a completely different task? i'm going to treat it as a different task
ggplot(data = gapminder, mapping = aes(x=year, y=lifeExp)) +
  geom_smooth(aes(color=continent))
#that gives me my plot for life expectancy change in each continent
#postscript note added after I had completed all the rest of the problems and looked at the answers: okay I see, I was supposed to do both of them in one function. I didn't realize that ggplot() can be added into the piping function, but now that I've seen the answers, I understand how to do that in the future. 

#part 2----
#Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
#the scale_x_log10 line is setting the scale of the x axis to increase by 1 order of magnitude per unit, so the scale is logarithmic rather than linear. the geom_smooth line adds a straight line that best fits the data

#challenge----
#Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot?
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size=pop))+
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#part 3----
#Create a boxplot that shows the life expectancy for Brazil, China, El Salvador, Niger, and the United States, with the data points in the background using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.
ggplot(gapminder[gapminder$country%in%c('Brazil','China','El Salvador','Niger','United States'),], mapping = aes(x=country, y=lifeExp))+
  geom_jitter(aes(color=country))+
  geom_boxplot(aes(color=country))+
  ggtitle("Life Expectancy of Five Countries") +
  xlab("Country") + ylab("Life Expectancy")+
  theme_bw()+
  theme(legend.position = "none")
#done! yay!