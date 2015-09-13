#reading dataset
#hpc<-read.csv("household_power_consumption.txt") in this way columns are not recognised
hpc<-read.csv("household_power_consumption.txt",
              sep=";",
              col.names=c("Date","Time",
                          "Global_active_power","Global_reactive_power",
                          "Voltage","Global_intensity",
                          "Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#converting Date col to date type
hpc$Date<-as.Date(hpc$Date,"%d/%m/%Y")
#subsetting to 1/2/2007 and 2/2/2007
hpc2<-subset(hpc,  Date>as.Date("31/1/2007","%d/%m/%Y"))
hpc2<-subset(hpc2, Date<as.Date("3/2/2007", "%d/%m/%Y"))
#setting cols as numeric cols
hpc2$Global_active_power<-as.double(as.character(hpc2$Global_active_power))
hpc2$Global_reactive_power<-as.double(as.character(hpc2$Global_reactive_power))
#plot1: Global_active_power histogram
hist(hpc2$Global_active_power,
     main="Global Active Power",
     col="red",
     xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png")
dev.off()