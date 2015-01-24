##Compare emissions from motor vehicle sources in Baltimore City with
##emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##Which city has seen greater changes over time in motor vehicle emissions?

##load the NEI and SCC data frames from the .rds files
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Find vehicle sources in SCC
MVSourceDesc <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
MVSourceCodes <-  SCC[SCC$EI.Sector %in% MVSourceDesc, ]["SCC"]

##Subset motor vehicle emissions in Baltimore City and Los Angeles County
BaltimoreCityMV <-NEI[NEI$SCC %in% MVSourceCodes$SCC & NEI$fips =="24510", ]
BaltimoreCityMV$city <- "Baltimore City"
LosAngelesMV <- NEI[NEI$SCC %in% MVSourceCodes$SCC & NEI$fips == "06037", ]
LosAngelesMV$city <- "Los Angeles County"

##combine both cities NEI
BCLANEI <- rbind(BaltimoreCityMV,LosAngelesMV)

## create .png file
png("plot6.png", width=480, height=480)

library(ggplot2)

##plot motor vehicle emissions by year in Baltimore City and Los Angeles
gMV <- ggplot(BCLANEI, aes(factor(year),Emissions, fill=city, color=city)) +
     geom_line(size = 2) +
     facet_grid(.~city) +
     labs(x="Year", y=expression("Total PM"[2.5]*"Emission(Tons)")) +
     labs(title=expression("Baltimore City & LA PM"[2.5]*"Motor Vehicle Emissions (1999-2008)"))

     
print(gMV)
     
dev.off()