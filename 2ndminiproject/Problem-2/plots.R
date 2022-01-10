#Load and read the table
t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Format to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")

#Use only data from Feb. 1, 2007 to Feb. 2, 2007
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Utilize complete observations only
t <- t[complete.cases(t),]

#Create dateTime variable 
dateTime <- paste(t$Date, t$Time)
dateTime <- setNames(dateTime, "DateTime")

#Clean the table
t <- t[ ,!(names(t) %in% c("Date","Time"))] # Remove Date and Time column
t <- cbind(dateTime, t) # Add DateTime column
t$dateTime <- as.POSIXct(dateTime) # Format the column

#Plot 1
hist(t$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red") #to create a histogram

# Save the plot
#dev.copy(png,"plot1.png", width=480, height=480)
#dev.off()

# Plot 2
plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="") #to create a line plot

# Save the plot
#dev.copy(png,"plot2.png", width=480, height=480)
#dev.off()

#Plot 3
with(t, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save the plot
#dev.copy(png,"plot3.png", width=480, height=480)
#dev.off()

#Plot 4 
#Combine all plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(t, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# Save the plot
#dev.copy(png,"plot4.png", width=480, height=480)
#dev.off()