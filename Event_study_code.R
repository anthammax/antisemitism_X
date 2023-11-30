# Regression Twitter/X - DiD with Event Study

#Basic import
install.packages("CRAN")
install.packages("fixest")
install.packages("tidyverse")
library(fixest)## NB: Requires version >=0.9.0
library(tidyverse)
library(fixest)
library(broom)
library(texreg)

#https://lost-stats.github.io/Model_Estimation/Research_Design/event_study.html

# IMPORT
data_es <- read_csv("/Users/anthony/Downloads/Event_study.csv")
head(data_es, 4)

# EVENT STUDY
mod_twfe_1 = feols(nb_tweet ~ i(time_to_treat_1, antisemitic, ref = -1)|date,         
                 data =data_es)
mod_twfe_2 = feols(nb_tweet ~ i(time_to_treat_2, antisemitic, ref = 0)|date,         
                   data =data_es)
mod_twfe_3 = feols(nb_tweet ~ i(time_to_treat_3, antisemitic, ref = -1)|date,         
                   data =data_es)
mod_twfe_4 = feols(nb_tweet ~ i(time_to_treat_4, antisemitic)|date,         
                   data =data_es)
mod_twfe_5 = feols(nb_tweet ~ i(time_to_treat_5, antisemitic, ref = -1)|date,         
                   data =data_es)

# RESULTS, TABULAR SUMMARY
screenreg(list(mod_twfe_1, mod_twfe_2, mod_twfe_3, mod_twfe_4, mod_twfe_5), 
          custom.model.names = c("2022-10-27", "2022-11-18", "2022-12-12", "2023-04-17", "2023-07-12"))


# PLOTTING THE RESULTS
iplot(mod_twfe_1, 
      xlab = 'Time to treatment',
      main = 'Event study: Musk acquisition 2022-10-27')
iplot(mod_twfe_2, 
      xlab = 'Time to treatment',
      main = 'Event study: Freedom of speech, not reach - Episode 1 - 2022-11-18')
iplot(mod_twfe_3, 
      xlab = 'Time to treatment',
      main = 'Event study: Dissolution Trust and Safety Council - 2022-12-12')
iplot(mod_twfe_4, 
      xlab = 'Time to treatment',
      main = 'Event study: Freedom of speech, not reach - Episode 2 - 2023-04-17')
iplot(mod_twfe_5, 
      xlab = 'Time to treatment',
      main = 'Event study: Freedom of speech, not reach - Episode 3 - 2023-07-12')





