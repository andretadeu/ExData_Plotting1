source("downloadData.R")

plot2 <- function() {
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

    png(file = 'plot2.png', width = 480, height = 480, units = "px")
    plot(data$Time, data$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
    dev.off()
}

plot2()