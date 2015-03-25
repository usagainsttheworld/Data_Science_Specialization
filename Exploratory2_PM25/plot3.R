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
# Q3 Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
library(dplyr)
library(ggplot2)
baltimore_type_pm25<-pm25 %>% 
        filter(fips == "24510") %>%
        group_by(type, year) %>%
        summarize(bal_type_yearsum=sum(Emissions))
#To make panel plot (one plot for each type so there will be 4 plots).
qplot(year, bal_type_yearsum, data = baltimore_type_pm25, facets = .~type, main="PM2.5 emissions from 1999–2008 in Baltimore by Source type") 
#The above plot is about the difference between the four types of PM2.5 emissions in Baltimore from 1999 to 2008. As we can see, the "POINT" variable had increased over four times from 1999 to 2005, than droped by 2008 to a slightly higher level compared with 10 years ago. All the other three variables ("NON-ROAD","NONPOINT", "ON-ROAD") were decreased over the 10-year period.
#==============================================
#Save plot in PNG file.
dev.copy(png, file="plot3.png", width=480, height=480, units="px")
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

