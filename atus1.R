
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
library(expss)
library(alookr)
library(dplyr)

atus <- atusactcpsresp19

# filter to 18 and older

atus_wa <- tibble(filter(atus, prtage > 17 ))

# filter to 65 and younger

atus_wa <- tibble(filter(atus, prtage < 66 ))

# calculate weighted percents (split by disability status y/n)

edu <- atus_wa %>% calc_cro_cpct_responses(peeduca, prdisflg, weight = tufinlwgt)

