# Travel related to caring for & helping nonhh members (1804xx): 
  # disabled: 9%
  # non-disabled: 4.8%

# who are these people?
# join resp to activity for weights
atusact19_wgt <- as_tibble(merge(x=atusact19, y=atusresp19, by = c("tucaseid", "tulineno")))

# join cps to act for demos
atusact19_wgt <- as_tibble(merge(x=atusact19_wgt, y=atuscps19, by= c("tucaseid", "tulineno")))

# order alphabetically
atusact19_wgt <- atusact19_wgt %>% select(order(colnames(atusact19_wgt)))

# select only valid disability codes
atusact19_wgt <- tibble(filter(atusact19_wgt, prdisflg >= 1))

# select only travel
atus19_travel <- tibble(filter(atusact19_wgt, tutier1code == 18))
# double check travel only
table1 <- atus19_travel %>% calc_cro_cpct_responses(tutier1code, weight = tufinlwgt)

# select travel related to caring for & helping nonhh members
atus19_travel1 <- tibble(filter(atus19_travel, tutier2code == 04))
# double check travel related to caring for & helping nonhh members only
table1 <- atus19_travel1 %>% calc_cro_cpct_responses(tutier2code, weight = tufinlwgt)

# age bins
atus19_travel1 <-atus19_travel1%>%mutate(age = cut(prtage, breaks = c(-Inf,20,30,40,50,60,70,Inf)))
# look at bins
table1 <- atus19_travel1 %>% calc_cro_cpct_responses(prdisflg, weight = tufinlwgt)

# how are they traveling?
table1 <- atus19_travel1 %>% calc_cro_cpct_responses(prdisflg, tewhere, weight = tufinlwgt)

# who lives with these people?

# select tucaseid only
atus19_travel_nonhh_dis


