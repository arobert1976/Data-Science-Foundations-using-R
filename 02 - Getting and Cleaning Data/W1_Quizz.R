q1 <- function() {
    if(!file.exists("data")) dir.create("data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    fileName <- "data/USCommunities_21082020.csv"
    download.file(url = fileUrl, destfile = fileName)
    df <- read.csv(fileName, header = TRUE, sep = ",", quote = "")
    length(which(df$VAL==24)) ## counts the nb of elements with the velue 24 in the vector df$VAL    
}

q3 <- function() {
    if(!file.exists("data")) dir.create("data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
    fileName <- "data/NGAP_24082020.xlsx"
    download.file(url = fileUrl, destfile = fileName, mode='wb')
    rowIndex <- 18:23
    colIndex <- 7:15
    require(xlsx)
    dat <- read.xlsx("data/NGAP_24082020.xlsx", sheetIndex=1, header=TRUE, colIndex=colIndex, rowIndex=rowIndex)
    sum(dat$Zip*dat$Ext,na.rm=T)
}

q4 <- function() {
    if(!file.exists("data")) dir.create("data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
    fileName <- "data/restaurants_24082020.xml"
    download.file(url = fileUrl, destfile = fileName)
    require(XML)
    doc <- xmlTreeParse(fileName, useInternalNodes = TRUE)
    rootNode <- xmlRoot(doc)
    ## xmlName(rootNode) ## retourne response
    ## names(rootNode) ##retourne row (1 fois)
    ## rootNode[[1]][[1]][[2]] ## retourne le bloc <zipcode>...</zipcode>
    ## xmlSApply(rootNode, xmlValue) ## retourne tout le "texte" du document xml
    zipcodes <- xpathSApply(rootNode,"//zipcode",xmlValue) ## utilisation de XPath pour récupérer les valeurs de zipcode
    sum(zipcodes == "21231")
}

q5 <- function() {
    if(!file.exists("data")) dir.create("data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    fileName <- "data/ACS_25082020.csv"
    download.file(url = fileUrl, destfile = fileName)
    require(data.table)
    DT <- fread(fileName)

    ##mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15) 
    t1 <- replicate(1000, system.time({mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15)})[1])
    print(paste("mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15) :", sum(t1)/1000))

    ##sapply(split(DT$pwgtp15,DT$SEX),mean)
    t2 <- replicate(1000, system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))[1])
    print(paste("sapply(split(DT$pwgtp15,DT$SEX),mean) :", sum(t2)/1000))
    
    ##tapply(DT$pwgtp15,DT$SEX,mean 
    t3 <- replicate(1000,system.time(tapply(DT$pwgtp15,DT$SEX,mean))[1])
    print(paste("tapply(DT$pwgtp15,DT$SEX,mean :",sum(t3)/1000))
    
    ##DT[,mean(pwgtp15),by=SEX]
    t4 <- replicate(1000, system.time(DT[,mean(pwgtp15),by=SEX])[1])
    print(paste("DT[,mean(pwgtp15),by=SEX]",sum(t4)/1000))
}
    