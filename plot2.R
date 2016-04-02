##Dependencies
library(ggplot2)
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
ylabel = "Global Active Power (kilowatts)"


doPlot <- function () {
    plot(dat$DateTime, dat$Global_active_power, 
         type = plotType , ylab=xlabel, xlab="",
         width = plotWidth, height=plotHeight)
}

#preview
doPlot()


#write png file
png(file="plot2.png")

doPlot()

#close file stream
dev.off()


