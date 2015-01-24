##Across the United States, 
##how have emissions from coal combustion-related sources changed from 1999-2008?

##load the NEI and SCC data frames from the .rds files
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Find all coal combustion-related sources in SCC
CCSources <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal",]["SCC"]
                                                                                                                                                          
##Subset coal combustion data
emissionfromcc <- NEI[NEI$SCC %in% CCSources$SCC, ]

##Calculate total Coal emissions by year
coalemissionbyyr <-tapply(emissionfromcc$Emissions, emissionfromcc$year, sum)

## create .png file
png("plot4.png", width=480, height=480)

##plot coal emissions
plot(coalemissionbyyr, x = rownames(coalemissionbyyr),
     xlab = "Year", 
     ylab = expression("Coal Related PM"[2.5]*"Emission (Tons)"),
     type = "b",
     xaxt = "n",
     main = expression("Coal Related PM"[2.5]*"Emission across US (1999-2008)")
)
axis(side = 1 , at=seq(1999,2008,by=3))
dev.off() 