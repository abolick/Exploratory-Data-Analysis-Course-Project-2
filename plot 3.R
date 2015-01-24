##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##which of these four sources have seen decreases in emissions from 1999-2008 for 
##Baltimore City? 
##Which have seen increases in emissions from 1999-2008? 
##Use the ggplot2 plotting system to make a plot answer this question.

##load the NEI and SCC data frames from the .rds files
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##subset NEI by Baltimore City's fip
BaltimoreCity <-subset(NEI, fips =="24510")

##aggregate Baltimore emissions by year
aggBaltimoreCity <- aggregate(Emissions ~ year, BaltimoreCity, sum)

## create .png file
png("plot3.png", width=680, height=480)

library(ggplot2)

g <-  ggplot(BaltimoreCity, aes(factor(year),Emissions, fill=type, color=type)) +
        geom_line(size = 2) +
        theme_bw()  + guides(fill=FALSE) +
        facet_grid(.~type) +
        labs(x="Year", y=expression("Total PM"[2.5]*"Emission(Tons)")) +
        labs(title=expression("Baltimore City PM"[2.5]*"Emissions by Source Type (1999-2008)"))
               
print(g)

dev.off()