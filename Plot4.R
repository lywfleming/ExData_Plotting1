# Using the Individual household electric power consumption Data Set from the 
# UC Irvine Machine Learning Repository, extract the Feb. 1 and 2, 2007 data, remove
# the invalid data represented as "?", create four plots on a single page: 1) plot
# the histogram of the Global Active Power, 2) Date-time (Feb. 1 and 2, 2007) vs.
# Voltage, 3) Date-time (Feb. 1 and 2, 2007) vs. three sub metering data,
# 4) Date-time (Feb. 1 and 2, 2007) vs. Global reactive power. Save to "plot4.png".

file <- "household_power_consumption.txt"

data <- read.csv2(file, na.strings="?", colClasses = "character")

# Extract the data from 2/1/07 through 2/2/07

Date.start <- as.Date("2007-02-01")
Date.end <- as.Date("2007-02-02")

data.feb <- data[(as.Date(data$Date, "%d/%m/%Y") == Date.start | as.Date(data$Date, "%d/%m/%Y") == Date.end),]

# Take care of any invalid data

good_data <-data.feb[complete.cases(data.feb),]

# Combine the "Date" and "Time" character data columns and convert to the
# POSIXlt/POSIXct date-time format for plotting purposes.

date.time <- strptime(paste(good_data$Date,good_data$Time), "%d/%m/%Y %H:%M:%S")

dev.copy(png, file = "plot4.png")

par(mfrow = c(2,2), mar = c(4,4,3,3))

plot(date.time, good_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(date.time, good_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

with(good_data, plot(date.time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
  lines(date.time, good_data$Sub_metering_1)
  lines(date.time, good_data$Sub_metering_2, col = "red")
  lines(date.time, good_data$Sub_metering_3, col = "blue")
  legend("topright", lty = 1, bty = "n", cex = .75, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(date.time, good_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
