# tulineno = 1
# Grocery shopping (070101):
# disabled: 
# non-disabled: 

# who are these people?
# join resp to activity for weights
atusact19_wgt <- as_tibble(merge(x=atusact19, y=atusresp19, by = c("tucaseid", "tulineno")))

# join cps to act for demos
atusact19_wgt <- as_tibble(merge(x=atusact19_wgt, y=atuscps19, by= c("tucaseid", "tulineno")))

# order alphabetically
atusact19_wgt <- atusact19_wgt %>% select(order(colnames(atusact19_wgt)))

# select only valid disability codes
atusact19_wgt <- tibble(filter(atusact19_wgt, prdisflg >= 1))

# select consumer purchases
atus19_cp <- tibble(filter(atusact19_wgt, tutier1code == 07))
# double check consumer purchases only
table1 <- atus19_cp %>% calc_cro_cpct_responses(tutier1code, weight = tufinlwgt)

# select consumer purchases related to shopping
atus19_cp1 <- tibble(filter(atus19_cp, tutier2code == 01))
# double check activity is consumer purchases related to shopping only
table1 <- atus19_cp1 %>% calc_cro_cpct_responses(tutier2code, weight = tufinlwgt)

# select shopping related to groceries
atus19_cp2 <- tibble(filter(atus19_cp1, tutier3code == 01))
# double check trcode == 070101
table1 <- atus19_cp2 %>% calc_cro_cpct_responses(trcode, weight = tufinlwgt)

# age bins
atus19_cp3 <-atus19_cp2%>%mutate(age = cut(prtage, breaks = c(-Inf,20,30,40,50,60,70,Inf)))
# look at bins
table1 <- atus19_cp3 %>% calc_cro_cpct_responses(age, weight = tufinlwgt)
# filter to working age
atus19_cp3 <- tibble(filter(atus19_cp3, prtage > 17 & prtage < 66))
# double check age range
data <- fre(atus19_cp3$prtage)


# where are they?
table1 <- atus19_cp3 %>% calc_cro_cpct_responses(prdisflg, weight = tufinlwgt)
