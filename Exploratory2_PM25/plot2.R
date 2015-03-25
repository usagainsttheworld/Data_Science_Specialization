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
#============================================
# Q2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
library(dplyr)
baltimore_pm25<-pm25 %>% 
        filter(fips == "24510") %>%
        group_by(year) %>%
        summarize(bal_yearsum=sum(Emissions))

barplot(baltimore_pm25$bal_yearsum, names.arg = year_pm25$year, col = "cyan", shade=0.5, main="PM2.5 level in Baltimore from 1999 to 2008", xlab="Year", ylab="PM2.5" )
#The above plot is about the PM2.5 emissions in Baltimore from 1999 to 2008. It has been notice that there is a decrease from 1999 to 2002. During the following 3 years, the level almost rised back to the same level as 1999. However, the emissions droped significantly (by almost half) from 2005 to 2008.
#==============================================
#Save plot in PNG file.
dev.copy(png, file="plot2.png", width=480, height=480, units="px")
dev.off()

        






















table(grepl("Veh", scc$Short.Name))

FALSE  TRUE 
10532  1185

+1 of EI sector
table(grepl("Vehicle", scc$EI.Sector))
FALSE  TRUE 
10579  1138 

+309
> table(grepl("Vehicle", scc$SCC.Level.Two))
FALSE  TRUE 
10265  1452 

