# Using the Individual household electric power consumption Data Set from the 
# UC Irvine Machine Learning Repository, extract the Feb. 1 and 2, 2007 data, remove
# the invalid data represented as "?", create a line plot of the Global Active Power
# (y-axis) vs. date-time (x-axis) for the two days and save to "plot2.png".

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

dev.copy(png, file = "plot2.png")

par(mfrow= c(1,1)) #reset plot area

plot(date.time, good_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()
