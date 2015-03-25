#Explore fine particulate matter(PM2.5) level in US over the 10-year period (1999, 2002, 2005, 2008). Data is from EPA National Emissions Inventory web site. 
#Load data
setwd("~/Desktop/Coursera/Exploratory2_PM25")
rawdata<-readRDS("summarySCC_PM25.rds")
rawscc<-readRDS("Source_Classification_Code.rds")
#============================================
#Cleaning data
#Convert "year", "type", and "Pollutant" variables into factor variable
rawdata$year<-as.factor(rawdata$year)
rawdata$type<-as.factor(rawdata$type)
rawdata$Pollutant<-as.factor(rawdata$Pollutant)
summary(rawdata)
#It's been noticed that "Polutant" variable has no various (only one value through the dataset) so it was removed from the data set.
pm25<-subset(rawdata, select = -c(Pollutant))
#To get a closer look at "scc" data set (Source_Classification_Code). "SCC", "Short.Name", "EI.Sector", "SCC.Level.One", "SCC.Level.Two", "SCC.Level.Three", "SCC.Level.Four" are the variables related to this study so only these variables are kept for further analysis.
scc<-subset(rawscc, select = c(SCC, Short.Name, EI.Sector, SCC.Level.One, SCC.Level.Two, SCC.Level.Three, SCC.Level.Four))
#============================================
# Q6 Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
library(dplyr)
library(ggplot2)
#To check for variables related to "motor vehicle" ("Veh" was used for searching) sources in scc data set.
table(grepl("Veh", scc$Short.Name))#1185 (matches)
table(grepl("Veh", scc$EI.Sector))#1138 
table(grepl("Veh", scc$SCC.Level.One))
table(grepl("Veh", scc$SCC.Level.Two))#1452
table(grepl("Veh", scc$SCC.Level.Three))#552
table(grepl("Veh", scc$SCC.Level.Four))#24
#To check for "Veh" only in other variables but not in "Short.Name" variable.
Veh_notin_shortName<-scc[!grepl("Veh", scc$Short.Name), ]
table(grepl("Veh", Veh_notin_shortName$EI.Sector)) #1 (matches)
table(grepl("Veh", Veh_notin_shortName$SCC.Level.Two)) #309
table(grepl("Veh", Veh_notin_shortName$SCC.Level.Three)) 
table(grepl("Veh", Veh_notin_shortName$SCC.Level.Four))
#To check whether the one match of "Veh" in EI.Sector is also in SCC.Level.Two.
grep("Veh", Veh_notin_shortName$EI.Sector) %in% grep("Veh", Veh_notin_shortName$SCC.Level.Two) 
#[1] FALSE
#As shown above, the "motor vehicle" related variable are "Short.Name"(1185 observations) plus "EI.Sector"(1 observations) plus "SCC.Level.Two" (309 observations)
SNrow_veh<-scc[grep("Veh", scc$Short.Name), ] #rows are "Veh" related from Short.Name
SNrow_veh$SCC<-as.character(SNrow_veh$SCC) #convert SCC variable to characer
SNrow_veh$SCC #"Veh" related SCC from Short.Name!

EIrow_veh<-Veh_notin_shortName[grep("Veh", Veh_notin_shortName$EI.Sector), ] #rows are "Veh" related from EI.Sector
EIrow_veh$SCC<-as.character(EIrow_veh$SCC)
EIrow_veh$SCC# "Veh" related SCC from EI.Sector!

ltwo_veh<-Veh_notin_shortName[grep("Veh", Veh_notin_shortName$SCC.Level.Two), ] #rows are "Veh" related from EI.Sector
ltwo_veh$SCC<-as.character(ltwo_veh$SCC)
ltwo_veh$SCC# "Veh" related SCC from EI.Sector!

veh_baltimore_pm25<-pm25 %>% 
        filter(SCC %in% SNrow_veh$SCC | SCC %in% EIrow_veh$SCC | SCC %in% ltwo_veh$SCC) %>% #to get rows only from "Veh" related sources
        filter(fips == "24510") %>% #to get rows only from Baltimore
        group_by(year) %>% #to gourp by year
        summarize(veh_baltimore_sum=sum(Emissions)) #sum of each year within the group

veh_LA_pm25<-pm25 %>% 
        filter(SCC %in% SNrow_veh$SCC | SCC %in% EIrow_veh$SCC | SCC %in% ltwo_veh$SCC) %>% #to get rows only from "Veh" related sources
        filter(fips == "06037") %>% #to get rows only from LA
        group_by(year) %>% #to gourp by year
        summarize(veh_LA_sum=sum(Emissions)) #sum of each year within the group

par(mfrow=c(1,2), mar=c(5,5,2,1))
barplot(veh_baltimore_pm25$veh_baltimore_sum, names.arg = veh_baltimore_pm25$year, main="PM2.5 from VEHICLE in Baltimore 1999-2008", xlab="Year", ylab="PM2.5" )
barplot(veh_LA_pm25$veh_LA_sum, names.arg = veh_LA_pm25$year, main="PM2.5 from VEHICLE in LA 1999-2008", xlab="Year", ylab="PM2.5" )
#The above plot is about the PM2.5 emissions from Vehicle related sources in Baltimore and in LA from 1999 to 2008. At first glance, the overal level of PM2.5 is much higher (almost 20 times higher) in LA (aorund 7000) than in Baltimore (below 400) over the 10-year period. To take a closer look, it has been noticed that in Baltimore, the emission started at 400 in year 1999 and droped by half by 2002. Then the level went smoothly between 2002 and 2005, following by a decrease to around 150 by the year of 2008 . One the other hand, the PM2.5 emission in LA starts at over 6000 in the year 1999 and had an increase over the flowing 6 years to over 7000. Fourtunately, the level droped back in 2008 to almost the same but slighly higher comparied with 10 years ago.

#==============================================
#Save plot in PNG file.
dev.copy(png, file="plot6.png", width=980, height=580, units="px")
dev.off()



