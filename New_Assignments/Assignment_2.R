# load packages
library(tidyverse)

#4 write a command that lists all .csv files and store as "csv_files"
csv_files <- list.files(path = "Data",pattern = "*.csv", full.names = TRUE)

#5 find number of files using length()
length(csv_files)

#6 safe wingspan_vs_mass as "df"
df <- read.csv("./Data/wingspan_vs_mass.csv")

#7 read first 5 lines
head(df,n=5)

#8 find any files that begin with the letter "b"
list.files(path = "Data", pattern ="^b", recursive = TRUE )


# I couldn't quite figure out the for-loops for 9 and 10 but this was my best shot
#9 display first line of "b" files
b <- list.files(path = "Data", pattern = "^b", recursive = TRUE, full.names = TRUE)
for (i in 1:5) {
  b <- read_csv(file = b[i])
  print(head(b,1))
}

#10 display first line of all files that end in ".csv"
for (i in csv_files) {
  dat <- read.csv(i)
  print(head(dat))
  
}
