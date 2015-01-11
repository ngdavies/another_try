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
## This is used as the x dimension in the plots.
datetime <- as.POSIXct(paste(as.character(dat[,1]),as.character(dat[,2])), format="%d/%m/%Y %T")

## Create a plot then use the lines() call to add the extra lines.
plot(datetime, dat[, 7], type='l', col="black", xlab="", ylab="Energy sub metering")
lines(datetime, dat[, 8], type='l', col="red")
lines(datetime, dat[, 9], type='l', col="blue")
## Add the x axis legend in days 
axis.POSIXct(1, datetime, format="%a")
## Add a legend. 
## TODO: I am having trouble getting the legend to view properly in the .png file
##       Even though the legend views properly in R studio
legend("topright", legend=colNames[7:9], col=c("black", "red", "blue"), lty=1)

## Copy my plot to a PNG file
dev.copy(png, file = "plot3.png")

## Close the PNG device!
dev.off()

