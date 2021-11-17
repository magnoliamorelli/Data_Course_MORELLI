# Load Packages
library(tidyverse)
library(xml2)
library(rvest)
library(janitor)

# Read in webpage
url <- read_html("https://www.farandwide.com/s/fascinating-facts-every-country-7c1f1a0efdf64979")

# Reading in full dataset
Full <- readRDS("Second_Webpage/full.RDS")

# Country Names
names <- url %>% html_elements("h2") %>% 
  html_text2() 

names <- data.frame(names) 
names <- names[-c(1), ] 
names <- data.frame(names)


names <- names$names %>% 
  str_split("\\. ") %>% 
  map_chr(2) # pulls out second item from string split list
names <- data.frame(names)
names <- names %>% 
  arrange(names)


# checking
goodones <- which(Full$Country %in% names$names) 
Full[-goodones,]$Country
badones <- which(names$names %in% Full$Country)
names[-badones,]

# changing
names[names$names ==  "The Bahamas",] <- "Bahamas"
names[names$names ==  "Democratic Republic of the Congo",] <- "Congo [DRC]"
names[names$names ==  "The Gambia",] <- "Gambia"
names[names$names ==  "North Macedonia",] <- "Macedonia [FYROM]"
names[names$names ==  "Sao Tome and Principe",] <- "São Tomé and Príncipe"
names[names$names ==  "Ivory Coast",] <- "Côte d'Ivoire"
names[names$names ==  "Republic of the Congo",] <- "Congo [Republic]"
names[names$names ==  "Holy See",] <- "Vatican City"
names[names$names ==  "Palestine",] <- "Palestinian Territories"
names[names$names ==  "East Timor",] <- "Timor-Leste"
names[names$names ==  "Cabo Verde",] <- "Cape Verde"
names[names$names ==  "Eswatini",] <- "Swaziland"
names[names$names ==  "Myanmar",] <- "Myanmar [Burma]"
names[names$names ==  "Saint Vincent and Grenadines",] <- "Saint Vincent and the Grenadines"

# Checking again
goodones <- which(Full$Country %in% names$names) 
Full[-goodones,]$Country
badones <- which(names$names %in% Full$Country)
names[-badones,]


# Reads in Facts/Populations/Some other stuff?
facts <- url %>% html_elements("p") %>% 
  html_text2()
facts <- data.frame(facts)

# remove every column that has the word population in it??





# for this can do a button that gives you a random fact about a country??

