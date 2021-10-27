# port in who file
atuswho_2020 <- read_sav("C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/Extracted files/2020/atuswho_2020.sav")

# Tidy names
atuswho20 <-   as_tibble(as_numeric(rename_all(atuswho_2020, tolower)))

# order alphabetically
atuswho20 <- atuswho20 %>% select(order(colnames(atuswho20)))

# rm original file
rm(atuswho_2020)
