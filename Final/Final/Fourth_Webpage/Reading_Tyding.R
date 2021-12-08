# Load Packages
library(tidyverse)
library(xml2)
library(rvest)
library(XML)

options(scipen = 999)

# Read in webpage
webpage <- read_html("https://worldpopulationreview.com/country-rankings/most-visited-countries")
# A List of tables within webpage
tables <- webpage %>% 
  html_table()
# Reading in the first table
df <- tables[[1]]

# Cleaning
df$`International Tourist Arrivals` <- as.numeric(gsub(",","",df$`International Tourist Arrivals`))


# Adding Facts

att <- read_csv("Fourth_Webpage/attractions.csv")


# Combining

l <- list(df,att)
full <- reduce(l, left_join)

saveRDS(full,"Fourth_Webpage/full.csv")

