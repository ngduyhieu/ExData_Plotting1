
###############################################################################
## Part 1: read the data set
###############################################################################

#### Find the difference between "01/02/2007" and the first date recorded in "household_power_consumption.txt"
dt01022007 <- as.POSIXct("2007-02-01 00:00:00")   # Date and time of 01/02/2007 00:00:00 
fstRow <- read.table("household_power_consumption.txt", sep=";", header = TRUE, nrows = 1)     ## Read the first row in txt file 
fstRow$Date <- as.Date(fstRow$Date, format="%d/%m/%Y")   # Change the format of the first row date 
fstRowdatetime <- paste(as.Date(fstRow$Date), fstRow$Time)
fstRowdatetime <- as.POSIXct(fstRowdatetime)    # Obtain the date and time of the first row

numDay <- as.numeric(dt01022007 - fstRowdatetime)   # Number of days between two date-time 
numSkpCol <- numDay*24*60 + 1 # Number of column should be skipped to go to 01/02/2007

#### Read the data only for 2 days
data2days <- read.table("household_power_consumption.txt", sep=";", skip = numSkpCol, nrows = 2880)     ## Read only "01/02/2007" and "02/02/2007" from txt file
## Here 2880 = 24*60*2
names(data2days) <-  names(fstRow)  # Assign the names to tmp

###############################################################################
## Part 2: add a column consisting of date and time
###############################################################################

## Convert the date
data2days$Date <- as.Date(data2days$Date, format="%d/%m/%Y")

## Add the DateTime column 
datetime <- paste(as.Date(data2days$Date), data2days$Time)
data2days$DateTime <- as.POSIXct(datetime)


###############################################################################
## Part 3: plot the 4 sug-figures
###############################################################################

##### Create the main figure with 4 sub-figures
par(mfrow = c(2,2))

##### Plot the first sub-figure
plot(data2days$DateTime, data2days$Global_active_power, type="l", 
     ylab="Voltage", xlab="")
box(lty = 'solid')

##### Plot the second sub-figure
plot(data2days$DateTime, data2days$Voltage, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="datetime")
box(lty = 'solid')

##### Plot the third sub-figure
plot(data2days$DateTime, data2days$Sub_metering_1, type="n", 
              ylab="Energy sub metering", xlab="", ylim=c(0.0,40.0)) 
par(new = T)
plot(data2days$DateTime, data2days$Sub_metering_1, type="l", ylab="", xlab="", ylim=c(0.0,40.0) )
par(new = T)
plot(data2days$DateTime, data2days$Sub_metering_2, type="l", col = "red", ylab="", xlab="", ylim=c(0.0,40.0) )
par(new = T)
plot(data2days$DateTime, data2days$Sub_metering_3, type="l", col = "blue", ylab="", xlab="", ylim=c(0.0,40.0) )
par(new = T)
box(lty = 'solid')
par(new = T)
legend("topright", pch = "_", bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
par(new = F)

##### Plot the fourth sub-figure
plot(data2days$DateTime, data2days$Global_reactive_power, type="l", 
     ylab="Global_reactive_power", xlab="datetime")
box(lty = 'solid')


###############################################################################
## Part 4: copy the plot to a PNG file
###############################################################################
dev.copy(png, file = "plot4.png")
dev.off()  # close the PNG device

