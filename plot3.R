mydata <- read.table(file = "exdata_data_household_power_consumption/household_power_consumption.txt",
                     header = TRUE, sep = ";")
library(lubridate)
mydata$Date <- dmy(mydata$Date)
mydata$Date <- as.Date(mydata$Date)
mydata$dt <- paste(mydata$Date, mydata$Time, sep = " ")
mydata$dtime <- as.POSIXct(mydata$dt)

actualData <- subset(mydata, (mydata$Date == "2007-02-01" | 
                                      mydata$Date == "2007-02-02"))

f <- actualData$Sub_metering_1
actualData$Sub_metering_1 <- as.numeric(levels(f))[f]

f <- actualData$Sub_metering_2
actualData$Sub_metering_2 <- as.numeric(levels(f))[f]

plot(actualData$dtime, actualData$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(actualData$dtime, actualData$Sub_metering_2, col = "red")
lines(actualData$dtime, actualData$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1,  
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy my plot to a PNG file
dev.copy(png, file = "ExData_Plotting1/plot3.png")
## Don't forget to close the PNG device!
dev.off()
