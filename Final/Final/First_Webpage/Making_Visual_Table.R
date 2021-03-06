# Load Packages
library(tidyverse)
library(kableExtra)

df <- readRDS("First_Webpage/the_table.RDS")


pop <- kbl(df) %>%
  kable_styling(bootstrap_options = "striped", full_width = F, position = "left") %>%
  scroll_box(height = "300px") %>% 
  kable_paper("hover", full_width=F) %>% 
  save_kable("First_Webpage/table.html")



#####
# this is using package gt and makes for a very large image, use KableExtra
# Making table
mytable <- the_table %>% gt() %>% 
  tab_header(
    title = "World Countries and Populations",
    subtitle = "Listed Alphabetically"
  ) %>% 
  tab_source_note("Data Source: https://www.worldometers.info/geography/alphabetical-list-of-countries/") %>% 
  cols_align(align = "left", columns = everything()) 



#####