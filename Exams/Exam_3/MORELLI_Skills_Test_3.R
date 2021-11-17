library(tidyverse)
library(janitor)
library(broom)

# I
df <- read_csv("FacultySalaries_1995.csv")
colnames(df) <- make_clean_names(colnames(df))

df <- df %>% 
  pivot_longer(cols = c(avg_assist_prof_salary, avg_assoc_prof_salary, avg_full_prof_salary), 
               names_to = "rank",
               values_to = "avg_salary")

df[df$tier ==  "VIIB",]["tier"] <- "IIB"
df[df$rank ==  "avg_assist_prof_salary",]["rank"] <- "Assist"
df[df$rank ==  "avg_assoc_prof_salary",]["rank"] <- "Assoc"
df[df$rank ==  "avg_full_prof_salary",]["rank"] <- "Full"

df %>% 
  ggplot(aes(x=rank, y=avg_salary, fill=rank)) +
  geom_boxplot() +
  facet_wrap(~ tier) +
  theme(axis.text.x = element_text(angle=60, hjust = 1)) +
  labs(x="Rank",
       y="Salary",
       color="Rank")

ggsave("MORELLI_Fig_1.jpg", plot = last_plot())
  

# II
anova <- aov(formula = avg_salary ~ state + tier + rank, data = df)
summary(anova)

anova <- tidy(anova)
write.table(anova, "Salary_ANOVA_Summary.txt",sep = "\t",row.names = FALSE)


# III
df <- read_csv("Juniper_Oils.csv")


df <- df %>% 
  pivot_longer(cols = c("alpha-pinene","para-cymene","alpha-terpineol","cedr-9-ene","alpha-cedrene","beta-cedrene","cis-thujopsene","alpha-himachalene","beta-chamigrene","cuparene","compound 1","alpha-chamigrene","widdrol","cedrol","beta-acorenol","alpha-acorenol","gamma-eudesmol","beta-eudesmol","alpha-eudesmol","cedr-8-en-13-ol","cedr-8-en-15-ol","compound 2","thujopsenal"), 
               names_to = "chemical",
               values_to = "Concentration")

# IV
df %>% 
  ggplot(aes(x=YearsSinceBurn,y=Concentration)) +
  geom_smooth() +
  facet_wrap(~chemical,scales = "free")

# V
# for some reason my glm isn't working but this is how I'd do it
mod <- df %>% 
  glm(formula = chemical ~ YearsSinceBurn*Concentration) 

sig_values <- tidy(mod) %>% 
  filter(p.value < 0.05)

