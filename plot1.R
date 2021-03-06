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

# Create Plot 1
png(filename='plot1.png', 
    width=480, 
    height=480, 
    units='px')

with(d, hist(Global_active_power, 
             xlab='Global Active Power (kilowatts)',
             col='red',
             main='Global Active Power'))
dev.off()
