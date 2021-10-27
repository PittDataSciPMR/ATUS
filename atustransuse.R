# trcode - activity file
# 02 Household Activities
  # 07 Vehicles
    # 01 Vehicle repair and maintenance (by self)

# 03 Caring For and Helping Household Members
  # 01 Caring For and Helping HH Children
    # 12 Picking up/dropping off hh children
  # 05 Helping Household Adults
    # 03 Picking up/dropping off hh adult

# 04 Caring For and Helping NonHH Children
  # 01 Caring For and Helping HH Children
    # 12 Picking up/dropping off hh children
  # 05 Helping Household Adults
    # 07 Picking up/dropping off hh adult

# 07 Consumer Purchases
  # 01 Shopping (Store, Telephone, Internet)
    # 02 Purchasing gas

# 09 Household Services
  # 05 Vehicle Maint. & Repair Services (not done by self)
    # 01 Using vehicle maintenance or repair services
    # 02 Waiting associated with vehicle main. or repair svcs

# 13 Sports, Exercise, and Recreation
  # 06 Boating
  # 16 Hiking
  # 24 Running
  # 29 Vehicle Touring/Racing
  # 31 Walking

# 15 Volunteer Activities
  # 02 Social Service and Care Activities (Except Medical)
    # 02 Collecting & delivering clothing & other goods

# 18 Traveling
  # 01 Travel Related to Personal Care
    # 01 Travel related to personal care
    # 99 Travel related to personal care, n.e.c.*
  # 02 Travel Related to Household Activities
    # 01 Travel related to housework
    # 02 Travel related to food & drink prep., clean-up, & presentation
    # 03 Travel related to interior maintenance, repair, & decoration
    # 04 Travel related to exterior maintenance, repair, & decoration
    # 05 Travel related to lawn, garden, and houseplant care
    # 06 Travel related to care for animals and pets (not vet care)
    # 07 Travel related to vehicle care & maintenance (by self)
    # 08 Travel related to appliance, tool, and toy set-up, repair, & maintenance (by self)
    # 09 Travel related to household management
    # 99 Travel related to household activities, n.e.c.*
  # 03 Travel Related to Caring For & Helping HH Members
    # 01 Travel related to caring for & helping hh children
    # 02 Travel related to hh children's education
    # 03 Travel related to hh children's health
    # 04 Travel related to caring for hh adults
    # 05 Travel related to helping hh adults
    # 99 Travel rel. to caring for & helping hh members, n.e.c.*
  # 04 Travel Related to Caring For & Helping Nonhh Members
    # 01 Travel related to caring for and helping nonhh children
    # 02 Travel related to nonhh children's education
    # 03 Travel related to nonhh children's health
    # 04 Travel related to caring for nonhh adults
    # 05 Travel related to helping nonhh adults
    # 99 Travel rel. to caring for & helping nonhh members, n.e.c.*
  # 05 Travel Related to Work
    # 01 Travel related to working
    # 02 Travel related to work-related activities
    # 03 Travel related to income-generating activities
    # 04 Travel related to job search & interviewing
    # 99 Travel related to work, n.e.c.*
  # 06 Travel Related to Education
    # 01 Travel related to taking class
    # 02 Travel related to extracurricular activities (ex. Sports)
    # 03 Travel related to research/homework
    # 04 Travel related to registration/administrative activities
    # 99 Travel related to education, n.e.c.*
  # 07 Travel Related to Consumer Purchases
    # 01 Travel related to grocery shopping
    # 02 Travel related to purchasing gas
    # 03 Travel related to purchasing food (not groceries)
    # 04 Travel related to shopping, ex groceries, food, and gas
    # 99 Travel related to consumer purchases, n.e.c.*
  # 08 Travel Related to Using Professional and Personal Care Services
    # 01 Travel related to using childcare services
    # 02 Travel related to using financial services and banking
    # 03 Travel related to using legal services
    # 04 Travel related to using medical services
    # 05 Travel related to using personal care services
    # 06 Travel related to using real estate services
    # 07 Travel related to using veterinary services
    # 99 Travel rel. to using prof. & personal care services, n.e.c.*
  # 09 Travel Related to Using Household Services
    # 01 Travel related to using household services
    # 02 Travel related to using home main./repair/décor./construction svcs
    # 03 Travel related to using pet services (not vet)
    # 04 Travel related to using lawn and garden services
    # 05 Travel related to using vehicle maintenance & repair services
    # 99 Travel related to using household services, n.e.c.*
  # 10 Travel Related to Using Govt Services & Civic Obligations
    # 01 Travel related to using government services
    # 02 Travel related to civic obligations & participation
    # 99 Travel rel. to govt svcs & civic obligations, n.e.c.*
  # 11 Travel Related to Eating and Drinking
    # 01 Travel related to eating and drinking
    # 99 Travel related to eating and drinking, n.e.c.*
  # 12 Travel Related to Socializing, Relaxing, and Leisure
    # 01 Travel related to socializing and communicating
    # 02 Travel related to attending or hosting social events
    # 03 Travel related to relaxing and leisure
    # 04 Travel related to arts and entertainment
    # 05 Travel as a form of entertainment
    # 99 Travel rel. to socializing, relaxing, & leisure, n.e.c.*
  # 13 Travel Related to Sports, Exercise, & Recreation
    # 01 Travel related to participating in sports/exercise/recreation
    # 02 Travel related to attending sporting/recreational events
    # 99 Travel related to sports, exercise, & recreation, n.e.c.*
  # 14 Travel Related to Religious/Spiritual Activities
    # 01 Travel related to religious/spiritual practices
    # 99 Travel rel. to religious/spiritual activities, n.e.c.*
  # 15 Travel Related to Volunteer Activities
    # 01 Travel related to volunteering
    # 99 Travel related to volunteer activities, n.e.c.*
  # 16 Travel Related to Telephone Calls
    # 01 Travel related to phone calls
    # 99 Travel rel. to phone calls, n.e.c.*
  # 18 Security Procedures Related to Traveling
    # 01 Security procedures related to traveling
  # 99 Security procedures related to traveling, n.e.c.*
    # 99 Traveling, n.e.c.*
    # 99 Traveling, n.e.c.*






# Where in transport
atustrans19_t1 <- tibble(filter(atus19_tule1, tewhere >= 12 & tewhere <= 21))

# aggregate of all travel use
transagg19_1 <- aggregate(atustrans19_t1$tuactdur24, list(atustrans19_t1$tucaseid), sum)

# rename cols
transagg19_1<- as_tibble(rename(transagg19_1, tucaseid = Group.1, transtime = x))

# add back to original table
atustrans19_t1 <- merge(x=atus19_tule1, y=transagg19_1, by = "tucaseid", all = TRUE)


  
# filter greater than 0
atustrans19_t1 <- tibble(filter(atustrans19_t1, transtime > 1))

# view dist
ggplot(atustrans19_t1, aes(transtime)) + geom_bar()


# filter less than 300 minutes
atus19_trs <- tibble(filter(atus19_trs, transtime < 300))

# weighted mean split by sex and disability
atus19_trs %>% group_by(prdisflg, pesex) %>%
  summarise(weighted.mean(transtime, tufinlwgt))

#weighted median split by sex and disability
atus19_trs %>% group_by(prdisflg, pesex) %>%
  summarise(weighted.median(transtime, tufinlwgt))
# filter yes dis
atus19_trsdy <- tibble(filter(atus19_trs, prdisflg == 1))
# filter no dis
atus19_trsdn <- tibble(filter(atus19_trs, prdisflg == 2))

# count of travel types
atuspudis <-  tibble(filter(atusdis191, prdisflg == 1))
transct <- fre(atustewhere$tewhere, weight = atustewhere$tufinlwgt)

trcdctdy <- fre(atus19_trsdy$trcode, weight = atus19_trsdy$tufinlwgt)
trcdctdn <- fre(atus19_trsdn$trcode, weight = atus19_trsdn$tufinlwgt)


atus19_groc <- as_tibble(atus19_groc %>% replace_with_na(replace = list(prtage = c(-3, -2, -1))))
atus19_groc<-atus19_groc%>%mutate(agebins = cut(prtage, breaks = c(0,5,10,17,25,35,45,55,65,75,Inf)))
# plot to check
ggplot(atus19_groc, aes(x = tuactdur24)) + 
  geom_bar()
# working age bins
atus19_groc<-atus19_groc%>%mutate(workingage = cut(prtage, breaks = c(-Inf,18,25,35,45,55,65,Inf)))
atus19_groc$workingage_10<- ifelse(atus19_groc$prtage>= 18 & atus19_groc$prtage <= 65, 1, 0)


# Indicate that row was a travel activity
atustewhere$trvld <- c(1)

# agg number of travel activities
atustewhereagg <- aggregate(atustewhere$trvld, list(atustewhere$tucaseid), sum)


atustest <- as_tibble(merge(x=atusresp19, y=atustewhereagg, by.x = "tucaseid", by.y="tucaseid", all.y =TRUE))

atustewhere1 <- as_tibble(merge(x=atusact19, y=atustewhereagg, by.x = "tucaseid", by.y="tucaseid", all.y =TRUE))
atustewhere1$trvld <- c(1)
atustrans19_t1 <- as_tibble(merge(x=atustrans19_t1, y=atusresp19, by.x = 'tucaseid', by.y = 'tucaseid'))

# order alphabetically
atustewhere2 <- atustewhere2 %>% select(order(colnames(atustewhere2)))

# remove dupe ids to accurately count
atustewhere2 <- atustewhere2[!duplicated(atustewhere2$tucaseid), ]

# weighted mean
atustewhere2 %>% group_by(prdisflg) %>%
  summarise(weighted.mean(trvlct, tufinlwgt))

#weighted median
atustewhere2 %>% group_by(prdisflg) %>%
  summarise(weighted.median(trvlct, tufinlwgt))

# count trans break down
atus19car <- fre(atusxxxxx$tewhere, weight = atustewhere$tufinlwgt)

# port to spss
write_sav(atustrans19_bins1, "C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/atustrans1.sav")

#############################################################################################################
# analysis
# Bin travel 
# Create safety dataset
atustrans19_bins1 <- atustrans19_t1

#quantiles
ggplot(atustrans19_bins1) +
    geom_histogram(mapping=aes(transtime, binwidth = 30))

       # create bins
          #  atustrans19_bins1 <-atustrans19_bins1%>%mutate(transtimebin = cut(transtime, 
                                                                  # breaks = c(0,30,60,90, 120, Inf))) these bins suck


# calculate weighted percents (split by disability status y/n): tutier2 code
  # traveled related to:
    # 1: personal care
    # 2: household activities
    # 3: caring for & helping hh members
    # 4: caring for & helping nonhh members
    # 5: work
    # 6: edu
    # 7: consumer purchases
    # 8: professional & personal services
    # 9: hh services
    # 10: govt services & civic obligations
    # 11: eating & drinking
    # 12: socializing, relaxing, & leisure
    # 13: sports, exercise, & recreation
    # 14: religious/spiritual
    # 15: volunteer
    # 16: telephone

atustrans19_t1 <- filter(atustrans19_t1, trcode >= 180101 & trcode <= 181699)

atustrans19_t1_wa <- filter(atustrans19_t1, prtage >= 18 & prtage <= 65)

atustrans19_t1_wa %>% calc_cro_cpct_responses(tutier2code, prdisflg, weight = tufinlwgt)
