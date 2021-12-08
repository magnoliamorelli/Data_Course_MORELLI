# Load Packages
library(tidyverse)
library(xml2)
library(rvest)
library(janitor)

# Read in webpage
lat_long <- read_html("https://developers.google.com/public-data/docs/canonical/countries_csv")
# A List of tables within webpage
tables <- lat_long %>% 
  html_table()
# Reading in the first table
table2 <- tables[[1]]


# Tidying
colnames(table2) <- make_clean_names(colnames(table2))
table2 <- subset(table2, select = -c(country))
str_squish(table2)
colnames(table2) <- c("Latitude", "Longitude", "Country")
table2 <- table2 %>% 
  arrange(Country)

#####
# Saving
saveRDS(table2, "Second_Webpage/table2.RDS")
