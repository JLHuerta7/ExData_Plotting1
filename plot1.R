# Data reading
filename <- "household_power_consumption.txt"
data <- read.table(filename, sep = ";", header = TRUE, stringsAsFactors = FALSE)

# Date field conversion
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Data subsetting
pldata <- data[which(data$Date == "2007-02-01" | data$Date == "2007-02-02"), ]

# Data casting (printing variables)
pldata$Global_active_power <- as.numeric(pldata$Global_active_power)

# Painting the histogram
hist(pldata$Global_active_power, col = "orangered2", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Creating the png file
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()