# trcodes - activity file
    # 02 Household Activities
        # 09 Household Management
            # 04 HH & personal e-mail and messages
    # 12 Socializing, Relaxing, and Leisure
        # 03 Relaxing and Leisure
            # 08 Computer use for leisure (excluding games)
    # 15 Volunteer Activities
        # 01 Administrative & Support Activities
            # 01 Computer use

# Pull trcodes related to computer use
atus20_pc <- tibble(filter(atusact20, trcode == 020904 | trcode == 120308 | trcode == 150101))

# Mark that the activity suggests internet use
atus20_pc$pcuse <- c(1)

atus20_pc1 <- atus20_pc %>% select(tucaseid, pcuse)

# Check for dupes
sum(duplicated(atus20_pc1$tucaseid))
# remove dupe values computer use
atus20_pc1 <- atus20_pc1[!duplicated(atus20_pc1$tucaseid), ]

# add back to original file
atus20_pc2 <- (merge(x=atusact20, y=atus20_pc1, by = "tucaseid", all.x = TRUE))
# fill nulls with 0s
atus20_pc3 <- replace_na(atus20_pc2,list(pcuse = 0))

# remove dupe ids (only need to know if the person used the PC, not how many times or minutes)
atus20_pc3 <- atus20_pc3[!duplicated(atus20_pc3$tucaseid), ]


# select prdisflg from cps
prdisflg <- atuscps20 %>% filter(tulineno == 1) %>%  select(tucaseid, prdisflg)

# Check for dupes
sum(duplicated(prdisflg$tucaseid))

# add prdisflg
atus20_pc4 <- merge(x = atus20_pc3, y = prdisflg, by = "tucaseid")

# select tu20fwgt from resp
tu20fwgt <- atusresp20 %>% select(tucaseid, tu20fwgt)
# Check for dupes
sum(duplicated(tu20fwgt$tucaseid))

# add resp for weights
atus20_pc5 <- merge(x = atus20_pc4, y = tu20fwgt, by = "tucaseid")

# Check for dupes
sum(duplicated(atus20_pc5$tucaseid))

# remove intermediary files
rm(atus20_pc, atus20_pc1, atus20_pc2, atus20_pc3, atus20_pc4)

# check where were they?
table1 <- atus20_pc5 %>% calc_cro_cpct_responses(tewhere)

# %% breakdown
table1 <- atus20_pc5 %>% calc_cro_cpct_responses(pcuse, prdisflg, weight = tu20fwgt)



