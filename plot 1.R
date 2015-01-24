##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##Using the base plotting system, make a plot showing the total PM2.5 emission from 
##all sources for each of the years 1999, 2002, 2005, and 2008.

##load the NEI and SCC data frames from the .rds files
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##aggregate totals
agg <- aggregate(Emissions ~ year,NEI, sum)

## create .png file
png("plot1.png", width=480, height=480)

##use base plotting system to plot Total PM2.5 Emission from all sources
plot(agg$year, agg$Emissions/10^6,
    xlab="Year",
    ylab="PM2.5 Emissions(10^6 Tons)",
    type = "b",
    main="Total PM2.5 Emissions From All Sources",
    xaxt = "n"
      )
axis(side = 1 , at=seq(1999,2008,by=3))

  dev.off() 