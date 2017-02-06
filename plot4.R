

setwd("~/Cathy/Coursera R Programming/Exploratory Data Analysis")

## read in the dataset
poweruse <- read.table("household_power_consumption.txt", sep=";", header = TRUE,
                       colClasses = c("character","character",
                                      "numeric","numeric","numeric",
                                      "numeric","numeric","numeric","numeric"),
                       na.strings=c("?"))


## Install dplyr library
library(dplyr)

## Convert Date to a Date class

datev <- as.Date(poweruse$Date, "%d/%m/%Y")

## Combine time and date characters and convert to a POSIXct variable
datetime <- as.POSIXct(paste(poweruse$Date, poweruse$Time), "%d/%m/%Y %H:%M:%S", tz="GMT")

## Construct a dataframe consisting of Date, timestamp, Sub_metering_1, Sub_metering_2,
##       , Sub_metering_3
poweruse2 <- data.frame("Date" = datev,
                  "timestamp" = datetime,
                  "Global_active_power" = poweruse$Global_active_power,
                  "Voltage" = poweruse$Voltage,
                  "Global_reactive_power" = poweruse$Global_reactive_power,
                  "Sub_metering_1" = poweruse$Sub_metering_1,
                  "Sub_metering_2" = poweruse$Sub_metering_2,
                  "Sub_metering_3" = poweruse$Sub_metering_3)                


## Filter based on desired dates
poweruse2day <- filter(poweruse2, 
                       Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))


## Open png device and create file in working directory 
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

## Chart 1 - Global Active Power over Time
## Create plot of Global Active Power vs. Time
plot(poweruse2day$timestamp, poweruse2day$Global_active_power, pch = NA, 
     xlab="", ylab="Global Active Power")
## Add line to chart
lines(x=poweruse2day$timestamp, y=poweruse2day$Global_active_power)

## Chart 2 - Voltage over time
## Create plot of Voltage vs. Time
plot(poweruse2day$timestamp, poweruse2day$Voltage, pch = NA, 
     xlab="datetime", ylab="Voltage")
## Add line to chart
lines(x=poweruse2day$timestamp, y=poweruse2day$Voltage)

## Chart 3 - Sub-metering
## Create plot of Global Active Power vs. Time
plot(poweruse2day$timestamp, poweruse2day$Sub_metering_1, pch = NA, 
     xlab="", ylab="Energy sub metering")
## Add line to chart for each of the variables
lines(x=poweruse2day$timestamp, y=poweruse2day$Sub_metering_1)
lines(x=poweruse2day$timestamp, y=poweruse2day$Sub_metering_2, col="red")
lines(x=poweruse2day$timestamp, y=poweruse2day$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


## Chart 4 Global_inactive_power over time
plot(x=poweruse2day$timestamp, y=poweruse2day$Global_reactive_power, pch = NA, 
     xlab="datetime", ylab="Global_reactive_power")
## Add line to chart
lines(x=poweruse2day$timestamp, y=poweruse2day$Global_reactive_power)


## Close graphics device
dev.off()
