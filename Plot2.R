# Loading and sampling data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_sampling <- NEI[sample(nrow(NEI), size=5000, replace=F), ]

# Subsetting data
MD <- subset(NEI, fips=='24510')

# Plotting

png(filename='plot2.png')

barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum), main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))

dev.off()
