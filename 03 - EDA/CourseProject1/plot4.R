plot4 = function(){
  ## Get the raw data file and unzip it 
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
  
  ## Load the data corresponding to Thursday 2007-02-01 and Friday 2007-02-02.
  ## This means we are considering lines 66637 - 69516
  data = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings=c("?"))
  data = data[66637:69516,] 
  data$DateAndTime = strptime(paste(data[,1], data[,2]), format="%d/%m/%Y %H:%M:%S")
  
  ## Create the 4 plots
  png(file="plot4.png") ##opens PNG device. 480px x 480px is the default width and height
  par(mfrow=c(2,2)) #2 rows, 2 cols
  ##plot 1
  with(data, plot(DateAndTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")) ## type="l" to display a line graph
  ##plot 2
  with(data, plot(DateAndTime, Voltage, type="l", xlab="datetime", ylab="Voltage")) ## type="l" to display a line graph
  ##plot 3
  plot(data$DateAndTime, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering") 
  points(data$DateAndTime, data$Sub_metering_1, type="l") 
  points(data$DateAndTime, data$Sub_metering_2, type="l", col="red") 
  points(data$DateAndTime, data$Sub_metering_3, type="l", col="blue")
  legend("topright", pch=150, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  ##plot 4
  with(data, plot(DateAndTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")) ## type="l" to display a line graph
  dev.off() ##closes PNG device
}