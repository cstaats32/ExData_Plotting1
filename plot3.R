

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
                  "timestamp" = datetime, "Sub_metering_1" = poweruse$Sub_metering_1,
                  "Sub_metering_2" = poweruse$Sub_metering_2,
                  "Sub_metering_3" = poweruse$Sub_metering_3)                


## Filter based on desired dates
poweruse2day <- filter(poweruse2, 
                       Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))


## Open png device and create file in working directory 
png(filename = "plot3.png", width = 480, height = 480)

## Set up plot area
plot(poweruse2day$timestamp, poweruse2day$Sub_metering_1, pch = NA, 
     xlab="", ylab="Energy sub metering")

## Add line2 to chart for each of the variables
lines(x=poweruse2day$timestamp, y=poweruse2day$Sub_metering_1)
lines(x=poweruse2day$timestamp, y=poweruse2day$Sub_metering_2, col="red")
lines(x=poweruse2day$timestamp, y=poweruse2day$Sub_metering_3, col="blue")

legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## Close graphics device
dev.off()
