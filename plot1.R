###download & prepare data
download.file('https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip',
              destfile = './project1_data.zip', method = 'curl', quiet = T)
unzip(zipfile = 'project1_data.zip')

#load data
powr_consump <-  read.table('household_power_consumption.txt', header = T, stringsAsFactors = F,
                            na.strings = "?", sep = ';', quote = "")


#tidy data names
colnames(powr_consump) <- c('Date', 'Time', 'GlobalActivePower', 'GlobalReactivePower', 'Voltage',
                       'GlobalIntensity', 'SubMetering1', 'SubMetering2', 'SubMetering3')

#convert date & time vars
powr_consump$DateTime <- strptime(paste(powr_consump$Date, powr_consump$Time), format = '%d/%m/%Y %H:%M:%S')
powr_consump$Date <- strptime(paste(powr_consump$Date), format = '%d/%m/%Y')
powr_consump$Date <- as.Date(paste(powr_consump$Date))

#filter data to select data between dates 2007-02-01 and 2007-02-02. 
library ("dplyr")
filt_data <- powr_consump %>% filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

### Plot 1
png("plot1.png", width=480, height=480)
hist(
  filt_data[, "GlobalActivePower"],
  main ="Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  col = "red",
)
dev.off()

print("Done")