# Exploratory Data Analysis,  Assignment 1 - Household Power Consumption
#==========================================================================

# The 'Electric Power Consumption' dataset has been downloaded from UC Irvine Machine
# Learning Repository at 'https://archive,ocs.uci.edu/ml/datasets/' and unzipped to local
# directory file "C:/EDA/household_power_consumption.txt"

# --- Get dataset
hpc <- read.table("C:/EDA/household_power_consumption.txt", header=TRUE,sep=";",
                  na.strings="?", quote="\" ")

# --- Convert hpc$Date to Date, note: this works for 1st plot only...need time data for subsequent plots
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")


# --- Subsetting the data, select first two days of Feb 2007
sshpc <- hpc[which(hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02"), ]


# --- Create datetime by combining Date and Time columns, this formatting
DateTime <- paste(as.Date(sshpc$Date), sshpc$Time)
sshpc$DateTime <- as.POSIXct(DateTime)

# --- Convert Global Active Power and sub meter columns to numeric
sshpc$Global_active_power <- as.numeric(as.character(sshpc$Global_active_power))
sshpc$Sub_metering_1 <- as.numeric(as.character(sshpc$Sub_metering_1))
sshpc$Sub_metering_2 <- as.numeric(as.character(sshpc$Sub_metering_2))
sshpc$Sub_metering_3 <- as.numeric(as.character(sshpc$Sub_metering_3))

#============================================================================================


# --- Create 4th plot; 4 chart plots arranged in 2x2 display
png("c:/EDA/plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# --- Create upper left plot; power vs datetime line
par(mar=c(5,4,4,2) + 0.1)
plot(sshpc$Global_active_power~sshpc$DateTime, type="l", cex.lab = 1.0,
     ylab="Global Active Power", xlab="")


# --- Create upper right; voltagepower vs datetime line
par(mar=c(5,4,4,2) + 0.1)
plot(sshpc$Voltage~sshpc$DateTime, type="l", cex.axis=1.0, cex.lab = 1.0,
     ylab="Voltage", xlab="datetime")

# --- Create lower left; submetering vs datetime line
ylimData<-max(sshpc$Sub_metering_1, na.rm = TRUE)
par(mar=c(5,4,4,2) + 0.1)
plot(sshpc$Sub_metering_3~sshpc$DateTime,type="n", xlab = "", cex.lab = 1.0,
     ylab="Energy sub metering", ylim=c(0,ylimData))
lines(sshpc$Sub_metering_1~sshpc$DateTime, type="l", col= "black")
lines(sshpc$Sub_metering_2~sshpc$DateTime, type="l", col= "red")
lines(sshpc$Sub_metering_3~sshpc$DateTime, type="l", col= "blue")
legend("topright", bty = "n",legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), cex = 0.8, col=c("black","red","blue"))


# --- Create lower right plot; global reactive power vs datetime line
par(mar=c(5,4,4,2) + 0.1)
ylimData<-max(sshpc$Global_reactive_power, na.rm = TRUE)
plot(sshpc$Global_reactive_power~sshpc$DateTime, type="l", xlab="datetime", cex.axis=0.6,
     cex.lab = 1.0,ylab="Global_reactive_power",ylim=c(0,ylimData))


# --- Copy plot to png file
#dev.copy(png, file = 'plot4.png',height=480, width=480)

# ---Close png device connection
dev.off()

message("Plot #4 successfully generated")


