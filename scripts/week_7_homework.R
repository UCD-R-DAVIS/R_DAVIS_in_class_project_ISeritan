library(tidyverse)
library(ggplot2)
library(cowplot)
gapminder <- read.csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")
#loaded libraries & data
str(gapminder)
view(gapminder)

Europe0207 <- gapminder %>%
  filter(year==c(2002,2007)) %>% 
  filter(continent=="Europe")
#made data frames for each continent

Africa0207 <- Africa0207 %>% 
  pivot_wider(id_cols='country',
              names_from = 'year',
              values_from='pop')
#saved each continent's data frame as a pivot table
  
Americas0207 <- Americas0207 %>% 
  mutate(popdif=Americas0207$"2007"-Americas0207$"2002") %>% 
  arrange(+popdif)
#saved each continent's data frame with a column for the difference in population (popdif), and arranged in order of ascending popdif

Africa.plot <- ggplot(data=Africa0207, mapping=aes(x=reorder(country,+popdif), y=popdif))+
  geom_bar(stat='identity', fill='purple')+
  theme_bw()+
  ggtitle("Africa")+
  theme(plot.title = element_text(hjust=0.5))+
  theme(axis.text.x=element_text(angle=45, hjust=1),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())
#saved plot for African countries

Asia.plot <- ggplot(data=Asia0207, mapping=aes(x=reorder(country,+popdif), y=popdif))+
  geom_bar(stat='identity', fill='orange')+
  theme_bw()+
  ggtitle("Asia")+
  theme(plot.title = element_text(hjust=0.5))+
  theme(axis.text.x=element_text(angle=45, hjust=1),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())

Europe.plot <- ggplot(data=Europe0207, mapping=aes(x=reorder(country,+popdif), y=popdif))+
  geom_bar(stat='identity', fill='blue')+
  theme_bw()+
  ggtitle("Europe")+
  theme(plot.title = element_text(hjust=0.5))+
  theme(axis.text.x=element_text(angle=45, hjust=1),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())

Americas.plot <- ggplot(data=Americas0207, mapping=aes(x=reorder(country,+popdif), y=popdif))+
  geom_bar(stat='identity', fill='pink')+
  theme_bw()+
  ggtitle("Americas")+
  theme(plot.title = element_text(hjust=0.5))+
  theme(axis.text.x=element_text(angle=45, hjust=1),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())
#okay saved plots for all 4 continents

continent.grid <- plot_grid(Africa.plot, Americas.plot, Asia.plot, Europe.plot, 
                        ncol=2, nrow = 2)+
  draw_label("Country", x = 0.5, y = 0, vjust = -1, angle = 0, size = 14) +
  draw_label("Change in Population between 2002 to 2007", x = 0, y = 0.60, vjust = -0.75, angle = 90, size = 12)+
  theme(plot.margin = unit(c(0.25,0,0,1), "cm"))
#yay! made my plot, now to save it
ggsave("figures/countrypops.png")