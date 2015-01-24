##How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

##load the NEI and SCC data frames from the .rds files
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Find all motor vehicle sources in SCC
MVSourceDesc <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
MVSourceCodes <-  SCC[SCC$EI.Sector %in% MVSourceDesc, ]["SCC"]

##Subset motor vehicle emissions in Baltimore City
BaltimoreCityMV <-NEI[NEI$SCC %in% MVSourceCodes$SCC & NEI$fips =="24510", ]

####Calculate total motor vehicle emissions by year in Baltimore City
BaltimoreCityMVbyyr <- tapply(BaltimoreCityMV$Emissions, BaltimoreCityMV$year, sum)

## create .png file
png("plot5.png", width=480, height=480)

##plot motor vehicle emissions by year in Baltimore City
plot(BaltimoreCityMVbyyr, x = rownames(BaltimoreCityMVbyyr),
     xlab = "Year", 
     ylab = expression("Motor Vehicle Related PM"[2.5]*"Emission (Tons)"),
     type = "b",
     main = expression("Motor Vehicle Related PM"[2.5]*"Emissions in Baltimore City (1999-2008)")
)

dev.off() 