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

dat <- mutate(dat, Date = dmy(Date))
dat <- filter(dat, Date == day1 | Date == day2)

##Specify values for plotting 
#Values shared by all plots
width = 480
height = 480


#Values specific to plot1.png
histogramColor = "red" 
histrogramBreaks = 12



