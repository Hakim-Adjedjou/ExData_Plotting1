#downloading data : 

fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")

#loading data into R : 

df<-read.table("household_power_consumption.txt",header = TRUE,sep = ";")

#libraries to load : 

library(lubridate)
library(dplyr)

#casting data type : 

df$Date<-as.Date(parse_date_time(df$Date,"dmy"))
df<-filter(df,df$Date=="2007-02-01" | df$Date=="2007-02-02")
df$Global_active_power<-as.numeric(df$Global_active_power)

#plotting :

hist(df$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

#opening graphic device

dev.copy(png,file="plot1.png")
dev.off()

#closing the graphic device
