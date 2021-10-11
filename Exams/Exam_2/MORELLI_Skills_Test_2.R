library(tidyverse)
options(scipen = 999)

# Fig 1
dat <- read_csv("landdata-states.csv")
dat %>% 
  ggplot(aes(x=Year,y=Land.Value,color=region)) +
  geom_smooth() +
  labs(x="Year",
       y='Land Value (USD)',
       color="Region") 

ggsave("MORELLI_Fig_1.jpg", plot = last_plot())

# NA Region
list(dat$State[is.na(dat$region)])

# Tidying
dat <- read_csv("unicef-u5mr.csv")
dat_tidy <- dat %>% 
  pivot_longer(starts_with("U5MR"),
               names_to = "Year",
               values_to = "Mortality_Rate",
               names_prefix = "U5MR.",
               names_transform = list(Year=as.numeric))

# Fig 2
dat_tidy %>% 
  filter(!is.na(Mortality_Rate)) %>% 
  ggplot(aes(x=Year,y=Mortality_Rate,color=Continent)) +
  geom_point() +
  labs(y='MortalityRate',
       x="Year")

ggsave("MORELLI_Fig_2.jpg", plot = last_plot())

# Fig 3
dat_tidy %>% 
  group_by(Continent,Year) %>% 
  summarise(Mean_Mortality_Rate = mean(Mortality_Rate)) %>% 
  ggplot(aes(x=Year,y=Mean_Mortality_Rate,color=Continent))+
  geom_line() +
  labs(x="Year",
       y="Mean Mortality Rate (deaths per 1000 live births")

ggsave("MORELLI_Fig_3.jpg", plot = last_plot())
  

# Fig 4
dat_tidy <- dat_tidy %>% 
  mutate(prop_morality=dat_tidy$Mortality_Rate/1000) 
dat_tidy %>% 
  ggplot(aes(x=Year,y=prop_morality)) +
  geom_point(color="blue",alpha=.5,size=.90) +
  facet_wrap(~Region) +
  labs(x="Year", y="Morality Rate")

ggsave("MORELLI_Fig_4.jpg", plot = last_plot())


