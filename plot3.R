source("downloadData.R")

plot3 <- function() {
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
    
    png(file = 'plot3.png', width = 480, height = 480, units = "px")
    plot(data$Time, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
    lines(data$Time, data$Sub_metering_1, col = "black")
    lines(data$Time, data$Sub_metering_2, col = "orangered")
    lines(data$Time, data$Sub_metering_3, col = "blue")
    legend("topright", lty = 1, col = c("black", "orangered", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.9)
    dev.off()
}

plot3()