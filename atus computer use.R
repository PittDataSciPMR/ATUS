library(RM.weights)
library(psych)
library(lubridate)
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
library(expss)
library(spatstat)

# trcodes - activity file
# 02 Household Activities
  # 09 Household Management
    # 04 HH & personal e-mail and messages
# 12 Socializing, Relaxing, and Leisure
  # 03 Relaxing and Leisure
    # 08 Computer use for leisure (excluding games)
# 15 Volunteer Activities
  # 01 Administrative & Support Activities
    # 01 Computer use


# table
atus19_cu <- tibble(filter(atus19.2, trcode == 020904 | trcode == 120308 | trcode == 150101))

# sum of all pc use and create cols
atus19_cu <- aggregate(atus19_cu$tuactdur24, list(atus19_cu$tucaseid), sum)

# rename cols
atus19_cu <- rename(atus19_cu, tucaseid = Group.1, pcuse = x)

# replace nulls
atus19_cu <- as_tibble(atus19_cu %>% replace_with_na(replace = list(pcuse = c(-3, -2, -1))))

atus19_cu <- unique(atus19_cu)

# filter greater than 0
atus19_cu <- tibble(filter(atus19_cu, pcuse > 0))

# add to big table
atus19.3 <- merge(x=atus19.2, y=atus19_cu, by.x = "tucaseid", by.y="tucaseid", all.x =TRUE)

#send back to little table
atus19_cu <- tibble(filter(atus19.3, trcode == 020904 | trcode == 120308 | trcode == 150101))

# weighted mean
atus19_cu %>% group_by(prdisflg, pesex) %>%
summarise(weighted.mean(pcuse, tufinlwgt))

# weighted median
atus19_cu %>% group_by(prdisflg, pesex) %>%
summarise(weighted.median(pcuse, tufinlwgt))

# filter to low internet use only
ggplot(atus19_cu, aes(pcuse)) + geom_bar()
atus19_cul <- tibble(filter(atus19_cu, x < 20))

## bin internet use ##
# check dist first
hist(atus19_cu$pcuse)
# filter out outliers to examine bins
atus19_cuh <- filter(atus19_cu, pcuse > 900)
# print table
atus19_cu1 <- tibble(filter(atus19_cu, tucaseid == 20190807192028))
atus19_cu1 <- unique(atus19_cu1)
atus19_cu1 <- aggregate(atus19_cu1$tuactdur24, list(atus19_cu1$tucaseid), sum)
cuhtable<- atus19_cuh %>% count(tucaseid, trcode, tuactdur24, pcuse)
cuhtable[order(cuhtable$tucaseid),]
stargazer(cuhtable, summary = FALSE,
          type = "text",
          out = "data_stargazer_txt.txt")

# create bins
atus19_pcuse<-atus19_pcuse%>%mutate(pcbins = cut(pcuse, breaks = c(0,10,20,30,Inf)))
# plot to check
ggplot(atus19_pcuse, aes(x = pcbins)) + 
  geom_bar()

# weighted percents
atus19_cu %>% calc_cro_cpct_responses(pcbins, prdisflg, weight = tufinlwgt)

