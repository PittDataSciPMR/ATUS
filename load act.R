# port in activity file
atusact_2020 <- read_sav("C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/Extracted files/2020/atusact_2020.sav")

# Tidy names
atusact20 <-   as_tibble(as_numeric(rename_all(atusact_2020, tolower)))
atusact20$tustarttim <- times(atusact20$'tustarttim')
atusact20$tustoptime <- times(atusact20$'tustoptime')
# order alphabetically
atusact20 <- atusact20 %>% select(order(colnames(atusact20)))

# add tulineno = 1
atusact20$tulineno<- c(1)

# rm original file
rm(atusact_2020)
