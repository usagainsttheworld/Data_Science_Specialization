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
#It's been noticed that "Polutant" variable has 0 various (only one value through the dataset) so it was removed from the data set.
pm25<-subset(rawdata, select = -c(Pollutant))
#To get a closer look at "scc" data set (Source_Classification_Code). "SCC", "Short.Name", "EI.Sector", "SCC.Level.One", "SCC.Level.Two", "SCC.Level.Three", "SCC.Level.Four" are the variables related to this study so only these variables are kept for further analysis.
scc<-subset(rawscc, select = c(SCC, Short.Name, EI.Sector, SCC.Level.One, SCC.Level.Two, SCC.Level.Three, SCC.Level.Four))
#============================================
#Q3 Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
library(dplyr)
#To check which variables are related to "Coal" sources in scc data set
table(grepl("Coal", scc$Short.Name))#230 (matches)
table(grepl("Coal", scc$EI.Sector))#99
table(grepl("Coal", scc$SCC.Level.One))
table(grepl("Coal", scc$SCC.Level.Two))
table(grepl("Coal", scc$SCC.Level.Three))#172
table(grepl("Coal", scc$SCC.Level.Four))#126
#To check for "Coal" only in other variables but not in "Short.Name" variable. 
Coal_notin_shortName<-scc[!grepl("Coal", scc$Short.Name), ]
table(grepl("Coal", Coal_notin_shortName$EI.Sector)) #12
table(grepl("Coal", Coal_notin_shortName$SCC.Level.Three)) 
table(grepl("Coal", Coal_notin_shortName$SCC.Level.Four))
#As shown above, there are 12 observations that are "Coal" related in the "EI.Sector" variable but not in the "Short.Name" variable. So the "Coal" related variable are both "Short.Name"(230 observations) and "EI.Sector"(12 observations)
SNrow_coal<-scc[grep("Coal", scc$Short.Name), ] #rows are "coal"related from Short.Name
SNrow_coal$SCC<-as.character(SNrow_coal$SCC) #convert SCC variable to characer
SNrow_coal$SCC #coal related SCC from Short.Name!
EIrow_coal<-Coal_notin_shortName[grep("Coal", Coal_notin_shortName$EI.Sector), ] #rows are "coal"related from EI.Sector
EIrow_coal$SCC<-as.character(EIrow_coal$SCC)
EIrow_coal$SCC# coal related SCC from EI.Sector!

coal_year_pm25<-pm25 %>% 
        filter(SCC %in% SNrow_coal$SCC | SCC %in% EIrow_coal$SCC ) %>%
        group_by(year) %>%
        summarize(coal_yearsum=sum(Emissions))
#To make panel plot (one plot for each type so there will be 4 plots).
barplot(coal_year_pm25$coal_yearsum, names.arg = year_pm25$year, main="PM2.5 from COAL in the U.S. from 1999 to 2008", xlab="Year", ylab="PM2.5" )
#The above plot is about the PM2.5 emissions from COAL related sources in U.S. from 1999 to 2008. As we can see, the emission went smoothly from 1999 to 2005 following by a shape decrease between 2005 and 2008.
#==============================================
#Save plot in PNG file.
dev.copy(png, file="plot4.png", width=480, height=480, units="px")
dev.off()

        






















