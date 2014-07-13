source("downloadData.R")

plot1 <- function() {
    destFileName <- 'household_power_consumption.zip'
    innerFileName <- 'household_power_consumption.txt'
    downloadData(destFileName)

    # Reading, filtering and cleaning data
    rawData <- read.csv(unz(destFileName, innerFileName), sep = ";", dec = '.', na.strings=c(NA, '?'))
    rawData$Date <- as.Date(rawData$Date, format = "%d/%m/%Y")
    initialDate <- as.Date('2007-02-01')
    finalDate <- as.Date('2007-02-02')
    data <- rawData[(rawData$Date >= initialDate & rawData$Date <= finalDate),]

    png(file = 'plot1.png', width = 480, height = 480, units = "px")
    hist(data$Global_active_power, col = "orangered", main = "Global Active Power",
         xlab = "Global Active Power (kilowatts)")
    dev.off()
}

plot1()