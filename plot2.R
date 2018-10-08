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



# create plot of global active power
with (dataset2, {
  plot(Global_active_power~Datetime, type="l", 
    ylab = "Global Active Power (kilowatts)", xlab="")})
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()