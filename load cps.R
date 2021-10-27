# port in cps file
atuscps_2020 <- read_sav("C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/Extracted files/2020/atuscps_2020.sav")

# tidy names
atuscps20 <-   as_tibble(as_numeric(rename_all(atuscps_2020, tolower)))
# order alphabetically
atuscps20 <- atuscps20 %>% select(order(colnames(atuscps20)))

# rm original file
rm(atuscps_2020)
