library(dplyr)
library(tidyverse)
library(naniar)
library(lubridate)
library(readr)

# load data
hh <- as_tibble(nhts_households)
per <- as_tibble(nhts_persons)
trip <- as_tibble(nhts_trips)
veh <- as_tibble(nhts_vehicles)

hh1 <- as_tibble(hh %>% replace_with_na(condition = ~.x %in% c(-88, -99, -7, -8, -9, -1, 97))) 
per1 <- as_tibble(per %>% replace_with_na(condition = ~.x %in% c(-88, -99, -7, -8, -9, -1, 97))) 
trip1 <- as_tibble(trip %>% replace_with_na(condition = ~.x %in% c(-88, -99, -7, -8, -9, -1, 97))) 
veh1 <- as_tibble(veh %>% replace_with_na(condition = ~.x %in% c(-88, -99, -7, -8, -9, -1, 97)))

trip2 <- na.omit(trip1)

trip3 <- trip2[sample(nrow(trip2), 400),]

TABLE <- perpub %>% 
          count(MEDCOND, PRMACT) %>%
          group_by(MEDCOND) %>%
            mutate(prop = prop.table(n))

TABLE$MEDCOND[TABLE$MEDCOND %in% c(-7,-8,-9)] <- NA

TABLE$MEDCOND[TABLE$MEDCOND %in% c(-7,-8,-9)]





print(TABLE, n = 40)

with(perpub1, ls())
perpub1 <- select(perpub, -c(PAYPROF))

with(perhhpub, ls())

trippub1 <- select(trippub, c('GASPRICE', 'HOUSEID', 'NUMTRANS',
                              'PERSONID','PRMACT','PSGR_FLG','PUBTRANS', 'TDWKND',
                              'TRACC_BUS', 'TRACC_CRL','TRACC_OTH', 'TRACC_POV', 'TRACC_SUB',
                              'TRACC_WLK','TRACCTM', 'TRAVDAY', 'TREGR_BUS','TREGR_CRL',
                              'TREGR_OTH',
                              'TREGR_POV', 'TREGR_SUB',
                              'TREGR_WLK', 'TREGRTM','TRIPPURP',
                              'TRPACCMP', 'TRPHHACC', 'TRPHHVEH', 'TRPMILAD', 'TRPMILES','TRVLCMIN',
                              'TRWAITTM',
                              'URBAN','URBANSIZE',
                              'URBRUR','VEHID',
                              'VEHTYPE', 'VMT_MILE', 'WHODROVE','WHYFROM', 'WHYTO',
                              'WHYTRP1S', 'WHYTRP90', 
                              'WORKER',
                              'WRKCOUNT',
                              'WTTRDFIN'))


hhpub1 <- select(hhpub, c('houseid', 'personid'))

# Combine all
per1$id <- paste(per1$houseid, per1$personid)
trip1$id <- paste(trip1$houseid, trip1$personid)
veh1$id <- paste(veh1$houseid, veh1$personid)

perhh1 <- as_tibble(merge(x=per1, y=hh1, by.x = "houseid", by.y="houseid", all =TRUE))
perhhtrip <- as_tibble(merge(x=perhh1, y=trip1, by.x = "id", by.y="id", all =TRUE))
perhhtripveh <- as_tibble(merge(x=perhhtrip, y=veh1, by.x = "id", by.y="id", all =TRUE))

perhhtripveh$id <- paste(perhhtripveh$id, perhhtripveh$vehid.x)


trippub$ID <- paste(trippub$HOUSEID, trippub$PERSONID)

pertrip <- merge(x=perpub, y=trippub, by="ID", all.y =TRUE)

hh2 <- merge(x=hh1, y=data_9LhSS, by.x = "HH_CBSA", by.y = "FIPS-Code")



str(perhhtripppub)

unique(perpub[c("SAMEPLC")])

write_csv(perhhtripppub, "C:\\Users\\css81\\OneDrive - University of Pittsburgh\\NHTS\\CTPP data\\persontrip.csv")
