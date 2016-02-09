mydata <- read.table(file = "exdata_data_household_power_consumption/household_power_consumption.txt",
                   header = TRUE, sep = ";")
library(lubridate)
mydata$Date <- dmy(mydata$Date)
mydata$Date <- as.Date(mydata$Date)
actualData <- subset(mydata, (mydata$Date == "2007-02-01" | 
                                      mydata$Date == "2007-02-02"))
f <- actualData$Global_active_power
actualData$Global_active_power <- as.numeric(levels(f))[f]
globalActivePower <- subset(actualData, Global_active_power <= 6)
histogram <- hist(globalActivePower$Global_active_power)

histogram$breaks <-  c(0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6)
plot(histogram, main = "Global Active Power", 
     col = "red", xlab = "Global Active Power(kilowatts)",
     xlim = c(0, 6), ylim = c(0, 1200))

## Copy my plot to a PNG file
dev.copy(png, file = "ExData_Plotting1/plot1.png")
## Don't forget to close the PNG device!
dev.off()
