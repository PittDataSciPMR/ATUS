
library(sjlabelled)
library(data.table)
library(magrittr)
library(Hmisc)
library(stringr)
library(ggplot2)
library(tidyverse)
library(devtools)
library(lubridate)
library(naniar)
library(readr)
library(survey)
library(haven)

# create function to make easy to read tables

fnx = function(x){print(formatC(x, format="fg", big.mark=","), quote=F)}

atusactcpsresp19 <- read_sav("C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/atusactcpsresp19.sav")

#load dataset

atus <-   as_tibble(rename_all(atusactcpsresp19, tolower))

# pull min and max values

fnx(sapply(atus, max))

fnx(sapply(atus, min))

# replace null values
                    
atus <- as_tibble(atus %>% replace_with_na(replace = list(prdisflg = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(peafever = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(peafnow = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(peafwhn1 = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(peafwhn1 = c(-3, -2, -1))))

atus <- as_tibble(atus %>% replace_with_na(replace = list(peafwhn2 = c(-3, -2, -1)))) 
                  
atus <- as_tibble(atus %>% replace_with_na(replace = list(peafwhn3 = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(peafwhn4 = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(pecyc = c(-3, -2, -1))))

atus <- as_tibble(atus %>% replace_with_na(replace = list(pedisdrs = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(pedisear = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(pediseye = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(pedisout = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(pedisphy = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(pedisrem = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(peeduca = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(prdasian = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(pudis = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(pudis1 = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(pudis2 = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(tewhere= c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(tudis = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(tudis1 = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(tudis2 = c(-3, -2, -1)))) 

atus <- as_tibble(atus %>% replace_with_na(replace = list(tuecytd = c(-3, -2, -1)))) 
