library(chron)
library(cluster)
library(data.table)
library(devtools)
library(expss)
library(factoextra)
library(ggplot2)
library(gridExtra)
library(haven)
library(Hmisc)
library(janitor)
library(lubridate)
library(magrittr)
library(mltools)
library(mudata2)
library(naniar)
library(psych)
library(readr)
library(RM.weights)
library(sjlabelled)
library(spatstat)
library(stats)
library(stringr)
library(survey)
library(tidyverse)



# port to spss
write_sav(atus20_travel, "C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/atus20travel3159.sav")

# and to sas
write_sas(gbtm2, "C:/Users/css81/OneDrive - University of Pittsburgh/EPIDEM 2189/hw/hw 4/gbtm2.sas7bdat")

# write to csv
write_csv(gbtm2, "C:/Users/css81/OneDrive - University of Pittsburgh/EPIDEM 2189/hw/hw 4/gbtm2.csv")

# replace values with nulls
data <- as_tibble(data %>% replace_with_na(replace = list(variable_with_nuls = c(-3, -2, -1)))) 

# rename cols
data <- as_tibble(rename(data, newcol = oldcol, newcol2 = oldcol2))

# order alphabetically
data <- data %>% select(order(colnames(data)))

# check for dupes
sum(duplicated(data$col))

# remove dupe values in a col (reduces # of rows)
data <- data[!duplicated(data$col), ]

# Add col of all 1's
data$newcol_1 <- c(1)

# create agg sum col
newdata <- aggregate(data$continous_col, list(data$id_col), sum)

# merge tables based on 1 col
# cols do not need to have the same name
newdata<- merge(x=data1, y=data2, by.x = "col1", by.y="col1", all.x= TRUE)
#merge tables based on multi cols
newdata <- merge(x=data1, y=data2, by = c("col1", "col2"), all = TRUE)

# create bins


# remove dupe values
data <- data[!duplicated(data$column), ]

# replace a value across an entire df
df[df == "Old Value"] <- "New Value"

# replace a value in one col
df["Column Name"][df["Column Name"] == "Old Value"] <- "New Value"