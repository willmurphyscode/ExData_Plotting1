##Dependencies
library(dplyr)
library(lubridate) 

##Read data (commmon to all four plots. Repeated for easy execution)
dataUrl ="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

day1 <- ymd("2007-02-01")
day2 <- ymd("2007-02-02")

zipFileName = "data.zip"

if(!file.exists(zipFileName)) {
    download.file(dataUrl, destfile = zipFileName)
    unzip(zipFileName)
}
extractedFileName = "household_power_consumption.txt"
dat <- read.table(file = extractedFileName, 
                  header = TRUE, sep=";", na.strings = "?"
                  , stringsAsFactors = FALSE)

dat <- tbl_df(dat)

#helper functions
makeDateTimeColumn <- function(dateStr, timeStr) {
  bigStr <- paste(dateStr, timeStr)
  dmy_hms(bigStr)
}

dat <- mutate(dat, DateTime = makeDateTimeColumn(Date, Time))
dat <- mutate(dat, Date = dmy(Date))
dat <- filter(dat, Date == day1 | Date == day2)




##Specify values for plotting 
#Values shared by all plots
plotWidth = 480
plotHeight = 480

#Values specific to this plot
plotType = "l" # line, instead of serires of points. 



doPlot <- function() {
    plot(dat$DateTime, dat$Sub_metering_1, type="n",  #delay plotting
         xlab = "", ylab="Energy sub metering", width=plotWidth, height=plotHeight)
  
    points(dat$DateTime, dat$Sub_metering_1, type="l")
    points(dat$DateTime, dat$Sub_metering_2, type="l", col="red")
    points(dat$DateTime, dat$Sub_metering_3, type="l", col="blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty=c(1,1,1), col=c("black", "red","blue") )
}

# Preview
doPlot()

#Write png file:
png(file = "plot3.png")

doPlot()

#close file stream 
dev.off()
