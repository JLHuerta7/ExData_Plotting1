# Data reading
filename <- "household_power_consumption.txt"
data <- read.table(filename, sep = ";", header = TRUE, stringsAsFactors = FALSE)

# Date field conversion
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Data subsetting
pldata <- data[which(data$Date == "2007-02-01" | data$Date == "2007-02-02"), ]

# Data casting (printing variables)
pldata$Global_active_power <- as.numeric(pldata$Global_active_power)
# Time
x <- paste(pldata$Date, pldata$Time)
pldata$Time <- strptime(x, format = "%Y-%m-%d %H:%M:%S")

# Painting plot
plot(pldata$Time, pldata$Global_active_power, 
     ylab = "Global Active Power (kilowatts)", xlab="", pch = "", xaxt = "n")
lines(pldata$Time, pldata$Global_active_power)
axis(1, at = as.numeric(c(pldata$Time[1], pldata$Time[1441], pldata$Time[2880])), 
     labels = c("Thu","Fri", "Sat"))

# Creating the png file
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()