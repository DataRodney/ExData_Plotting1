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

# --- Create second plot; power vs datetime line
png("c:/EDA/plot2.png", width=480, height=480)
par(mfrow = c(1,1))
plot(sshpc$Global_active_power~sshpc$DateTime, type="l", cex.lab = 0.7,
     ylab="Global Active Power (kilowatts)", xlab="")


# --- Copy plot to png file
#dev.copy(png, file = 'plot2.png',height=480, width=480)

# --- Close png device connection
dev.off()
message("Plot #2 successfully generated")
