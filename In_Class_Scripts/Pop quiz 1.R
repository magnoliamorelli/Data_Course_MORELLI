# Pop Quiz: load certain file and show me just rows 1,3,5

library(tidyverse)
df <- read_csv("./Data/landdata-states.csv")
df[c(1,3,5),]

# df = object (our data frame)
# [] = accessing elements of an object    [row, column]
# c(1,3,5) = concatenate only rows 1,3, and 5

# another way to do it
df <- read_csv("./Data/landdata-states.csv")
rows <- c(1,3,5)
df[rows,]

# every column in a data frame is a vector

# only Alaska
df <- read_csv("./Data/landdata-states.csv")
AK_only <- df$State == "AK"
df[AK_only,]

# Or
df[df$State == "AK",]

# making a new column
df$Total_value <- df$Home.Value + df$Land.Value

# If you mess up the data frame too badly you can just rerun the reading path and it will go back
# R is not editing the file, it is editing R's memory of the file




