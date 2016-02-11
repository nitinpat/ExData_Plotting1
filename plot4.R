rm(list=ls())
mydata1 <- read.table(file = "exdata_data_household_power_consumption/household_power_consumption.txt",
                     header = TRUE, sep = ";")
mydata <- mydata1
library(lubridate)
mydata$Date <- dmy(mydata$Date)
mydata$Date <- as.Date(mydata$Date)
mydata$dt <- paste(mydata$Date, mydata$Time, sep = " ")
mydata$dtime <- as.POSIXct(mydata$dt)

actualData <- subset(mydata, (mydata$Date == "2007-02-01" | 
                                      mydata$Date == "2007-02-02"))
# 1st graph stuff
f <- actualData$Global_active_power
actualData$Global_active_power <- as.numeric(levels(f))[f]
globalActivePower <- subset(actualData, Global_active_power <= 6)


# 2nd graph stuff
f <- actualData$Voltage
actualData$Voltage <- as.numeric(levels(f))[f]


# 3rd graph stuff
f <- actualData$Sub_metering_1
actualData$Sub_metering_1 <- as.numeric(levels(f))[f]

f <- actualData$Sub_metering_2
actualData$Sub_metering_2 <- as.numeric(levels(f))[f]


# 4th graph stuff
f <- actualData$Global_reactive_power
actualData$Global_reactive_power <- as.numeric(levels(f))[f]
globalReactivePower <- subset(actualData, Global_reactive_power <= 0.5)


# plot
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# 1st graph
plot(globalActivePower$dtime, globalActivePower$Global_active_power, type="l", 
     xlab = "", ylab = "Global Active Power(kilowatts)")

# 2nd graph
plot(actualData$dtime, actualData$Voltage, type="l", 
     xlab = "datetime", ylab = "Voltage")

# 3rd graph
plot(actualData$dtime, actualData$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(actualData$dtime, actualData$Sub_metering_2, col = "red")
lines(actualData$dtime, actualData$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, cex = 0.65,  
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 4th graph
plot(globalReactivePower$dtime, globalReactivePower$Global_reactive_power, type="l", 
     xlab = "datetime", ylab = "Global Reactive Power(kilowatts)")

## Copy my plot to a PNG file
dev.copy(png, file = "ExData_Plotting1/plot4.png")
## Don't forget to close the PNG device!
dev.off()



