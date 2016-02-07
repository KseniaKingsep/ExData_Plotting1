# creating new directory if needed
if (!file.exists("epc_data")) { dir.create("epc_data") }

# loading the data if needed
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("epc_data/household_power_consumption.txt")){
    download.file(url, "epc_data/power.zip")
    unzip("epc_data/power.zip", exdir = "epc_data") # unpack the archive
    unlink("epc_data/power.zip") # delete archive
}
# loading and subsetting dataset
epc <- read.csv("epc_data/household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";")
epc <- epc[epc$Date == "1/2/2007" | epc$Date == "2/2/2007", ]
epc$DT <- as.POSIXct(paste(epc$Date, epc$Time), format = "%d/%m/%Y %H:%M:%S")

#plot1
png(filename = "plot1.png", width = 480, height = 480)
hist(epc$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power(kilowatts)")
dev.off()