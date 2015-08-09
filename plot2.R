# Install and load the required libraries if they are not present yet
pkg <- c("plyr", "dplyr")
new.pkg <- pkg[!(pkg %in% installed.packages())]
if (length(new.pkg)) {
    install.packages(new.pkg)  
}
for (package in pkg) {
    require(package, character.only = TRUE)  
}
# Remove the data from the environment as they are not needed anymore
rm(pkg,new.pkg,package)

# General code for all four plots
## Download the data if not already there
if (!file.exists("household_power_consumption.txt")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  "household_power_consumption.zip",
                  method="curl")
    unzip("household_power_consumption.zip")
}
## Read in the data
household <- read.table("household_power_consumption.txt",
                        header=TRUE,
                        sep=";",
                        na.strings="?")

## We will only be using data from the dates 2007-02-01 and 2007-02-02
householdSelection <- filter(household, Date %in% c("1/2/2007","2/2/2007"))
## convert the Date and Time column to Datetime column in POSIXt format
householdSelection$Datetime <- paste(householdSelection$Date,householdSelection$Time)
householdSelection$Datetime <- strptime(householdSelection$Datetime, "%d/%m/%Y %H:%M:%S")

#plot2
png(file="plot2.png", width=480, height=480)
plot(householdSelection$Datetime, householdSelection$Global_active_power,
     type="l", xlab="", ylab="")
title(xlab="", ylab="Global Active Power (kilowatts)")
dev.off()