# Load Packages
library(tidyverse)
library(xml2)
library(rvest)
library(janitor)

# Read in webpage
url <- read_html("https://www.farandwide.com/s/fascinating-facts-every-country-7c1f1a0efdf64979")


# Country Names
names <- url %>% html_elements("h2") %>% 
  html_text2() 

names <- data.frame(names) 
names <- names[-c(1), ] 
names <- data.frame(names)


names <- str_split(names, "\\. ") # this isnt working :((((((((( how do i get rid of numbers???
names <- data.frame(names)
names <- names[-c(1),]
names <- data.frame(names)


goodones <- which(names$names %in% Full$Country) # ask Geoff about how to do this and then change names in names NOT full
Full[-goodones,]

# Reads in Facts/Populations/Some other stuff?
facts <- url %>% html_elements("p") %>% 
  html_text2()
facts <- data.frame(facts)

# remove every column that has the word population in it??


# Reading in full dataset
Full <- readRDS("Second_Webpage/full.RDS")


str_split(names, "\\. ") %>% 
  lengths() %>% 
  unique()
