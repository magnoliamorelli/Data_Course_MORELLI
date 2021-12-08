library(tidyverse)
library(plotly)
options(scipen = 999)

# Making ggplot
full <- readRDS("Fourth_Webpage/full.csv")

p <- full %>% 
  ggplot(aes(x=Country,y=`International Tourist Arrivals`,
             text=paste("#1 Tourist Attraction:<br>", full$Attraction))) +
  geom_col(fill="blue") +
  theme(axis.text.x = element_text(angle=58,hjust = 1)) +
  labs(title = "Most Visited Countries & Top Tourist Attraction",
       subtitle = "By Tourist Arrivals",
       caption = "Source:https://worldpopulationreview.com/country-rankings/most-visited-countries")

p <- ggplotly(p, tooltip = "text")
print(p)

htmlwidgets::saveWidget(p,"Fourth_Webpage/p.html")
