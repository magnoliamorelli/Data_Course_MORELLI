library(tidyverse)

df <- read.csv("Data/mushroom_growth.csv")

df %>% 
  ggplot(aes(x=Species,y=GrowthRate,alpha=Light)) +
  geom_point(color="slateblue1",size=20,shape=21) +
  theme(axis.title.x = element_text(angle = 190,face = "bold.italic",
        vjust = .05, size = 66,color = "yellow"), 
        axis.title.y = element_text(angle = 152, hjust = 1,colour = "tomato"),
        plot.background = element_rect(fill = "mediumaquamarine",
        color = "yellow4", size = 22,linetype = 2646),
        legend.text = element_text(size = .3, hjust = .03, colour = "red"),
        legend.background = element_rect(fill = 'black',
        color = "yellow3",size = 11),
        panel.background = element_rect(fill = "tan1")) +
        labs(color="idk") 

