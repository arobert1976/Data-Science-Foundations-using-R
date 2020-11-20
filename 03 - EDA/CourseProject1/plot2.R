plot2 = function(){
  ## Get the raw data file and unzip it 
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
  
  ## Load the data corresponding to Thursday 2007-02-01 and Friday 2007-02-02.
  ## This means we are considering lines 66637 - 69516
  data = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings=c("?"), colClasses = c("Global_active_power"="numeric"))
  data = data[66637:69516, 1:3] ##To make this graph, we need the first 3 columns
  data$DateAndTime = strptime(paste(data[,1], data[,2]), format="%d/%m/%Y %H:%M:%S")
  
  ## Create the line plot and save it to as plot2.png
  png(file="plot2.png") ##opens PNG device. 480px x 480px is the default width and height
  with(data, plot(DateAndTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")) ## type="l" to display a line graph
  dev.off() ##closes PNG device
}