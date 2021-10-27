# Combine
# might be something wrong with this
# tulineno == 1

atus19main <- merge(x=atuswho19, y=atusresp19, by= c("tucaseid", "tulineno"))

atus19main <- merge(x=atus19main, y=atuscps19, by= c("tucaseid", "tulineno"))

atus19main <- merge(x=atus19main, y=atusact19, by= c("tucaseid", "tulineno", "tuactivity_n"))

# order alphabetically
atus19main <- atus19main %>% select(order(colnames(atus19main)))

atus19main <- as_tibble(atus19main)
