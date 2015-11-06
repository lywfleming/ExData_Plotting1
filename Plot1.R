# Using the Individual household electric power consumption Data Set from the 
# UC Irvine Machine Learning Repository, extract the Feb. 1 and 2, 2007 data, remove
# the invalid data represented as "?", plot the histogram of the Global Active Power,
# to "plot1.png".

file <- "household_power_consumption.txt"

data <- read.csv2(file, na.strings="?", colClasses = "character")

# Extract the data from 2/1/07 through 2/2/07

  Date.start <- as.Date("2007-02-01")
  Date.end <- as.Date("2007-02-02")

  data.feb <- data[(as.Date(data$Date, "%d/%m/%Y") == Date.start | as.Date(data$Date, "%d/%m/%Y") == Date.end),]

# Take care of any invalid data
  
  good_data <-data.feb[complete.cases(data.feb),]

# Plotting data needs to be numeric
  
  GlobalActivePower <- as.numeric(good_data$Global_active_power)

  dev.copy(png, file = "plot1.png")

   par(mfrow= c(1,1)) #reset plot area
  
   hist(GlobalActivePower, col = "red", breaks = 12, xlab = "Global Active Power (kilowatts)", main ="Global Active Power")

  dev.off()

