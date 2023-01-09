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

### Plot 3
plot(x = filt_data$DateTime, y = filt_data$SubMetering1, 
     type = 'l', xlab = NA, ylab = 'Energy SubMetering')
lines(x = filt_data$DateTime, y = filt_data$SubMetering2, col = 'red')
lines(x = filt_data$DateTime, y = filt_data$SubMetering3, col = 'blue')
legend('topright', 
       legend = c('Submetering 1', 'Submetering 2', 'Submetering 3'),
       col = c('black', 'red', 'blue'),
       lwd = 1)
dev.off()

print("Done")