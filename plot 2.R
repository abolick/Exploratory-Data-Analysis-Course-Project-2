##Have total emissions from PM2.5 decreased in the 
##Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question.

##load the NEI and SCC data frames from the .rds files
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subset NEI by Baltimore City's fip
BaltimoreCity <-subset(NEI, fips =="24510")

##aggregate Baltimore emissions by year
aggBaltimoreCity <- aggregate(Emissions ~ year, BaltimoreCity, sum)

## create .png file
png("plot2.png", width=480, height=480)

plot(aggBaltimoreCity$year, aggBaltimoreCity$Emissions,
     xlab="Year",
     ylab="PM2.5 Emissions(Tons)",
     type="b",
     xaxt = "n",
     main="Total PM2.5 Emissions From Baltimore City"
  )
axis(side = 1 , at=seq(1999,2008,by=3))
dev.off()