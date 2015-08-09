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

#plot4
png(file="plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
#plot4.1
plot(householdSelection$Datetime, householdSelection$Global_active_power,
     type="l", xlab="", ylab="")
title(xlab="", ylab="Global Active Power")
#plot4.2
plot(householdSelection$Datetime, householdSelection$Voltage,
     type="l", xlab="", ylab="")
title(xlab="datetime", ylab="Voltage")
#plot4.3
plot(householdSelection$Datetime, householdSelection$Sub_metering_1,
     type="l", xlab="", ylab="")
lines(householdSelection$Datetime, householdSelection$Sub_metering_2,
      col="red")
lines(householdSelection$Datetime, householdSelection$Sub_metering_3,
      col="blue")
title(xlab="", ylab="Energy sub metering")
legend("topright",
       bty = "n",
       lty = 1,
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#plot4.4
plot(householdSelection$Datetime, householdSelection$Global_reactive_power,
     type="l", xlab="", ylab="")
title(xlab="datetime", ylab="Global_reactive_power")
dev.off()

