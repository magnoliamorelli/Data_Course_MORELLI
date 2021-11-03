install.packages("easystats", repos = "https://easystats.r-universe.dev")
library(easystats)
library(tidyverse)
library(modelr)

mpg %>% glimpse()


mod1 <- glm(data = mpg,
    formula = hwy ~ manufacturer + displ) # manufactur and displ will be predicting hwy
summary(mod1)

mod2 <- glm(data = mpg,
            formula = hwy ~ manufacturer * displ) # interaction between displ and manufacturer
summary(mod2)


mpg %>% 
  gather_predictions(mod1,mod2) %>% 
  ggplot(aes(x = displ,y = pred,color=manufacturer)) +
  geom_smooth(method = "lm", se=FALSE) +
  facet_wrap(~model)


anova(mod1,mod2)

model_performance(mod1)
model_performance(mod2)

# RMSE how far on average are the real point from the predicted points
# R2 measure of the percent of variation explained by the variables in the model, how much better
# is our model at predicting values than the mean is


report(mod1) # this puts model into English words of what you did


# this is how you export this file
sink("FILE PATH")
report()
sink(NULL)



library(broom)
df <- tidy(mod1) # saves summaries as data.frame

df %>% 
  filter(p.value < 0.05) %>% 
  mutate(term = str_remove_all(term, "manufacturer"))

mod3 <- glm(data = mpg,
            formula = hwy ~ cyl * model)
summary(mod3)

model_performance(mod3)

mpg %>% 
  gather_predictions(mod3) %>% 
  ggplot(aes(x = hwy,y = pred,color=manufacturer)) +
  geom_smooth(method = "lm", se=FALSE) +
  facet_wrap(~model)


mod4 <- glm(data = mpg,
            formula = hwy~displ*(trans+drv))
performance(mod4)



mod5 <- glm(data = mpg,
            formula = hwy~displ*manufacturer*year*cyl*trans)
performance(mod5)
tidy(mod5)


library(MASS)


step <- stepAIC(mod5)

step$formula


mod6 <- glm(data = mpg,
            formula = step$formula)

mpg %>% 
  gather_predictions(mod1,mod2,mod3,mod4,mod5,mod6) %>% 
  ggplot(aes(x = displ,y = pred,color=drv)) +
  geom_smooth(method = "lm", se=FALSE) +
  facet_wrap(~model)

model_performance(mod5)
model_performance(mod6)
