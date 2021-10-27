# Travel clusters based on disability and age:
# disabled: 10.4%
# non-disabled: 21.2%

# pull in activity file

# join resp to activity for weights
atusact20_wgt <- as_tibble(merge(x=atusact20, y=atusresp20, by = c("tucaseid", "tulineno")))

# join cps to act for demos
atusact20_wgt <- as_tibble(merge(x=atusact20_wgt, y=atuscps20, by= c("tucaseid", "tulineno")))

# order alphabetically
atusact20_wgt <- atusact20_wgt %>% select(order(colnames(atusact20_wgt)))

# select only valid disability codes
atusact20_wgt <- tibble(filter(atusact20_wgt, prdisflg >= 1))

########### trip counts

# select only tucaseid and travelcount from reference table (that Matt made you)
atus19_traveldummy <- as_tibble(select(atus19_dummytraveldone, "tucaseid", "TravelCount"))

# remove dupe values
atus19_traveldummy <- atus19_traveldummy[!duplicated(atus19_traveldummy$tucaseid), ]

# merge with dataset to add col indicating number of travel trips in 24 hr
atus19_td <- as_tibble(merge(x=atusact19_wgt, y=atus19_traveldummy, 
                                      by = "tucaseid", all.x = TRUE))
# weighted means for TravelCount by disability status
atus19_td %>% group_by(prdisflg) %>%
    summarise(weighted.mean(TravelCount, tufinlwgt))

######## trip time
atus20_trvl <- filter(atus20_wgt, trcode)

