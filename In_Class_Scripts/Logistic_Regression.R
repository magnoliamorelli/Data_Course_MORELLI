# Logistic Regression
# yes or no questions, logical answers

# Packages
library(tidyverse)
library(modelr)
library(easystats)


df <- read_csv("./Data/GradSchool_Admissions.csv")

df$admit <- as.logical(df$admit)

df %>% 
  ggplot(aes(x=gpa,y=admit,color=rank)) +
  geom_point() +
  geom_smooth()


df %>% 
  ggplot(aes(x=gpa,fill=admit)) +
  geom_density(alpha=.5)


mod <- glm(data = df,
           formula = admit ~ gpa + rank,
           family = "binomial") # tells function that we are using binary outcome

summary(mod) # estimate no longer matters when looking at yes/no questions
performance(mod)

add_predictions(df,mod,type = "response") %>% # this changes it from logodds to a probability, first 28% of getting in
  ggplot(aes(x=gpa,y=pred,color=factor(rank))) +
  geom_smooth()


mod2 <- glm(data = df,
              formula = admit ~ gpa * rank,
              family = "binomial")
summary(mod2) # no value is significant, because it is too best fit (over fit)

gather_predictions(df,mod,mod2,type = "response") %>% 
ggplot(aes(x=gpa,y=pred,color=factor(rank))) +
  geom_smooth() +
  facet_wrap(~model)



mod3 <- glm(data = df,
            formula = admit ~ gpa + rank + gre,
            family = "binomial")
summary(mod3) 

gather_predictions(df,mod,mod2,mod3,type = "response") %>% 
  ggplot(aes(x=gpa,y=pred,color=factor(rank))) +
  geom_smooth() +
  facet_wrap(~model)




gather_predictions(df,mod,mod2,type = "response") %>% 
  ggplot(aes(x=gre,y=pred,color=gpa)) +
  geom_point() +
  facet_wrap(~rank) +
  scale_color_viridis_c()


library(carData)  

MplsStops %>% glimpse
MplsDemo  


df <- MplsStops %>% 
  mutate(suspicious = case_when(problem == "suspicious" ~ TRUE,
                             TRUE ~ FALSE))
mod1 <- glm(data = df,
            formula = suspicious ~ race,
            family = "binomial")

add_predictions(df,mod1,type="response") %>% 
  ggplot(aes(x=race,y=pred)) +
  geom_point(size=5)


ggplot(df,aes(x=lat,y=long,color=race)) +
  geom_density_2d()


