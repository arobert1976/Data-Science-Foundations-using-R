plot1 = function(){
  ## Get the raw data file and unzip it 
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
  
  ## Load the data corresponding to Thursday 2007-02-01 and Friday 2007-02-02.
  ## This means we are considering lines 66637 - 69516
  data = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings=c("?"), colClasses = c("Global_active_power"="numeric"))
  data = data[66637:69516, 3] ##To make this histogram, we only need "Global_active_power" (3rd column)
  
  ## Create the histogram and save it to as plot1.png
  png(file="plot1.png") ##opens PNG device. 480px x 480px is the default width and height
  hist(data, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
  dev.off() ##closes PNG device
}