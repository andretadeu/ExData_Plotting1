source("downloadData.R")

plot4 <- function() {
    destFileName <- 'household_power_consumption.zip'
    innerFileName <- 'household_power_consumption.txt'
    downloadData(destFileName)
    
    # Reading, filtering and cleaning data
    rawData <- read.csv(unz(destFileName, innerFileName), sep = ";", dec = '.', na.strings=c(NA, '?'))
    rawData$Time <- as.POSIXct(strptime(paste(rawData$Date, rawData$Time, sep = " "), "%d/%m/%Y %H:%M:%S"))
    rawData$Date <- as.Date(rawData$Date, format = "%d/%m/%Y")
    initialDate <- as.Date('2007-02-01')
    finalDate <- as.Date('2007-02-02')
    data <- rawData[(rawData$Date >= initialDate & rawData$Date <= finalDate),]
    
    png(file = 'plot4.png', width = 480, height = 480, units = "px")
    par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
    with(data, {
        plot(data$Time, data$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
        plot(data$Time, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
        plot(data$Time, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
        lines(data$Time, data$Sub_metering_1, col = "black")
        lines(data$Time, data$Sub_metering_2, col = "orangered")
        lines(data$Time, data$Sub_metering_3, col = "blue")
        legend("topright", lty = 1, col = c("black", "orangered", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8, bty = "n")
        plot(data$Time, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = 'l')
    })
    dev.off()
}

plot4()