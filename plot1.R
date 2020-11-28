# load data and convert Date, Time to Date/Time classes 

power <-read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
power <-subset(power, power$Date=="1/2/2007"|power$Date=="2/2/2007")

power$Date <-as.Date(power$Date, format="%d/%m/%Y")
power$Time <-strptime(power$Time, format="%H:%M:%S")

# create plot 1 
with(power, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power"))

# save plot as .png file
png(filename="plot1.png", width = 480, height=480)
