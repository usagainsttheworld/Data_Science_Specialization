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
# Q1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.























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

