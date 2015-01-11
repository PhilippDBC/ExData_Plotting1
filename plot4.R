## ============================================================================
## Exploratory Data Analysis
## ============================================================================
## Course Project 1 - Electric Power Consumption
## Plot 2
## ----------------------------------------------------------------------------
## 2015-01-11, Philipp
## ============================================================================

# set working directory (source file is in a subdirectory called data)
setwd("/home/philipp/projects/coursera/expl_data_analysis/ExData_Plotting1/")

# we just require two days
filteredData <- grep('^[1-2]/2/2007|^Date', 
                     readLines("./data/household_power_consumption.txt"),
                     value=TRUE)

# source data classes
customClasses <- c("character", "character", "numeric", "numeric", "numeric",
                   "numeric", "numeric", "numeric", "numeric")

# get data from filtered lines and with custom classes
data <- read.table(textConnection(filteredData), 
                   colClasses=customClasses, 
                   header=TRUE, sep=";")

# convert the date and time values to date/time classes
data$Time <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y%H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# figure 4
# set local to get english weekday names
Sys.setlocale(category="LC_TIME", locale="C")

png(file="plot4.png", width=480, height=480, bg="transparent")

# configure 2x2 quadrants
par(mfrow=c(2,2))

with(data, {
  
  # Plot for 1st quadrant (topleft)
  plot(Time, 
       Global_active_power, 
       type="l", 
       ylab="Global Active Power", 
       xlab=""
  )
  
  # Plot for 2nd quadrant (topright)
  plot(Time, 
       Voltage, 
       type="l", 
       ylab="Voltage", 
       xlab="datetime"
  )  

  # Plot for 3rd quadrant (bottomleft)
  plot(Time, 
       Sub_metering_1, 
       type="l", 
       ylab="Energy sub metering",  
       xlab=""
  )
  # lines for 3rd quadrant
  lines(Time, Sub_metering_2, type="l", col="red")
  lines(Time, Sub_metering_3, type="l", col="blue")
  # legend for 3rd quadrant
  legend("topright", 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col=c("black", "red", "blue"), 
         lty=1, 
         bty="n"
  )
  
  # Plot for 4th quadrant (bottomright)
  plot(Time, 
       Global_reactive_power, 
       type="l", 
       xlab="datetime"
  )
})
dev.off()
