library(readr)
library(ggplot2)
library(gridExtra)
library(dplyr) # for `rename` & `select`
library(tidyr) # for `gather`
require(plotly)
packageVersion('plotly')
install.packages('Cairo')
library(Cairo)

#read data
visitors_hk <- read.csv("visitors_to_hk.csv",stringsAsFactors = F)
#draw multiple scatter plots
p <- ggplot(visitors_hk,aes(x=year,y=per_capita_spending_overnight,label=length_of_stay))+
  expand_limits(x=2011,y=0)+
  geom_point(aes(color=length_of_stay))+
  geom_text(aes(color=length_of_stay),hjust=0.5,vjust =1,check_overlap = TRUE)+
  labs(x="Year",y="Per capita spending of overnight vistiors($HKD)",title = "Does staying longer in Hong Kong mean spending more?",
       subtitle = "Staying longer in Hong Kong may not indicate that overnight visitors would spend more.\nThe highest value of per capita spending of overnight visitors from mainland China (HK$8,937 in 2013) appeared \nwhen their average length of stay was 3.4 nights.",
       caption = "Source:DATA.GOV.HK https://data.gov.hk/en-data/dataset/hk-censtatd-tablechart-visitor-statistics |Graphic made by Zhou Wenxuan")+
  theme(plot.title = element_text(color="black", size=14, face="bold",lineheight=.5),plot.subtitle = element_text(lineheight = 1.15),plot.caption = element_text(face = "italic"))+
  scale_color_gradient(name="Length of stay",low="lightskyblue", high="navyblue")+
  facet_wrap(~region,ncol = 4)
p
#interactive ggplot by plotly
p <- ggplotly(p)  
p

#upload interacitve plot
Sys.setenv("plotly_username"="zwx")
Sys.setenv("plotly_api_key"="YoOzkNsVMTWiLqVblifp")
api_create(p, filename = "overnight_capita_spending1")








  
  
