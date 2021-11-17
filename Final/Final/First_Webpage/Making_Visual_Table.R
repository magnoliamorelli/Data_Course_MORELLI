# Load Packages
library(tidyverse)
library(gt)

# Making table
the_table %>% gt() %>% 
  tab_header(
    title = "World Countries and Populations",
    subtitle = "Listed Alphabetically"
  ) %>% 
  tab_source_note("Data Source: https://www.worldometers.info/geography/alphabetical-list-of-countries/") %>% 
  cols_align(align = "left", columns = everything()) 


# Then export it out onto a website
ggsave("First_Webpage/the_table.jpg", plot = last_plot()) # This is getting corrupted? Have tried a few files but none seem to be working

