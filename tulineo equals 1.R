# create dataset activity file 
#Activities were only asked about for tulineno = 1

# Select atus variables
atusact20 <- select(atusact20, c('tucaseid', 'tuactivity_n', 'tewhere', 'tuactdur', 'tuactdur24', 'tucumdur', 'tucumdur24',
                                 'tustarttim', 'tustoptime', 'tutier1code', 'tutier2code', 'tutier2code', 'trcode',
                                 'trtier2'))
atusact20<- tibble(as_numeric(atusact20, 1:7, 10:13))

# add tulineno col to activity file
atusact20$tulineno <- c(1)

# from who file select only tulineno = 1
atuswho201 <- tibble(filter(atuswho20, tulineno == 1 ))

# join who and activity files
atusactwho20 <- merge(x=atusact20, y=atuswho201, by = c("tucaseid", "tuactivity_n", "tulineno"), all = TRUE)

# add on resp file
atusactwhoresp20 <- merge(x=atusactwho20, y=atusresp20, by = c("tucaseid", "tulineno"), all = TRUE)

# Select cps variables

atuscps20 <- select(atuscps20, c('tucaseid', 'tulineno', 'hefaminc', 'hrhhid', 'hrhhid2', 45:50, 
                                 'pecyc', 55:60, 'peeduca', 'pehspnon', 'pesex', 'prdisflg', 'prtage', 
                                 'ptdtrace', 205:207, 'pulineno', 'qstnum', 'prdasian'))

atuscps20 <- tibble(as_numeric(atuscps20))

# Select only tulineno = 1 from cps
atuscps201 <- tibble(filter(atuscps20, tulineno == 1 ))
# Check for dupes
sum(duplicated(atuscps201$tucaseid))

# add on cps to look at demographics
atus20_tule1 <- merge(x=atusactwhoresp20, y=atuscps201, by = c("tucaseid", "tulineno"), all = TRUE)

# order alphabetically
atus20_tule1 <- atus20_tule1 %>% select(order(colnames(atus20_tule1)))

# remove intermediary files
rm(atuswho201, atusactwho20, atusactwhoresp20, atusc)


