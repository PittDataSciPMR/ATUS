# Pull trcodes related to car maintenance
atus20_vehmn <- tibble(filter(atusact20, trcode == 020701 | trcode == 070102 
                            | trcode == 090501 | trcode == 090502 | trcode == 180207 | trcode == 180905
                            ))
# Mark that the activity suggests vehicle ownership
atus20_vehmn$vehown <- c(1)

atus20vehown <- atus20_vehmn %>% select(tucaseid, vehown)

# Check for dupes
sum(duplicated(atus20vehown$tucaseid))
# remove dupe values vehicle ownership
atus20vehown <- atus20vehown[!duplicated(atus20vehown$tucaseid), ]

# add back to original file
atusact201 <- (merge(x=atusact20, y=atus20vehown, by = "tucaseid", all.x = TRUE))

atusact201 <- replace_na(atusact201,list(vehown = 0))



table1 <- atusact201 %>% calc_cro_cpct_responses(vehown)

# travel as driver
# select only travel
atus20_travel <- tibble(filter(atusact20, tutier1code == 18))
# Check for dupes
sum(duplicated(atus20_travel$tucaseid))
# tewhere = 12
atus20_travel <- tibble(filter(atus20_travel, tewhere == 12))
# Mark that the activity is driver
atus20_travel$driver<- c(1)

atus20_travel <- atus20_travel %>% select(tucaseid, driver)

atus20_travel <-  replace_na(atus20_travel,list(driver = 0))
# remove dupe values tewhere = 12
atus20_travel <- atus20_travel[!duplicated(atus20_travel$tucaseid), ]
# add back to original file
atusact202 <- (merge(x=atusact201, y=atus20_travel, by = "tucaseid", all.x = TRUE))

atusact202 <- replace_na(atusact202,list(driver = 0))

table1 <- atusact202 %>% calc_cro_cpct_responses(driver)

# remove dupes
atusact203 <- atusact202[!duplicated(atusact202$tucaseid), ]

# add together vehicle driver cols
atusact203 <- atusact203 %>% mutate(veh_drvr = vehown + driver)
table1 <- atusact203 %>% calc_cro_cpct_responses(veh_drvr)

# make veh_drvr only 0s and 1s (not 2s)
atusact203['veh_drvr'][atusact203['veh_drvr'] == 2] <- 1

# select prdisflg from cps
prdisflg <- atuscps20 %>% filter(tulineno == 1) %>%  select(tucaseid, prdisflg)

# Check for dupes
sum(duplicated(prdisflg$tucaseid))

# add prdisflg
atusact204 <- merge(x = atusact203, y = prdisflg, by = "tucaseid")

# select tu20fwgt from resp
tu20fwgt <- atusresp20 %>% select(tucaseid, tu20fwgt)

# add resp for weights
atusact205 <- merge(x = atusact204, y = tu20fwgt, by = "tucaseid")

# Check for dupes
sum(duplicated(atusact205$tucaseid))

#remove intermediary files
rm(atus20_travel, atus20vehown, atus20_vehmn, atusact20, atusact201, 
   atusact202, atusact203, atusact204, prdisflg, tu20fwgt)

# %% breakdown
table1 <- atusact205 %>% calc_cro_cpct_responses(veh_drvr, prdisflg, weight = tu20fwgt)

atus_veh <- atusact205
