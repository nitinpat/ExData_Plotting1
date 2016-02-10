mydata <- read.table(file = "exdata_data_household_power_consumption/household_power_consumption.txt",
                     header = TRUE, sep = ";")

library(lubridate)
mydata$Date <- dmy(mydata$Date)
mydata$Date <- as.Date(mydata$Date)
mydata$dt <- paste(mydata$Date, mydata$Time, sep = " ")
mydata$dtime <- as.POSIXct(mydata$dt)

actualData <- subset(mydata, (mydata$Date == "2007-02-01" | 
                                      mydata$Date == "2007-02-02"))
f <- actualData$Global_active_power
actualData$Global_active_power <- as.numeric(levels(f))[f]
actualData <- subset(actualData, Global_active_power <= 6)

plot(actualData$dtime, actualData$Global_active_power, type="l")

## Copy my plot to a PNG file
dev.copy(png, file = "ExData_Plotting1/plot2.png")
## Don't forget to close the PNG device!
dev.off()
