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



library(tidyverse)

install.packages('patchwork')
library(patchwork)


df1 <- read_csv("./Data/practice_data_1.csv")
df2 <- read_csv("./Data/practice_data_2.csv")
df3 <- read_csv("./Data/practice_data_3.csv")

glimpse(df1)

df1 %>% 
  ggplot(aes(x=x, y=y, color=z)) +
  geom_point()

glimpse(df2)

df2 %>% 
  ggplot(aes(x=x, y=y, color=group)) +
  geom_point() +
  geom_smooth(method = "lm")

view(df3)

summary_of_df3 <- df3 %>% 
  group_by(dataset) %>% 
  summarise(N=n(),
            Mean_X = mean(x),
            Mean_Y = mean(y),
            StdDev_X = sd(x),
            StdDev_Y = sd(y),
            Med_X = median(x),
            Med_Y = median(y),
            Correlation_btwn_x_y = cor(x,y))

df3 %>% 
  ggplot(aes(x=x, y=y, color=dataset)) +
  geom_point() + # ~ means "as a function of"
  facet_wrap(~dataset)







library(palmerpenguins)


df <- penguins

glimpse(df) 



df %>% 
  filter(!is.na(sex)) %>% # only command that removes NA data
  ggplot(aes(x=sex, y=body_mass_g, fill=sex)) +
  geom_boxplot() +
  facet_wrap(~island*species)


df %>% 
  mutate(product=bill_length_mm*bill_depth_mm) %>% 
  ggplot(aes(x=product, y=body_mass_g, color=species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~island)


p1 <- df %>% 
  ggplot(aes(x=bill_length_mm, fill=species)) +
  geom_density(alpha=.5) # similar to geom_histogram, alpha is transparency


p2 <- df %>% 
  ggplot(aes(x=bill_depth_mm, fill=species)) +
  geom_density(alpha=.5)

p1+p2
p1/p2



library(GGally)
ggpairs(df) # all relationships of every variable in your data with every other variable


df %>% 
  select(species,bill_length_mm,island) %>% 
  ggpairs()


df %>% 
  ggplot(aes(x=flipper_length_mm, y=body_mass_g, color=species,shape=sex)) +
  geom_point()+
  geom_smooth() +
  theme()



colors() # colors built into r

#homework: mess with penguin data to make different plots

library(ggimage)

img <- "~/Images/" # path to image you want

ggplot(penguins,aes(x=bill_depth_mm, y=body_mass_g)) +
  geom_image(image=img) # this will have all points the image

# or

ggplot(penguins,aes(x=bill_depth_mm,y=body_mass_g)) +
  # geom_point +
  geom_image(image="https://i.pinimg.com/originals/0b/50/9c/0b509c2ec9bfd01739f80da4d803558a.jpg")





df %>% 
  ggplot(aes(x=body_mass_g,y=bill_length_mm,color=species)) +
  geom_point(alpha=.5) +
  geom_smooth(method = "lm",se=FALSE) +
  theme_minimal() +
  labs(x="Body mass (g)",
       y="Bill length (mm)",
       titles="My fancy plot!",
       subtitle= "this plot sucks",
       caption="Data from palmerpenguins R package",
       color="Penguin\nspecies") +
  theme(plot.caption = element_text(size = 6), 
        plot.title = element_text(hjust=1,color = "red", face = "bold.italic"),
        axis.text.x = element_text(angle=60,hjust = 1),
        plot.background = element_rect(fill = "blue", color = "wheat3",size = 5,linetype = 2),
        legend.text = element_text(angle = 190))


theme_set() # sets any plot you make in r session for what you set in this

theme_set(theme_classic()) # will make it go back to normal


library(ggmap)




  