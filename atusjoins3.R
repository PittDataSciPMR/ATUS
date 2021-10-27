
atusact19 <- select(atusact_2019, c('tucaseid', 'tuactivity_n', 'tewhere', 'tuactdur', 'tuactdur24', 'tucumdur', 'tucumdur24',
                                    'tustarttim', 'tustoptime', 'tutier1code', 'tutier2code', 'tutier2code', 'trcode',
                                    'trtier2'))
atusact19 <- tibble(as_numeric(atusact19, 1:7, 10:13))
atusact19$tustarttim <- times(atusact19$'tustarttim')
atusact19$tustoptime <- times(atusact19$'tustoptime')


atuscps19 <- select(atuscps_2019, c('tucaseid', 'tulineno', 'hefaminc', 'hrhhid', 'hrhhid2', 45:50, 'pecyc', 55:60,
                                    'peeduca', 'pehspnon', 'pesex', 'prdisflg', 'prtage', 'ptdtrace', 205:207, 
                                    'pulineno', 'qstnum', 'prdasian'))

atuscps19 <- tibble(as_numeric(atuscps19))

atusresp19 <- select(atusresp_2019, 102, 'tulineno', 93:96, 'telfs', 'trtalone', 'trtalone_wk', 'tucaseid')

atusresp19 <- tibble(as_numeric(atusresp19))

atus_act_cps_19 <- merge(x=atusact19, y=atuscps19, by.x = "tucaseid", by.y="tucaseid", all.x =true)

atusactcpsresp19 <- merge(x=atusresp19, y=atus_act_cps_19, by.x = "tucaseid", by.y="tucaseid", all.x =true)




library(sjlabelled)
write_spss(atus, "C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/atus19.sav")

write_csv(atus_act_cps_19, "C:/Users/css81/OneDrive - University of Pittsburgh/NHTS/ATUS/atus_act_cps_19.csv")
