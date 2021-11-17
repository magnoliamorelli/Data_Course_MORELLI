# Load Packages
library(tidyverse)
library(xml2)
library(rvest)
library(janitor)


# Read in webpage
countries <- read_html("https://www.worldometers.info/geography/alphabetical-list-of-countries/")
# A List of tables within webpage
tables <- countries %>% 
  html_table()
# Reading in the first table
the_table <- tables[[1]]


# Tidying
# Cleaning Names
colnames(the_table) <- make_clean_names(colnames(the_table))
# Removing commas and changing few columns to numeric
the_table$population_2020 <- as.numeric(gsub(",","",the_table$population_2020))
the_table$land_area_km2 <- as.numeric(gsub(",","",the_table$land_area_km2))
the_table$density_p_km2 <- as.numeric(gsub(",","",the_table$density_p_km2))
# Removing the first column
the_table <- subset(the_table, select = -c(number, land_area_km2, density_p_km2))
# change column names to be nicer
colnames(the_table) <- c("Country", "Population (2020)")
# check in janitor and clean country names
str_squish(the_table)


the_table[the_table$Country ==  "Congo (Congo-Brazzaville)",]["Country"] <- "Congo [DRC]"
the_table[the_table$Country ==  "Czechia (Czech Republic)",]["Country"] <- "Czech Republic"
the_table[the_table$Country ==  "Eswatini (fmr. \"Swaziland\")",]["Country"] <- "Swaziland"
the_table[the_table$Country ==  "Holy See",]["Country"] <- "Vatican City"
the_table[the_table$Country ==  "Myanmar (formerly Burma)",]["Country"] <- "Myanmar [Burma]"
the_table[the_table$Country ==  "North Macedonia",]["Country"] <- "Macedonia [FYROM]"
the_table[the_table$Country ==  "Palestine State",]["Country"] <- "Palestinian Territories"
the_table[the_table$Country ==  "Sao Tome and Principe",]["Country"] <- "São Tomé and Príncipe"
the_table[the_table$Country ==  "South Sudan",]["Country"] <- "Sudan"
the_table[the_table$Country ==  "United States of America",]["Country"] <- "United States"
the_table[the_table$Country ==  "Cabo Verde",]["Country"] <- "Cape Verde"
the_table[the_table$Country ==  "Democratic Republic of the Congo",]["Country"] <- "Congo [Republic]"

# Saving
saveRDS(the_table, "First_Webpage/the_table.RDS")

