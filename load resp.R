# port in respondent file

# This file contains case-specific variables collected in ATUS (that is, variables for which 
# there is one value for each respondent). These include, for example, labor force and earnings information, 
# total time providing secondary childcare, total time providing eldercare, and ATUS statistical weights.

atusresp_2020 <- read_sav("C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/Extracted files/2020/atusresp_2020.sav")
# tidy names
atusresp20 <-   as_tibble(as_numeric(rename_all(atusresp_2020, tolower)))

atusresp20 <- select(atusresp20, 102, 'tulineno', 93:96, 'telfs', 'trtalone', 'trtalone_wk', 'tucaseid', 'tu20fwgt')

# order alphabetically
atusresp20 <- atusresp20 %>% select(order(colnames(atusresp20)))

# rm original file
rm(atusresp_2020)

