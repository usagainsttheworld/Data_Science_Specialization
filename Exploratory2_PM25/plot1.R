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
# Q1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)
year_pm25<-pm25 %>% 
        group_by(year) %>%
        summarize(yearsum=sum(Emissions))
barplot(year_pm25$yearsum, names.arg = year_pm25$year, col = "lightblue", main="PM2.5 in the United States from 1999 to 2008", xlab="Year", ylab="PM2.5" )
#The above plot is about the PM2.5 level in the U.S. from 1999 to 2008. As we can see, there is a decreas in PM2.5 in the U.S. over this 10-year period.
#==============================================
#Save plot in PNG file.
dev.copy(png, file="plot1.png", width=480, height=480, units="px")
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

