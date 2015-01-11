## ============================================================================
## Exploratory Data Analysis
## ============================================================================
## Course Project 1 - Electric Power Consumption
## Plot 1
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

# figure 1
png(file="plot1.png", width=480, height=480, bg="transparent")
with(data, 
     hist(Global_active_power, 
     col="red", 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
)
dev.off()
