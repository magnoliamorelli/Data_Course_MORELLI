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
