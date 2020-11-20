#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
library(dplyr)

NEI = readRDS(file = "summarySCC_PM25.rds")
data = NEI %>% filter(fips=="24510") %>% group_by(year) %>% summarize(Total.Emissions=sum(Emissions))

png(file="plot2.png") 
plot(x=data$year,y=data$Total.Emissions, pch=20, cex=1.5, col="green", xlab="Year", ylab="Total Emissions in Baltimore")
title(main = "Emissions from PM2.5 in Baltimore from 1999 to 2008")
dev.off()