# %% breakdown
table1 <- atus20_tule1 %>% calc_cro_cpct_responses(peeduca, prdisflg, weight = tu20fwgt)

# %% breakdown
table1 <- atus20_tule1 %>% calc_cro_cpct_responses(hetenure, prdisflg, weight = tu20fwgt)

# %% breakdown
table1 <- atus20_tule1 %>% calc_cro_cpct_responses(ptdtrace, prdisflg, weight = tu20fwgt)

# %% breakdown
table1 <- atus20_tule2 %>% calc_cro_cpct_responses(vehown, prdisflg, weight = tu20fwgt)

# weighted mean
data %>% group_by(nominal_grp_col) %>%
    summarise(weighted.mean(continous_values_col, weights_col))

#weighted median
data %>% group_by(nominal_grp_col) %>%
    summarise(weighted.median(continous_values_col, weights_col))

table1 <- atus20_tule1  %>% group_by(prdisflg) %>%
    summarise(weighted.median(peeduca, tu20fwgt))

# frequencies
data <- fre(atusact20_wgt$prdisflg, weight = atusact20_wgt$tu20fwgt)