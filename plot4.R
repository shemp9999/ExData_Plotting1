require(data.table)

# Read top two rows of dataset to get column classes and variable names
top <- read.table('household_power_consumption.txt',
                  nrows=2,
                  na.strings='?',
                  header=T,
                  sep=';')

classes <- sapply(top,class)
headers <- colnames(top)

# Read the portion of the dataset including dates to be plotted (1 MB RAM).
#   (reading full dataset requires > 100 MB RAM)
d <- data.table(read.table(pipe('grep ^[1-2]/2/2007 household_power_consumption.txt'), 
                   colClasses=classes,
                   col.names=headers,
                   na.strings='?',
                   header=F,
                   sep=';'))

# combine date and time columns
datetime <- as.POSIXlt(paste(d$Date,d$Time), 
                       format='%d/%m/%Y %H:%M:%S')

#Create Plot 4
png(filename='plot4.png', 
    width=480, 
    height=480, 
    units='px')
par(mfrow=c(2,2))

# Subplot 1 (from Plot 2)
with(d, plot(datetime,
             Global_active_power,
             xlab='',
             ylab='Global Active Power', 
             type='l'))

# Subplot 2
with(d, plot(datetime,
             Voltage,
             type='l'))

# Subplot 3 (from Plot 3)
with(d, plot(datetime,
             Sub_metering_1,
             type='l',
             col='black',
             xlab='',
             ylab='Energy sub metering'))
with(d, lines(datetime,
              Sub_metering_2,
              type='l',
              col='red'))
with(d, lines(datetime,
              Sub_metering_3,
              type='l',
              col='blue'))
legend("topright", 
       legend = c('Sub_metering_1',
                  'Sub_metering_2',
                  'Sub_metering_3'),
       col=c('black', 
             'red', 
             'blue'),
       text.width = (strwidth("Sub_metering_3") * 0.7),
       bty = 'n',
       lty = 1, 
       lwd = 1,
       cex = 0.7,
       xjust = 1, 
       yjust = 1)



# Subplot 4
with(d, plot(datetime,
             Global_reactive_power,
             type='l'))

dev.off()
