downloadData <- function(destFileName) {
    if (!file.exists(destFileName)) {
        fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
        download.file(url = fileUrl, destfile = destFileName, method = "curl")
    }
}