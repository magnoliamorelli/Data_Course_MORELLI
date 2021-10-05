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

  