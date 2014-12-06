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

# Create Plot 2
png(filename='plot2.png', 
    width=480, 
    height=480, 
    units='px')

with(d, plot(datetime,
             Global_active_power,
             xlab='',
             ylab='Global Active Power (kilowatts)', 
             type='l'))
dev.off()
