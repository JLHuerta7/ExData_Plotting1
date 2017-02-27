# Data reading
filename <- "household_power_consumption.txt"
data <- read.table(filename, sep = ";", header = TRUE, stringsAsFactors = FALSE)

# Date field conversion
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Data subsetting
pldata <- data[which(data$Date == "2007-02-01" | data$Date == "2007-02-02"), ]

# Data casting (printing variables)
pldata$Global_active_power <- as.numeric(pldata$Global_active_power)
pldata$Global_reactive_power <- as.numeric(pldata$Global_reactive_power)
pldata$Voltage <- as.numeric(pldata$Voltage)
pldata$Sub_metering_1 <- as.numeric(pldata$Sub_metering_1)
pldata$Sub_metering_2 <- as.numeric(pldata$Sub_metering_2)
pldata$Sub_metering_3 <- as.numeric(pldata$Sub_metering_3)
# Time
x <- paste(pldata$Date, pldata$Time)
pldata$Time <- strptime(x, format = "%Y-%m-%d %H:%M:%S")

# Creating the png file
png("plot4.png", width=480, height=480, type="windows")

# Setting multiplot
par(mfrow = c(2,2))

# Painting plot 1

plot(pldata$Time, pldata$Global_active_power, ylab = "Global Active Power", 
     xlab="", pch = "", xaxt = "n")
lines(pldata$Time, pldata$Global_active_power)
# Setting axis ticks
axis(1, at = as.numeric(c(pldata$Time[1], pldata$Time[1441], pldata$Time[2880])), 
     labels = c("Thu","Fri", "Sat"))

# Painting plot 2

plot(pldata$Time, pldata$Voltage, ylab = "Voltage", xlab="datetime", 
     pch = "", xaxt = "n")
lines(pldata$Time, pldata$Voltage)
# Setting axis ticks
axis(1, at = as.numeric(c(pldata$Time[1], pldata$Time[1441], pldata$Time[2880])), 
     labels = c("Thu","Fri", "Sat"))

# Painting plot 3

plot(pldata$Time, pldata$Sub_metering_1, ylab = "Energy sub metering", 
     xlab="", pch = "", xaxt = "n")
lines(pldata$Time, pldata$Sub_metering_1)
lines(pldata$Time, pldata$Sub_metering_2, col = "orangered")
lines(pldata$Time, pldata$Sub_metering_3, col = "blue")
# Setting axis ticks
axis(1, at = as.numeric(c(pldata$Time[1], pldata$Time[1441], pldata$Time[2880])), 
     labels = c("Thu","Fri", "Sat"))

# Painting legend
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), col = c("black", "orangered", "blue"), bty = "n")
# Painting plot 4

plot(pldata$Time, pldata$Global_reactive_power, ylab = "Global_reactive_power", 
     xlab="datetime", pch = "", xaxt = "n")
lines(pldata$Time, pldata$Global_reactive_power)
# Setting axis ticks
axis(1, at = as.numeric(c(pldata$Time[1], pldata$Time[1441], pldata$Time[2880])), 
     labels = c("Thu","Fri", "Sat"))


# Closing the png device
dev.off()