#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)
library(ggplot2)

NEI = readRDS(file = "summarySCC_PM25.rds")
SCC = readRDS(file = "Source_Classification_Code.rds")

motor = grep("Motor Vehicle", SCC$Short.Name, ignore.case = TRUE) #20 distinct motor vehicle sources in SCC
motor_SCC = SCC[motor,]
data = NEI %>% filter(SCC %in% motor_SCC$SCC) %>% filter(fips=="24510") %>% group_by(year) %>% summarize(Total.Emissions=sum(Emissions))


png(file="plot5.png") 
qplot(year, Total.Emissions, data=data, geom=c("point")) + geom_text(aes(label=Total.Emissions),hjust=0, vjust=-1, size=2) + labs(title="Motor vehicle emissions in Baltimore")
dev.off()
