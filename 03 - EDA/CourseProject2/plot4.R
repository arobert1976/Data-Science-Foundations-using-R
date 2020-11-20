#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
library(dplyr)

NEI = readRDS(file = "summarySCC_PM25.rds")
SCC = readRDS(file = "Source_Classification_Code.rds")

coal = grep("coal", SCC$Short.Name, ignore.case = TRUE) #239 distinct coal combustion-related sources in SCC
coal_SCC = SCC[coal,]
data = NEI %>% filter(SCC %in% coal_SCC$SCC) %>% group_by(year) %>% summarize(Total.Emissions=sum(Emissions))

png(file="plot4.png") 
plot(x=data$year,y=data$Total.Emissions, pch=20, xlab="Year", ylab="Total Emissions")
title(main = "Emissions from Coal Combustion btw 1999 and 2008")
dev.off()
