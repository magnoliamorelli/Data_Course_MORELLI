library(tidyverse)
library(janitor)
library(gganimate)


# I literally almost threw my laptop out of a 4th floor window because of this assignment

dat <- read.csv("BioLog_Plate_Data.csv")
colnames(dat) <- make_clean_names(colnames(dat))

dat <- dat %>% 
  pivot_longer(cols = c("hr_24","hr_48","hr_144"),
               values_to = "absorbance",
               names_to = "time",
               names_prefix = "hr_",
               names_transform = list(time=as.numeric))
dat <- dat %>% 
  filter(dat$dilution == 0.1) %>% 
  mutate(type = case_when(sample_id == "Clear_Creek" ~ "water",
                          sample_id == "Waste_Water" ~ "water",
                          is.na(sample_id) ~ "NA",
                          TRUE ~ "soil")) 
# Plot 1

dat %>% 
  ggplot(aes(x=time,y=absorbance,color=type)) +
  geom_smooth(se=F) +
  facet_wrap(~substrate) +
  labs(subtitle = "Just dilution 0.1",
       x="Time",
       y="Absorbance") +
  labs(color="Type") +
  theme_minimal()


# Plot 2
# This is about where I almost died
# I could not figure out gganimate. I spent maybe 5 hours on it
# This is all I got 

p <- dat %>% 
  filter(substrate == "Itaconic Acid") %>% 
  group_by(dilution,sample_id,time) %>% 
  summarise(Mean_Absorbance = mean(absorbance),
            N = n()) %>% # this tells you how many replicates are in each grouping to get answer
  ggplot(aes(x=time,y=Mean_Absorbance, color=sample_id)) +
  geom_line() +
  facet_wrap(~dilution) +
  theme_minimal()

p + transition_reveal(time)




# In class modeling, Model Tween 80 ####


dat %>% 
  filter(dilution == 0.1) %>% 
  filter(substrate == "Tween 80 ") %>% 
  ggplot(aes(x=sqrt(absorbance))) +
  geom_density()

dat %>% 
  filter(dilution == 0.1) %>% 
  filter(substrate == "Tween 80 ") %>% 
glm(data=.,
    formula = absorbance ~ type * time) %>% # if + it is type and time if * it will be type over time
  summary()

# go to simple_regression in inclassscripts for more help


