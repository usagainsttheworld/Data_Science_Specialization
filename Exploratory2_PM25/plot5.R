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
# Q5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(dplyr)
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

barplot(veh_baltimore_pm25$veh_baltimore_sum, names.arg = veh_baltimore_pm25$year, main="PM2.5 from VEHICLE in Baltimore 1999 to 2008", xlab="Year", ylab="PM2.5" )
#The above plot is about the PM2.5 emissions from Vehicle related sources in Baltimore from 1999 to 2008. As we can see, the emission droped by half from 1999 to 2002 following by a smooth decrease from 2002 to 2008.
#==============================================
#Save plot in PNG file.
dev.copy(png, file="plot5.png", width=480, height=480, units="px")
dev.off()



