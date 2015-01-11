
load_dataset <- function(
      zipfile  = "exdata_data_household_power_consumption.zip",
      datafile = "household_power_consumption.txt"
   ) {

   # load data
   data_full <- read.csv(unz(zipfile , datafile),
                         header=TRUE,
                         sep=";",
                         na.strings="?",
                         check.names=F,
                         stringsAsFactors=F,
                         comment.char="",
                         quote='\"')

   # filter data
   data_small <- data_full[which(data_full$Date %in% c('1/2/2007','2/2/2007')),]

   # convert date and time
   data_small$Date <- as.Date(data_small$Date, "%d/%m/%Y")

   data_small$Datetime <- as.POSIXct(paste(as.Date(data_small$Date), data_small$Time))

   data_small
}

data <- load_dataset()

# to get weekdays in English

Sys.setlocale("LC_TIME", "C")


# plot

png("plot2.png", width=480, height=480, bg="transparent")

plot(data$Global_active_power~data$Datetime,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()
