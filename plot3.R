# Load ggplot2 library
library(ggplot2)

# Loading data and sampling data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_sampling <- NEI[sample(nrow(NEI), size=5000, replace=F), ]

# Subsetting data

MD <- subset(NEI, fips == 24510)
MD$year <- factor(MD$year, levels=c('1999', '2002', '2005', '2008'))



# GPlotting

png(filename='plot3.png', width=800, height=500, units='px')

ggplot(data=MD, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
    geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
    ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
    ggtitle('Emissions per Type in Baltimore City, Maryland') + geom_jitter(alpha=0.10)

dev.off()
