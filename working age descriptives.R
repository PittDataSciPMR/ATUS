library(RM.weights)
library(psych)
library(expss)

# filter to 18 and older

atus19_wa <- tibble(filter(atus19, prtage > 17 ))

# filter to 65 and younger

atus19_wa <- tibble(filter(atus19_wa, prtage < 66 ))

atus19_wa <- tibble(filter(atus19_wa, prdisflg >= 1))



# calculate weighted averages (split by disability status y/n): age

atus19_wa %>% group_by(prdisflg) %>% 
  summarise(weighted.mean(prtage, tufinlwgt))

# calculate weighted medians (split by disability status y/n): race

atus19_wa %>% group_by(prdisflg) %>% 
  summarise(weighted.median(ptdtrace, tufinlwgt))

# calculate weighted percents (split by disability status y/n): race
atus19_wa %>% calc_cro_cpct_responses(ptdtrace, prdisflg, weight = tufinlwgt)

# calculate weighted percents (split by disability status y/n): hisp/latinx
atus19_wa %>% calc_cro_cpct_responses(pehspnon, prdisflg, weight = tufinlwgt)
 
# calculate weighted percents (split by disability status y/n): education
atus19_wa %>% calc_cro_cpct_responses(peeduca, prdisflg, weight = tufinlwgt)

# calculate weighted percents (split by disability status y/n): income
atus19_wa %>% calc_cro_cpct_responses(hefaminc, prdisflg, weight = tufinlwgt)

# Transportation statistics

# 12 Car, truck, or motorcycle (driver)
# 13 Car, truck, or motorcycle (passenger)
# 14 Walking
# 15 Bus
# 16 Subway/train
# 17 Bicycle
# 18 Boat/ferry
# 19 Taxi/limousine service
# 20 Airplane
# 21 Other mode of transportation
# 99 Unspecified mode of transportation


trvluf <- atus19_wa %>% calc_cro_cpct_responses(tewhere, prdisflg, weight = tufinlwgt)

trvluf

#filter to travel only activities

atus19_wat <- tibble(filter(atus19_wa, tewhere >= 12 & tewhere <= 21 | tewhere == 99))

# calculate weighted percents (split by disability status y/n): only travel
trvl <- atus19_wat %>% calc_cro_cpct_responses(tewhere, prdisflg, weight = tufinlwgt)

trvl

# calculate weighted percents (split by disability status y/n): only travel 5-120 min

atus19_watm <- tibble(filter(atus19_wat, tuactdur >= 5 & tuactdur <= 120))

fnx(sapply(atus19_watm, min))

fnx(sapply(atus19_watm, max))

trvlt <- atus19_watm %>% calc_cro_cpct_responses(tewhere, prdisflg, weight = tufinlwgt)

trvlt

atusdis19 %>% group_by(prdisflg) %>% 
  summarise(weighted.mean(prtage, tufinlwgt))

atus19_watm %>% group_by(prdisflg, tewhere) %>% 
  summarise(weighted.median(tuactdur, tufinlwgt))

# weighted counts
atusdis19 <- merge(x=atuscps19, y=atusresp19, by.x = "tucaseid", by.y="tucaseid", all.y= TRUE)

cdct <- fre(atusdis19$prdisflg, weight = atusdis19$tufinlwgt)
ctpudis2 <- fre(atusdis19$pudis2, weight = atusdis19$tufinlwgt)
