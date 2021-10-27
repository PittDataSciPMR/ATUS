# Pull tuecaseid and trcode to find people who did not travel
# pull all cases
# dummy variable inserted in excel (ask Matt)

atus19_dummytravel<- select(atusact19_wgt, 'tucaseid','tutier1code',
                            'tewhere', 'trcode')
