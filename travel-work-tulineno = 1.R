# Travel related to working (1805xx):
  # disabled: 10.4%
  # non-disabled: 21.2%


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
atus20_tule1trvl <- tibble(filter(atus20_tule1, tutier1code == 18))
# double check travel only
table1 <- atus20_travel %>% calc_cro_cpct_responses(tutier1code, weight = tu20fwgt)

# select travel related to work
atus20_travel1 <- tibble(filter(atus20_travel, tutier2code == 05))
# double check travel related to working only
table1 <- atus20_travel1 %>% calc_cro_cpct_responses(tutier2code, weight = tu20fwgt)

# age bins
atus19_travel1 <-atus19_travel1%>%mutate(age = cut(prtage, breaks = c(-Inf,20,30,40,50,60,70,Inf)))
# look at bins
table1 <- atus19_travel1 %>% calc_cro_cpct_responses(prdisflg, age, weight = tufinlwgt)
# filter to working age
atus19_travel2 <- tibble(filter(atus19_travel1, prtage > 17 & prtage < 66))
# double check age range
data <- fre(atus19_travel2$prtage)

# filter tewhere because some people don't know how to fill out a questionnaire
atus20_travel2 <- tibble(filter(atus20_travel1, tewhere > 11))

# how are they traveling?
table1 <- atus20_travel2 %>% calc_cro_cpct_responses(prdisflg, tewhere, weight = tu20fwgt)
