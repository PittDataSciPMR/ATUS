# pull not tulineno = 1
# characteristics of people with disabilities who live alone
# Live with other adults
# Live with children

# create agg sum col of tulineno
atuscps19_tulesum <- aggregate(atuscps19$tulineno, list(atuscps19$tucaseid), sum)

# live alone IDs
atuscps19_livealone <- filter(atuscps19_tulesum,  x == 1)

# rename columns
atuscps19_livealone <- rename(atuscps19_livealone, tucaseid = Group.1, live_alone = x)

# live with others IDs
atuscps19_livewithothers <- filter(atuscps19_tulesum,  x > 1)

# rename columns
atuscps19_livewithothers <- rename(atuscps19_livewithothers, tucaseid = Group.1, live_others = x)

# add flag indicating they live with others
atuscps19_livewithothers$live_others <- c(1)

# bring back together
atuscps19_livestatus <- merge(x=atusact19, y=atuscps19, by.x="tucaseid", by.y ="tucaseid")