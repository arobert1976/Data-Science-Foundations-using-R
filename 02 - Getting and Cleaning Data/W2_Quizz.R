## Example of code to read data from an API using httr
q1 <- function(){
    library(httr)
    library(httpuv)
    library(jsonlite)
    oauth_endpoints("github")
    ## my_github_app is an OAuth application created from GitHub 
    myapp <- oauth_app("my_github_app",
                       key = "3e6c28c7902a5e354b99",
                       secret = "8a2b69a8752c19af26aba3fc8afced5c27f263d0",
                       redirect_uri = "http://localhost:1410"
    )
    github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
    gtoken <- config(token = github_token)
    req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
    stop_for_status(req)
    json1 <- content(req)
    json2 <- jsonlite::fromJSON(toJSON(json1)) ##json2 is a data.frame
    ##return the "datasharing" repo creation date
    json2[which(json2$name=='datasharing'),]$created_at
}

# Example of code to read data using SQL
q2 <- function(){
  library(sqldf) #this library allows to use SQL against a dataframe
  if(!file.exists("data")) dir.create("data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  fileName <- "data/ACS_25082020.csv"
  download.file(url = fileUrl, destfile = fileName)
  acs <- read.csv(fileName)
  acs_subset <- sqldf("select pwgtp1 from acs where AGEP<50")
  acs_subset
}

# Example of code to read data using SQL
q3 <- function(){
  library(sqldf)
  if(!file.exists("data")) dir.create("data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  fileName <- "data/ACS_25082020.csv"
  download.file(url = fileUrl, destfile = fileName)
  acs <- read.csv(fileName)
  acs_subset_sql <- sqldf("select distinct AGEP from acs")
  print(acs_subset_sql)
  acs_subset_R <- unique(acs$AGEP)
  print(acs_subset_R)
}

q4 <- function(){
    con = url("http://biostat.jhsph.edu/~jleek/contact.html")
    htmlCode = readLines(con)
    close(con)
    print(paste("the 10th line length is : ", nchar(htmlCode[10])))
    print(paste("the 20th line length is : ", nchar(htmlCode[20])))
    print(paste("the 30th line length is : ", nchar(htmlCode[30])))
    print(paste("the 40th line length is : ", nchar(htmlCode[40])))
}

## Example of code to read Fixed Width Format text file
q5 <- function(){
    if(!file.exists("data")) dir.create("data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
    fileName <- "data/wksst8110.for"
    download.file(url = fileUrl, destfile = fileName)
    df = read.fwf("data/wksst8110.for", widths = c(1,9,5,4,4,5,4,4,5,4,4,5,4,4))
    df[, 7] <- as.numeric(df[, 7])
    sum(df[,7], na.rm = TRUE)
}