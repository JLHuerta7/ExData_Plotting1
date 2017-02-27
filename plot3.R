# Data reading
filename <- "household_power_consumption.txt"
data <- read.table(filename, sep = ";", header = TRUE, stringsAsFactors = FALSE)

# Date field conversion
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Data subsetting
pldata <- data[which(data$Date == "2007-02-01" | data$Date == "2007-02-02"), ]

# Data casting (printing variables)
pldata$Global_active_power <- as.numeric(pldata$Global_active_power)
pldata$Sub_metering_1 <- as.numeric(pldata$Sub_metering_1)
pldata$Sub_metering_2 <- as.numeric(pldata$Sub_metering_2)
pldata$Sub_metering_3 <- as.numeric(pldata$Sub_metering_3)
# Time
x <- paste(pldata$Date, pldata$Time)
pldata$Time <- strptime(x, format = "%Y-%m-%d %H:%M:%S")

# Painting the plot

# Creating the png file
png("plot3.png", width=480, height=480, type="windows")

# Plotting
plot(pldata$Time, pldata$Sub_metering_1, 
     ylab = "Energy sub metering", xlab="", pch = "", xaxt = "n")
lines(pldata$Time, pldata$Sub_metering_1)
lines(pldata$Time, pldata$Sub_metering_2, col = "orangered")
lines(pldata$Time, pldata$Sub_metering_3, col = "blue")
# Setting axis ticks
axis(1, at = as.numeric(c(pldata$Time[1], pldata$Time[1441], pldata$Time[2880])), 
     labels = c("Thu","Fri", "Sat"))

# Painting legend
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), col = c("black", "orangered", "blue"))

# dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()