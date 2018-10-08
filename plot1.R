#load the dataset
dataset <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
# create a data subset that includes only the data needed from 1/2/2007 to 2/2/2007
dataset2 <- subset(dataset, Date %in% c("1/2/2007", "2/2/2007"))
dataset2$Date <- as.Date(dataset2$Date, format = "%d/%m/%Y") 
# create histogram of global active power
hist(dataset2$Global_active_power, main= "Global active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()