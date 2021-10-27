library(data.table)
library(devtools)
library(ggplot2)
library(haven)
library(Hmisc)
library(janitor)
library(lubridate)
library(magrittr)
library(naniar)
library(psych)
library(readr)
library(RM.weights)
library(sjlabelled)
library(stringr)
library(survey)
library(tidyverse)


# create dataset activity file
atusact_2019 <- read_sav("C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/Extracted files/2019/atusact_2019.sav")
# Tidy names

atusact19 <-   as_tibble(rename_all(atusact_2019, tolower))

atusact19 <- select(atusact19, c('tucaseid', 'tuactivity_n', 'tewhere', 'tuactdur', 'tuactdur24', 'tucumdur', 'tucumdur24',
                                    'tustarttim', 'tustoptime', 'tutier1code', 'tutier2code', 'tutier2code', 'trcode',
                                    'trtier2'))
atusact19 <- tibble(as_numeric(atusact19, 1:7, 10:13))
atusact19$tustarttim <- times(atusact19$'tustarttim')
atusact19$tustoptime <- times(atusact19$'tustoptime')
atusact19 <- unique(atusact19, by='tucaseid')
sum(duplicated(atusact19$tucaseid))
# order alphabetically
atusact19 <- atusact19 %>% select(order(colnames(atusact19)))

#create dataset current population survey

atuscps_2019 <- read_sav("C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/Extracted files/2019/atuscps_2019.sav")

atuscps19 <-   as_tibble(rename_all(atuscps_2019, tolower))

atuscps19 <- select(atuscps19, c('tucaseid', 'tulineno', 'hefaminc', 'hrhhid', 'hrhhid2', 45:50, 
                                    'pecyc', 55:60, 'peeduca', 'pehspnon', 'pesex', 'prdisflg', 'prtage', 
                                    'ptdtrace', 205:207, 'pulineno', 'qstnum', 'prdasian'))

atuscps19 <- tibble(as_numeric(atuscps19))
sum(duplicated(atuscps19$tucaseid))
# filter to only disabled cases
atuscps19 <- tibble(filter(atuscps19, prdisflg == 1 ))

 atuscps19 <- atuscps19[!duplicated(atuscps19$tucaseid), ]

 
# create dataset respondent

# This file contains case-specific variables collected in ATUS (that is, variables for which 
# there is one value for each respondent). These include, for example, labor force and earnings information, 
# total time providing secondary childcare, total time providing eldercare, and ATUS statistical weights.

atusresp_2019 <- read_sav("C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/Extracted files/2019/atusresp_2019.sav")

atusresp19 <-   as_tibble(rename_all(atusresp_2019, tolower))

atusresp19 <- select(atusresp19, 102, 'tulineno', 93:96, 'telfs', 'trtalone', 'trtalone_wk', 'tucaseid')

atusresp19 <- tibble(as_numeric(atusresp19))
atusresp19 <- unique(atusresp19, by='tucaseid')
sum(duplicated(atusresp19$tucaseid))

# Combine

atustrans19 <- merge(x=atusact19, y=atuscps19, by.x="tucaseid", by.y ="tucaseid")
atusrespcps19<- atusrespcps19 %>% select(order(colnames(atusrespcps19)))
# remove duplicate col
atusrespcps19 <- atusrespcps19 %>% select(-tulineno.x)

atusactcps19 <- merge(x=atusact19, y=atuscps19, by.x = "tucaseid", by.y="tucaseid", all.x= TRUE)

atusactcpsresp19 <- merge(x=atusresp19, y=atusactcps19, by.x = "tucaseid", by.y="tucaseid", all.x =TRUE)

atus19 <- as_tibble(atusactcpsresp19)

# order alphabetically
atus19.1 <- atus19 %>% select(order(colnames(atus19)))
# remove duplicate col
atus19.1 <- atus19.1 %>% select(-tulineno.x)

# and duplicate rows (there shouldn't be any)
atus19.2 <- unique(atus19.1, by='tucaseid')

atuscps191 <- unique(atuscps19, by='tucaseid')
