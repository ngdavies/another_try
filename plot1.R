## Readl the top of the data file to get the column names.
head <- read.table("./household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",nrows=1)
## Read just the data of interest after finding it by trial and error
## TODO: (in a perfect world), find the relevant data by calculating number of per minute samples
##       or by reading and using the date field.
dat <- read.table("./household_power_consumption.txt",sep=";",header=FALSE,na.strings="?",skip=66637,nrows=2880)

## Fix up the attributes from the top of the file
colNames <- attributes(head)$names
attributes(dat)$names <- colNames


## Plot a histogram with default bins and colour red and a relevant title.
title <- "Global Active Power"
xLabel <- "Global Active Power (kilowatts)"
hist(dat[, 3], col="red", main=title, xlab=xLabel)

## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png")

## Close the PNG device!
dev.off()

