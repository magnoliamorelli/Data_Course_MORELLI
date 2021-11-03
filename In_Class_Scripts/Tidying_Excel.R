library(tidyverse)
library(readxl)
library(janitor)
library(plotly)

# Tidying Data:
# every column = single variable (treatment type)
# every row = single observation (sample ID)

# Never change original data, always write code to change in R
# When doing dates in Excel use ``back tick first or 3 columns (year,month,day)

df <- read_xlsx("./Data/wide_data_example.xlsx")
colnames(df) <- make_clean_names(colnames(df)) #changes name to clean


df$treatment_1 %>% unique() # tells you if there is something unique ex: ? vs ??, might have to make 2 rules to clean
lapply(df,unique) # this does unique for each column
# doing that function that gives all plots, will help you pick out stuff that is wrong, maybe do that first when getting data?

df$treatment_1[df$treatment_1 == "?"] <- NA # changes ? to NA
df$treatment_1 <- as.numeric(df$treatment_1) # changes column to numeric



df %>% 
  pivot_longer(cols = c("treatment_1","treatment_2"), # making variables into one column
               names_to = "Treatment",
               values_to = "Brain_Activity") # changing column names
# OR

df_tidy <- df %>% 
  pivot_longer(starts_with("treatment"))






# More mutating


library(tidyverse)
library(palmerpenguins)

df <- penguins

p <- df %>% 
  mutate(body_mass_kg=round(body_mass_g/1000,0)) %>% 
  mutate(chonk = case_when(body_mass_g > 4500 ~ "chonky",
                           is.na(body_mass_g) ~ "NA",
                           TRUE ~ "Not Chonky")) %>%   # New column chonk, if this is >4500, it is chonky, if not it is not chonky
  select(body_mass_g,body_mass_kg,everything()) %>%   # reordering columns
  arrange(chonk,desc(body_mass_g)) %>% # arranging rows first by chonk then by body_mass_g
  ggplot(aes(x=chonk,y=body_mass_g,color=sex)) + geom_boxplot()
p + theme_minimal()

ggplotly(p) # plotly is good for interactive graphs







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




# look at prepare_data.R to help show how to bring in multiple files
