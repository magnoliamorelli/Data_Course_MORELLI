# First tidy data

library(tidyverse)

male <- rnorm(100,3,.5) # 100 values from normal distribution bell curve, with mean of 3, standard deviation of .5
female <- rnorm(100,3.1,.5)



df <- data.frame(male,female)
df <- df %>% 
  pivot_longer(everything(), names_to = "sex", values_to = "gpa")


df$major <- c(rep("science",100),rep("art",100)) # adding new column for major

df %>% 
  group_by(sex) %>% 
  summarise(MeanGPA = mean(gpa)) %>% 
  ggplot(aes(x=sex,y=MeanGPA)) +
  geom_col()


df %>% 
  ggplot(aes(x=sex,y=gpa)) +
  geom_bar(stat = "identity")

plot(male)
hist(male)


# finding statistical significance to data, modeling, removing brain patterns

?t.test()

t.test(male,female) # if p value < 0.05 the more likely to have statistical significance, they are likely related
# smaller the p value the more you can be confident that the pattern you are seeing is real

# is sex affecting gpa significantly
mod <- glm(formula = gpa ~ sex + major,
    data = df)
summary(mod)

# under coefficients you will see average gpa, if you are male you will be below, as well as science (estimate std)


# analysis of varience
mod.aov <- aov(formula = gpa ~ sex + major,
               data = df)
summary(mod.aov)

# testing null hypothesis that sex and major have no significance
# p value will see if to reject this or not




iris %>% 
  
data("iris")
glm(data = iris,
    formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width + Species) %>% 
  summary()





# More modeling

library(tidyverse)
library(modelr)
theme_set(theme_minimal())

# do taller people earn more money?
modelr::heights

p <- heights %>% 
  ggplot(aes(x=height,y=income)) +
  geom_point()

p + geom_smooth() # idunno, not conclusive

# maybe other factors are important...
p + geom_smooth(aes(color=sex))
p + geom_smooth(aes(colors=marital))
heights %>% 
  ggplot(aes(x=education,y=income,color=sex)) +
  geom_point() + geom_smooth()

# okay, now build at least two models of income and compare them with rmse
