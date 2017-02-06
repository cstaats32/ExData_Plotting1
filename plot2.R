

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

## Construct a dataframe consisting of Date, timestamp, Global Active Power
poweruse2 <- data.frame("Date" = datev,
                  "timestamp" = datetime,
                  "Global_active_power" = poweruse$Global_active_power)                


## Filter based on desired dates
poweruse2day <- filter(poweruse2, 
                       Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))


## Open png device and create file in working directory 
png(filename = "plot2.png", width = 480, height = 480)

## Create plot of Global Active Power vs. Time
plot(poweruse2day$timestamp, poweruse2day$Global_active_power, pch = NA, 
     xlab="", ylab="Global Active Power (kilowatts)")

## Add line to chart
lines(x=poweruse2day$timestamp, y=poweruse2day$Global_active_power)


## Close graphics device
dev.off()
