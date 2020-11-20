#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)

NEI = readRDS(file = "summarySCC_PM25.rds")
data = NEI %>% group_by(year) %>% summarize(Total.Emissions=sum(Emissions))

png(file="plot1.png") 
plot(x=data$year,y=data$Total.Emissions, pch=20, cex=1.5, col="green", xlab="Year", ylab="Total Emissions")
title(main = "Total emissions from PM2.5 in the US btw 1999 and 2008")
dev.off()