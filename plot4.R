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
df<-df %>% mutate(Date_time=paste(Date,Time))

#parse and filter :
df$Date<-as.Date(parse_date_time(df$Date,"dmy"))
df<-filter(df,df$Date=="2007-02-01" | df$Date=="2007-02-02")
df$Date_time<-format(x = dmy_hms(df$Date_time), format = "%Y-%m-%d %H:%M:%S")
df$Date_time<- strptime(as.character(df$Date_time), "%Y-%m-%d %H:%M:%S")

#remove unecassery column : 
df$Global_intensity<-NULL

#cast to numeric : 
df[,3:7]<-lapply(df[,3:6],function(e){as.numeric(e)})

par(mfrow=c(2,2))
#plotting :
Sys.setlocale("LC_TIME", "English")

#plot1 :
plot(df$Date_time,df$Global_active_power,type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")

#plot2 :
plot(df$Date_time,df$Voltage,type = "l",ylab = "Voltage", xlab = "datetime")

#plot3:
plot(df$Date_time,df$Sub_metering_1 ,type = "n" , ylab = "Energy sub metering", xlab="")
lines(df$Date_time,df$Sub_metering_1)
lines(df$Date_time,df$Sub_metering_2 , col="red")
lines(df$Date_time,df$Sub_metering_3 , col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1, col = c("black","red","blue"), cex = 0.25)

#plot4 : 
plot(df$Date_time,df$Global_reactive_power,type = "l",ylab = "Global_reactive_power", xlab = "datetime")

#opening graphic device

dev.copy(png,file="plot4.png")
dev.off()

#closing the graphic device





