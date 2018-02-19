library(ggplot2)
library(data.table)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")




# Gather the subset of the NEI data which corresponds to vehicles
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicle,]$SCC
vehicleNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
vehicleBaNEI <- vehicleNEI[vehicleNEI$fips=="24510",]
vehicleBaNEI$city <- "Baltimore City"

vehicleLANEI <- vehicleNEI[vehicleNEI$fips=="06037",]
vehicleLANEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
bothNEI <- rbind(vehicleBaNEI,vehicleLANEI)

png("plot6.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)
 
ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
 geom_bar(aes(fill=year),stat="identity") +
 facet_grid(scales="free", space="free", .~city) +
 guides(fill=FALSE) + theme_bw() +
 labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
 labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
 
print(ggp)

dev.off()
