path = "household_power_consumption.txt"
#load the data as all characters... I'll convert to correct types later with explicit conversions
data = read.csv(path, header = TRUE, sep = ";", colClasses = c("character", "character", "character", "character", "character", "character", "character", "character", "character"), col.names = c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3"))

#Combine the Date and Time columns to one DateTime column of type (POSIXlt)
data$Date = strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
colnames(data)[colnames(data) == "Date"] = "DateTime"
data$Time = NULL

#reduce the dataset to only the days in question
data = data[(data$DateTime >= strptime("2007-02-01 00:00:00", format="%Y-%m-%d %H:%M:%S")) & (data$DateTime < strptime("2007-02-03 00:00:00", format="%Y-%m-%d %H:%M:%S")),]

#Convert the remaining columns to Numeric
data$GlobalActivePower = type.convert(data$GlobalActivePower, na.strings = "?", dec = ".", as.is = TRUE)
data$GlobalReactivePower = type.convert(data$GlobalReactivePower, na.strings = "?", dec = ".", as.is = TRUE)
data$Voltage = type.convert(data$Voltage, na.strings = "?", dec = ".", as.is = TRUE)
data$GlobalIntensity = type.convert(data$GlobalIntensity, na.strings = "?", dec = ".", as.is = TRUE)
data$SubMetering1 = type.convert(data$SubMetering1, na.strings = "?", dec = ".", as.is = TRUE)
data$SubMetering2 = type.convert(data$SubMetering2, na.strings = "?", dec = ".", as.is = TRUE)
data$SubMetering3 = type.convert(data$SubMetering3, na.strings = "?", dec = ".", as.is = TRUE)

#Open the PNG device
png(filename="plot1.png", width = 480, height = 480, units = "px", bg="transparent")

#Make the Plot
par(mar = c(4,4,3,0))
hist(data$GlobalActivePower, breaks=12, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")

#Close the PNG device
dev.off()
