# load data and convert Date, Time to Date/Time classes 

power <-read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subPower <-subset(power, power$Date=="1/2/2007"|power$Date=="2/2/2007")

subPower$Date <-as.Date(subPower$Date, format="%d/%m/%Y")
subPower$Time <-strptime(subPower$Time, format="%H:%M:%S")

# format date to Jan and Feb 2007 (not current date)
subPower[1:1440,"Time"] <- format(subPower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subPower[1441:2880,"Time"] <- format(subPower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# create plot 4 and save as .png file
png("plot4.png", width = 480, height=480)
par(mfrow=c(2,2))
with(subPower, {
  plot(Time,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)") 
  plot(subPower$Time,subPower$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)") 
  plot(subPower$Time,subPower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    with(subPower,lines(Time,Sub_metering_1, col="black"))
    with(subPower,lines(Time,Sub_metering_2,col="red"))
    with(subPower,lines(Time,Sub_metering_3,col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
  plot(subPower$Time,subPower$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)") 
})
dev.off()



