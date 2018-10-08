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

#plot four graphs - global active power, voltage, energy submetering, 
# and global reactive power against datetime - follow labels as instructed
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dataset2, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off
