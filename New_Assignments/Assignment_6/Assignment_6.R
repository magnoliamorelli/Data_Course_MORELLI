library(tidyverse)
library(janitor)
library(gganimate)


# I literally almost threw my laptop out of a 4th floor window because of this assignment

dat <- read.csv("BioLog_Plate_Data.csv")
colnames(dat) <- make_clean_names(colnames(dat))

dat <- dat %>% 
  pivot_longer(cols = c("hr_24","hr_48","hr_144"),
               values_to = "absorbance",
               names_to = "time",
               names_prefix = "hr_")

envi_type <- dat %>% 
  mutate(type = case_when(sample_id == "Clear_Creek" ~ "water",
                          sample_id == "Waste_Water" ~ "water",
                           is.na(sample_id) ~ "NA",
                           TRUE ~ "soil"))



# Plot 1

dil_mod <- envi_type[envi_type$dilution == 0.1,]
dil_mod %>% 
  ggplot(aes(x=as.numeric(time),y=absorbance,color=type)) +
  geom_smooth(se=F) +
  facet_wrap(~substrate) +
  labs(subtitle = "Just dilution 0.1",
       x="Time",
       y="Absorbance") +
  labs(color="Type") +
  theme_minimal()


# Plot 2
# This is about where I almost died
# I could not figure out gganimate. I spent maybe 5 hours on it
# This is all I got 

sub <- dat[dat$substrate == "Itaconic Acid",]
sub %>%
  ggplot(aes(x=as.numeric(time),y=absorbance,color=sample_id)) +
  geom_smooth(method = "lm", se=F) +
  facet_wrap(~dilution) +
  labs(subtitle = "Itaconic Acid",
       x="Time",
       y="Mean_absorbance") +
  labs(color="Sample ID") +
  theme_minimal() 

