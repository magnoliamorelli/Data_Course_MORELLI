# do this at home

library(tidyverse)
library(readxl)
library(janitor)




df <- read_csv("./Data/Bird_Measurements.csv")
glimpse(df)
names(df) <- make_clean_names(names(df))

males <- df %>% 
  select( "family","species_number","species_name","english_name","m_mass","m_mass_n",starts_with("m_"),
          clutch_size,egg_mass,mating_system)

females <- df %>% 
  select( "family","species_number","species_name","english_name","m_mass","m_mass_n",starts_with("f_"),
          clutch_size,egg_mass,mating_system)

unsexed <- df %>% 
  select( "family","species_number","species_name","english_name","m_mass","m_mass_n",starts_with("unsexed_"),
          clutch_size,egg_mass,mating_system)


males %>% 
  pivot_longer(cols = c("m_mass","m_wing","m_tarsus","m_tail","m_bill"),
               names_to = "measurement_type",
               values_to = "value", names_prefix = "m_") %>% 
  select(-ends_with("_n")) %>% 
  mutate(sex = "male")

females %>% 
  pivot_longer(cols = c("f_mass","f_wing","f_tarsus","f_tail","f_bill"),
               names_to = "measurement_type",
               values_to = "value", names_prefix = "f_") %>% 
  select(-ends_with("_n")) %>% 
  mutate(sex = "female")

unsexed %>% 
  pivot_longer(cols = c("unsexed_mass","unsexed_wing","unsexed_tarsus","unsexed_tail","unsexed_bill"),
               names_to = "measurement_type",
               values_to = "value", names_prefix = "unsexed_") %>% 
  select(-ends_with("_n")) %>% 
  mutate(sex = "unsexed")


# combine all 3 sexes


#this should work but since typing fast, its not working
full <- rbind(males,females,unsexed)
write_csv(full, ".") # this save new csv, "" are where you put pathway


full %>% 
  ggplot(aes(x=sex, y=value)) +
  geom_col() +
  facet_wrap(~measurement_type,scales = "free")

ggsave("", width = 20, height = 10, dip = 100) # this will save plots, can change dimensions or into pdf, png etc







