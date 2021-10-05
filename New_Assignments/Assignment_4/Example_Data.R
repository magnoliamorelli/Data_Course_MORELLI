library(tidyverse)

dat <- read.csv("Data.csv")
ggplot(dat, aes(x=Station, y=Spring)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 60))
