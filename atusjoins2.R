perpub1 <- perpub[,order(colnames(perpub))]

str(hhpub1)

hhpub1$idresp <- paste(hhpub1$HBHTNRNT, hhpub1$HBHUR, hhpub1$HH_CBSA, 
                       hhpub1$HH_HISP, hhpub1$HH_RACE, hhpub1$HOUSEID, sep =" ")


persontrip_CSS_6_22_Copy$idresp <- paste(persontrip_CSS_6_22_Copy$HBHTNRNT, persontrip_CSS_6_22_Copy$HBHUR, 
                                         persontrip_CSS_6_22_Copy$HH_CBSA, persontrip_CSS_6_22_Copy$HH_HISP, 
                                         persontrip_CSS_6_22_Copy$HH_RACE, persontrip_CSS_6_22_Copy$HOUSEID, sep = " ")


hhpersontrip <- merge(x=hhpub1, y=persontrip_CSS_6_22_Copy, by= 'idresp', all.y  = TRUE)

str(hhpersontrip)

perpub1$idresp <- paste(perpub1$HBHUR, 
                        perpub1$HH_CBSA, perpub1$HH_HISP, 
                        perpub1$HH_RACE, perpub1$HOUSEID, sep = " ")

hhpersontrip1_all$idresp <- paste(hhpersontrip1_all$HBHUR, 
                        hhpersontrip1_all$HH_CBSA, hhpersontrip1_all$HH_HISP, 
                        hhpersontrip1_all$HH_RACE, hhpersontrip1_all$HOUSEID, sep = " ")

perpub1 <- select(perpub1, c(idresp, LSTTRDAY17))

hhpersontrip1 <- merge(x=perpub1, y=hhpersontrip, by= 'idresp', all.y  = TRUE)


library(foreign)

write.dta(hhpersontrip1, "C:\\Users\\css81\\OneDrive - University of Pittsburgh\\NHTS\\CTPP data\\hhpersontrip1.dta")


hhpersontripsame <- merge(x=hhpersontrip1_all, y=perpub1, by= 'idresp', all.x = TRUE)

write.dta(hhpersontripsame, "C:\\Users\\css81\\OneDrive - University of Pittsburgh\\NHTS\\CTPP data\\hhpersontripsame.dta")

