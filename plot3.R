#load the dataset
dataset <- read.table("household_power_consumption.txt", header=T, sep=";", 
                      na.strings="?", nrows=2075259, check.names=F, stringsAsFactors = F,
                      comment.char="", quote = '\"')

# create a data subset that includes only the data needed from 1/2/2007 to 2/2/2007
dataset2 <- subset(dataset, Date %in% c("1/2/2007", "2/2/2007"))
dataset2$Date <- as.Date(dataset2$Date, format = "%d/%m/%Y")

# combine date and time 
datetime <- paste(as.Date(dataset2$Date), dataset2$Time)
dataset2$Datetime <- as.POSIXct(datetime)

#plot energy sub meeting by sub metering 1, 2, and 3
with(dataset2, {
  plot(Sub_metering_1~Datetime, type="l", ylab = "Energy sub metering",
       xlab = "") 
  lines(Sub_metering_2~Datetime, col='Red')
  lines(Sub_metering_3~Datetime, col='Blue')})

# add a legend to the top right corner
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height = 480, width=480)
dev.off