## Readl the top of the data file to get the column names.
head <- read.table("./household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",nrows=1)
## Read just the data of interest after finding it by trial and error
## TODO: (in a perfect world), find the relevant data by calculating number of per minute samples
##       or by reading and using the date field.
dat <- read.table("./household_power_consumption.txt",sep=";",header=FALSE,na.strings="?",skip=66637,nrows=2880)

## Fix up the attributes from the top of the file
colNames <- attributes(head)$names
attributes(dat)$names <- colNames

op <- par(mfrow=c(2, 2))

## Calculate the POSIX time from the first two columns in the source data.
datetime <- as.POSIXct(paste(as.character(dat[,1]),as.character(dat[,2])), format="%d/%m/%Y %T")

## First Plot, Top left
## Global Active Power vs time
plot(datetime, dat[, 3], type='l', ylab="Global Active Power")
axis.POSIXct(1, datetime, format="%a")

## Second plot, Top right
## Voltage vs time
plot(datetime, dat[, 5], type='l', ylab="Voltage")
axis.POSIXct(1, datetime, format="%a")

## Third plot, bottom left
## Energy sub metering (3 traces) vs time
plot(datetime, dat[, 7], type='l', col="black",  ylab="Energy sub metering")
axis.POSIXct(1, datetime, format="%a")
lines(datetime, dat[, 8], type='l', col="red")
lines(datetime, dat[, 9], type='l', col="blue")
legend("topright", legend=colNames[7:9], col=c("black", "red", "blue"), lty=1)

## Fourth plot, bottom right
## Global reactive power vs time
plot(datetime, dat[, 4], type='l', ylab="Global reactive power")
axis.POSIXct(1, datetime, format="%a")


## Copy my plot to a PNG file
dev.copy(png, file = "plot4.png")

## Close the PNG device!
dev.off()
par(op)

