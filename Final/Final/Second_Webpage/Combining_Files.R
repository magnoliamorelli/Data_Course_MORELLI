# Load Packages
library(tidyverse)
library(xml2)
library(rvest)
library(sp)


# Reading in
the_table <- readRDS("First_Webpage/the_table.RDS")
table2 <- readRDS("Second_Webpage/table2.RDS")

# Seeing if have differences
goodones <- which(the_table$Country %in% table2$Country)
the_table[-goodones,]


# Combining
l <- list(the_table,table2)
full <- reduce(l, left_join)

# Saving
saveRDS(full, "Second_Webpage/full.RDS")
