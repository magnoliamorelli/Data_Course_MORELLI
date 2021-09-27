# Learning plots
# Building in Layers:
# 1. data
# 2. aesthetics: x,y,color,linetype,shape,alpha,size
# 3. geometry



library(tidyverse)

df <- read_csv("Data/landdata-states.csv")

?ggplot


ggplot(df,aes(y=Home.Value, x=Year, color=region)) + # aesthetics
  geom_point(size=0.01) + # type of plot, changing size of dot
  geom_smooth() + # adding trend line, can do method = "lm" it will be a straight line
  facet_wrap(~region) + # makes multiple graphs separated in categories
  theme_minimal() + # adding themes, downloading ggtheme package will give you more
  theme(strip.text = element_text(face = "bold", size = 25),
        axis.text.x = element_text(angle=60, hjust = 1, face = "bold")) + # you can make your own theme, can change anything about plot
  scale_colour_viridis_d() # changing color


# ggplot cheat sheet is super helpful, listed on class website assignment 4

# looking at na category
sum(df$region =="NA")
sum(is.na(df$region)) # how many rows have NA
df[is.na(df$region),] # looking at subset, find out that it is DC

# if you want to get rid of na
ggplot(df[df$State != "DC",], aes(y=Home.Value, x=Year, color=region))
# plus all the rest


# Which aesthetics can be used for which geoms? This code will give you a map
library(tidyverse)
env <- asNamespace("ggplot2")
all_Geoms <- ls(envir = env, pattern = "^Geom.+")
all_Geoms <- mget(all_Geoms, env)

all_aes <- map(all_Geoms, ~.$aesthetics())

# change Geom* to geom_*
names(all_aes) <- 
  names(all_aes) %>%
  substr(5,nchar(.)) %>%
  tolower() %>%
  paste0("geom_",.)

# remove if geom_* doesn't exist
all_aes[!names(all_aes) %in% ls(envir = env)] <- NULL

all_aes_long <- all_aes %>%
  enframe("fun", "aes") %>%
  unchop(aes)

all_aes_wide <- all_aes_long %>%
  mutate(val = 1) %>%
  spread(aes,val,fill = 0)

# convert to matrix and set row names
row.names(all_aes_wide) <- all_aes_wide$fun
mat <- all_aes_wide %>%
  select(-fun) %>% as.matrix()
row.names(mat) <- row.names(all_aes_wide)

all_aes_wide


# Homework Practice with Iris data set and week 4 homework
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color= Species)) +
  geom_point() +
  theme_minimal() +
  title(main = "Sepal VS Petal", xlab = "Sepal Length", ylab = "Petal Length") # this isn't working idk how to change names


# Pop Quiz
data("iris") # loading in iris data
df <- iris
df <- df[df$Species == "setosa",]
ggplot(df, aes(x=Petal.Width, y=Sepal.Width)) +
  geom_point() +
  geom_smooth(method = "lm")




# the pipe: %>% cntrl shift m
head(iris)
iris %>% head() # same command
iris %>% head() %>% tail(n=)


iris %>% 
  filter(Species == "setosa") %>% # can only use filter with data frames
  filter(Sepal.Length > 5) %>% # can add as many filters as you want
  ggplot(aes(x=Sepal.Width, y=Petal.Width)) +
  geom_point() +
  geom_smooth(method = "lm")


# filter(df, column test)
filter(iris, Species == "setosa")
filter(iris, Sepal.Length > 5)
filter(iris, Sepal.Length * Sepal.Width > 10)



iris %>% 
  filter(Species == "setosa") %>% 
  mutate(Sepal.Area = Sepal.Width * Sepal.Length) %>% # build new columns based on existing ones
ggplot(aes(x=Sepal.Width, y=Sepal.Area)) +
  geom_point() +
  geom_smooth()
   

View() # makes a pop up "excel" sheet


mysummaries <- iris %>% 
  # filter(Species == "setosa") %>%     by using cntrl shift c, it will turn code into comment
  mutate(Sepal.Area = Sepal.Width * Sepal.Length) %>%
  group_by(Species) %>% # all next things in summarise run it for every species
  summarise(MeanSepalLength = mean(Sepal.Length), # makes new column
            MeanPetalLength = mean(Petal.Length),
            NumberofObservations = n()) # n is only used in summarise usually


iris %>% 
  mutate(NewCol = case_when(Species == "setosa" ~ "Whatever",
                            TRUE ~ "Not Whatever")) %>% 
  group_by(Species,NewCol) %>% 
  summarise(MEANSEPLEN = mean(Sepal.Length)) # summarise is always after group_by



  