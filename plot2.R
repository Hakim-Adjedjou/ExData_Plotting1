#downloading data : 

fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")

#loading data into R : 

df<-read.table("household_power_consumption.txt",header = TRUE,sep = ";")

#libraries to load : 

library(lubridate)
library(dplyr)

#select needed columns : 
df<-df %>% select(Date:Global_active_power) %>% mutate(Date_time=paste(Date,Time))


#parse and filter :
df$Date<-as.Date(parse_date_time(df$Date,"dmy"))
df<-filter(df,df$Date=="2007-02-01" | df$Date=="2007-02-02")
df$Date_time<-format(x = dmy_hms(df$Date_time), format = "%Y-%m-%d %H:%M:%S")
df$Date_time<- strptime(as.character(df$Date_time), "%Y-%m-%d %H:%M:%S")
df$Global_active_power<-as.numeric(df$Global_active_power)

#plotting :
Sys.setlocale("LC_TIME", "English")
plot(df$Date_time,df$Global_active_power,type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")

#opening graphic device

dev.copy(png,file="plot2.png")
dev.off()

#closing the graphic device