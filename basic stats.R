# weighted mean
data %>% group_by(nominal_grp_col) %>%
  summarise(weighted.mean(continous_values_col, weights_col))

#weighted median
data %>% group_by(nominal_grp_col) %>%
  summarise(weighted.median(continous_values_col, weights_col))

# frequencies
data <- fre(atusact20_wgt$prdisflg, weight = atusact20_wgt$tu20fwgt)

# %% breakdown
table1 <- data %>% calc_cro_cpct_responses(groupvar1, groupvar2, groupvar3, weight = weights_col)
