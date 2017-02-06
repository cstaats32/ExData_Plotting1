

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


## Construct a dataframe consisting of Date, Global Active Power
poweruse2 <- data.frame("Date" = datev,
                        "Global_active_power" = poweruse$Global_active_power)                

## Install dplyr library
library(dplyr)

## Filter based on desired dates
poweruse2day <- filter(poweruse2, 
                Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## Open png device and create file in working directory 
png(filename = "plot1.png", width = 480, height = 480)

## Create histogram of Global_active_power variable including Main title and axis labels
hist(poweruse2day$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency")

## Close graphics device
dev.off()
