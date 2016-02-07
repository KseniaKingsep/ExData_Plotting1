# creating new directory if needed
if (!file.exists("epc_data")){ dir.create("epc_data") }

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

#plot4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(epc$DT, epc$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
plot(epc$DT, epc$Voltage, type="l", xlab = "datetime", ylab = "Voltage")
plot(epc$DT, epc$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
    lines(epc$DT, epc$Sub_metering_2, type="l", col = "red")
    lines(epc$DT, epc$Sub_metering_3, type="l", col = "blue")
    legend("topright", col=c("black","red","blue"), bty = "n", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1), lwd=c(1,1,1))
plot(epc$DT, epc$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()