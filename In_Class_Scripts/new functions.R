library(tidyverse)

list.files(full.names = TRUE, path = "./Data")
wingspan <- read_csv("./Data/wingspan_vs_mass.csv")


wingspan[1,1]
wingspan[1,]
wingspan[,1]
wingspan$variety[1:10]

wingspan[1:10,]

wingspan$variety == "African"
fastbirds <- wingspan$velocity > 20

wingspan[fastbirds,]

fastbirds <- filter(wingspan, velocity > 20 & variety == "African" & wingspan < 30)
filter(fastbirds, variety == "African")
filter(wingspan, variety == "African")


wingspan %>%
  ggplot(aes(x=wingspan, y=velocity, color=variety)) +
  geom_point()

sum(fastbirds)


