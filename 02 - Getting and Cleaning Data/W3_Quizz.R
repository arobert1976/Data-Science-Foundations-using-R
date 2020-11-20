q1 <- function(){
  library(dplyr)
  if(!file.exists("data")) dir.create("data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  fileName <- "data/ACS_2006Survey_01092020.csv"
  download.file(url = fileUrl, destfile = fileName)
  acs <- read.csv(fileName)
  ##Create a logical vector where TRUE if ACR==3 & AGS==6, FALSE otherwise 
  agricultureLogical = with(acs, ACR==3 & AGS==6) 
  which(agricultureLogical) ##125  238  262 ...
}

q2 <- function(){
  library(jpeg)
  if(!file.exists("data")) dir.create("data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
  fileName <- "data/jeff.jpg"
  download.file(url = fileUrl, destfile = fileName, mode="wb")
  jeff <- readJPEG(fileName, native=TRUE)
  ## 30th and 80th quantiles of the resulting data
  quantile(jeff, probs=c(0.3, 0.8))
}

q3 <- function(){
  if(!file.exists("data")) dir.create("data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  fileName <- "data/FGDP_01092020.csv"
  download.file(url = fileUrl, destfile = fileName)
  fgdp <- read.csv(fileName, skip=4)
  fgdp[, 2] <- as.numeric(fgdp[, 2])
  fgdp.f = fgdp[which(fgdp$X.1>=1 & fgdp$X.1<=190),] ##countries with a GDP ranking
  
  fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  fileName2 <- "data/FEDSTATS_01092020.csv"
  download.file(url = fileUrl2, destfile = fileName2)
  fedstats <- read.csv(fileName2)
  
  mergedDF = merge(fgdp.f, fedstats, by.x="X", by.y="CountryCode") ##only IDs that match are in the result
  mergedDF = mergedDF[order(desc(mergedDF$X.1), na.last=TRUE),]
  n = nrow(mergedDF) ##nb of matching IDs
  print(n)
  country_13 = mergedDF[13,4] ##Name of the 13 the country
  print(country_13)
}

q4 <- function(){
  if(!file.exists("data")) dir.create("data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  fileName <- "data/FGDP_01092020.csv"
  download.file(url = fileUrl, destfile = fileName)
  fgdp <- read.csv(fileName, skip=4)
  fgdp[, 2] <- as.numeric(fgdp[, 2]) ##GDP ranking conversion to numeric
  fgdp.f = fgdp[which(fgdp$X.1>=1 & fgdp$X.1<=190),] ##countries with a GDP ranking
  
  fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  fileName2 <- "data/FEDSTATS_01092020.csv"
  download.file(url = fileUrl2, destfile = fileName2)
  fedstats <- read.csv(fileName2)
  
  mergedDF = merge(fgdp.f, fedstats, by.x="X", by.y="CountryCode") ##only IDs that match are in the result
  m1 = mean(mergedDF[mergedDF$Income.Group=="High income: OECD","X.1"])
  m2 = mean(mergedDF[mergedDF$Income.Group=="High income: nonOECD","X.1"])
  print(m1)
  print(m2)
}

q5 <- function(){
  if(!file.exists("data")) dir.create("data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  fileName <- "data/FGDP_01092020.csv"
  download.file(url = fileUrl, destfile = fileName)
  fgdp <- read.csv(fileName, skip=4)
  fgdp[, 2] <- as.numeric(fgdp[, 2]) ##GDP ranking conversion to numeric
  fgdp.f = fgdp[which(fgdp$X.1>=1 & fgdp$X.1<=190),] ##countries with a GDP ranking
  
  fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  fileName2 <- "data/FEDSTATS_01092020.csv"
  download.file(url = fileUrl2, destfile = fileName2)
  fedstats <- read.csv(fileName2)
  
  mergedDF = merge(fgdp.f, fedstats, by.x="X", by.y="CountryCode") ##only IDs that match are in the result
  n = mergedDF[(mergedDF$Income.Group=="Lower middle income" & mergedDF$X.1<=38),1:5]
  print(n)
}

