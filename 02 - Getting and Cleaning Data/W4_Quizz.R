q1 <- function(){
  if(!file.exists("data")) dir.create("data")
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  fileName <- "data/ss06hid_03092020.csv"
  download.file(url = fileUrl, destfile = fileName)
  df <- read.csv(fileName)
  strsplit(names(df), "wgtp")[123] ##retourne [[1]] [1] ""   "15"
}

q2 <- function(){
  if(!file.exists("data")) dir.create("data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  fileName <- "data/FGDP_03092020.csv"
  download.file(url = fileUrl, destfile = fileName)
  fgdp <- read.csv(fileName, skip=4)
  ## Keeping on the 190 countries with GDP ranking
  fgdp[, 2] <- as.numeric(fgdp[, 2])
  fgdp.f = fgdp[which(fgdp$X.1>=1 & fgdp$X.1<=190),]
  ## Removing the commas from the GDP numbers and calculate the mean
  mean(as.numeric(gsub(",", "", fgdp.f$X.4)))
}

q3 <- function(){
  if(!file.exists("data")) dir.create("data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  fileName <- "data/FGDP_03092020.csv"
  download.file(url = fileUrl, destfile = fileName)
  fgdp <- read.csv(fileName, skip=4)
  ## Keeping on the 190 countries with GDP ranking
  fgdp[, 2] <- as.numeric(fgdp[, 2])
  fgdp.f = fgdp[which(fgdp$X.1>=1 & fgdp$X.1<=190),]
  ## Counting the number of countries whose name start with United
  length(grep("^United", fgdp.f$X.3))
}

q4 <- function(){
  if(!file.exists("data")) dir.create("data")
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  fileName = "data/FGDP_03092020.csv"
  download.file(url = fileUrl, destfile = fileName)
  fgdp = read.csv(fileName, skip=4)
  fgdp[, 2] = as.numeric(fgdp[, 2])
  fgdp.f = fgdp[which(fgdp$X.1>=1 & fgdp$X.1<=190),] ##countries with a GDP ranking
  
  fileUrl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  fileName2 = "data/FEDSTATS_03092020.csv"
  download.file(url = fileUrl2, destfile = fileName2)
  fedstats = read.csv(fileName2)
  
  mergedDF = merge(fgdp.f, fedstats, by.x="X", by.y="CountryCode") ##only IDs that match are in the result
  
  ## Count the number of countries where fiscal end year is June
  length(mergedDF[grepl("Fiscal year end: June", mergedDF$Special.Notes),]$Special.Notes)
}

q5 = function(){
  library(quantmod)
  amzn = getSymbols("AMZN",auto.assign=FALSE)
  sampleTimes = index(amzn) ## sampleTimes is a Date vector
  y = format(sampleTimes,"%y") ## character vector where e.g. "07" means "2007"
  sum(y=="12")
  ay = format(sampleTimes,"%a-%y") ## character vector where e.g."jeu.-10" means "a Thursday in 2012"
  sum(ay=="lun.-12")
}