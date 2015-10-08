
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
## Part 3: plot the the global active power vs. the date
###############################################################################
plot(data2days$DateTime, data2days$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
box(lty = 'solid')

###############################################################################
## Part 4: copy the plot to a PNG file
###############################################################################
dev.copy(png, file = "plot2.png")
dev.off()  # close the PNG device

