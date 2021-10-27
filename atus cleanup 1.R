
library(lubridate)
library(magrittr)

per<- as_tibble(perpub)



per <- per %<>% mutate(TDAYDATE = as.character(TDAYDATE)) 


per <- per %>% mutate(TDAYDATE = as.Date(TDAYDATE, format = "%Y%M"))

str(per$TDAYDATE)
