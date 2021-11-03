library(tidyverse)
library(carData)
library(modelr)

MplsStops
MplsDemo

df <- full_join(MplsStops,MplsDemo) # Joining DataFrames

df$citationIssued %>% unique

df <- df %>% 
  mutate(CITATION = case_when(citationIssued == "YES" ~ TRUE,
                              TRUE ~ FALSE))

mod <- glm(data = df,
           formula = CITATION ~ poverty * gender * race,
           family = "binomial")
mod %>% summary

df %>% 
  add_predictions(mod,type = "response") %>% 
  ggplot(aes(x=poverty,y=pred,color=gender)) +
  geom_smooth() +
  facet_wrap(~race,scales = "free")


df$citationIssued %>% table()
df$vehicleSearch

df <- df %>% 
  mutate(SEARCH = case_when(vehicleSearch == "YES" ~ TRUE,
                              TRUE ~ FALSE))

mod <- glm(data = df,
           formula = SEARCH ~ poverty * gender * race,
           family = "binomial")
df %>% 
  add_predictions(mod,type = "response") %>% 
  ggplot(aes(x=poverty,y=pred,color=gender)) +
  geom_smooth() +
  facet_wrap(~race,scales = "free")
