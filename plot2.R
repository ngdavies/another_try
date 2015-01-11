## Readl the top of the data file to get the column names.
head <- read.table("./household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",nrows=1)
## Read just the data of interest after finding it by trial and error
## TODO: (in a perfect world), find the relevant data by calculating number of per minute samples
##       or by reading and using the date field.
dat <- read.table("./household_power_consumption.txt",sep=";",header=FALSE,na.strings="?",skip=66637,nrows=2880)

## Fix up the attributes from the top of the file
colNames <- attributes(head)$names
attributes(dat)$names <- colNames


## Calculate the POSIX time from the first two columns in the source data.
datetime <- as.POSIXct(paste(as.character(dat[,1]),as.character(dat[,2])), format="%d/%m/%Y %T")

## Plot global active power against time and date.
plot(datetime, dat[, 3], type='l', xlab="", ylab="Global Active Power (kilowatts)")
axis.POSIXct(1, datetime, format="%a")

## Copy my plot to a PNG file
dev.copy(png, file = "plot2.png")

## Close the PNG device!
dev.off()

