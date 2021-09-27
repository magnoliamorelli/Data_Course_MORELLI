library(tidyverse)

#I
covid_data <- read.csv("cleaned_covid_data.csv")

#II
A <- grepl("A", covid_data$Province_State)
A_states <- covid_data[A,]

#III
ggplot(A_states, aes(x=Last_Update, y=Active)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~Province_State, scales = "free")

#IV
state_max_fatality_rate <- covid_data %>% 
  filter(!is.na(Case_Fatality_Ratio)) %>% 
  group_by(Province_State) %>% 
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio)) %>% 
  arrange(desc(Maximum_Fatality_Ratio))

#V
ggplot(state_max_fatality_rate, aes(x=reorder(Province_State,-Maximum_Fatality_Ratio),y=Maximum_Fatality_Ratio)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x= "Region")
