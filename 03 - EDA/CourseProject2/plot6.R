#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

NEI = readRDS(file = "summarySCC_PM25.rds")
SCC = readRDS(file = "Source_Classification_Code.rds")

motor = grep("Motor Vehicle", SCC$Short.Name, ignore.case = TRUE) #20 distinct motor vehicle sources in SCC
motor_SCC = SCC[motor,]
data = NEI %>% filter(SCC %in% motor_SCC$SCC) %>% filter(fips=="24510" | fips=="06037") %>% group_by(year, fips) %>% summarize(Total.Emissions=sum(Emissions))

png(file="plot6.png")
qplot(year, Total.Emissions, data=data) + geom_point(aes(color=fips), size=4, alpha=1/2) + labs(title="Comparison Baltimore (24510) vs LA (06037)")
dev.off()
