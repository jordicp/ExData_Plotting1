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
hpc2$Sub_metering_1<-as.double(as.character(hpc2$Sub_metering_1))
hpc2$Sub_metering_2<-as.double(as.character(hpc2$Sub_metering_2))
hpc2$Sub_metering_3<-as.double(as.character(hpc2$Sub_metering_3))
hpc2$Voltage<-as.double(as.character(hpc2$Voltage))
#converting Time col to time type
hpc2$Time<-strptime( paste(as.character(hpc2$Date), as.character(hpc2$Time), sep=" "), 
                     format="%Y-%m-%d %H:%M:%S"
)

#plot4: 4 graphics
par(mfrow=c(2,2))
with(hpc2,plot(Time,Global_active_power,
               main="",
               ylab="Global Active Power (kilowatts)",
               xlab="DateTime",
               type="n"
               ))
lines(hpc2$Time,hpc2$Global_active_power)
with(hpc2,plot(Time,Voltage,
               main="",
               ylab="Voltage",
               xlab="DateTime",
               type="n"
))
lines(hpc2$Time,hpc2$Voltage)
with(hpc2,plot(Time,Sub_metering_1,
               main="",
               ylab="Energy sub metering",
               xlab="DateTime",
               type="n" #not painting for now
))
lines(hpc2$Time,hpc2$Sub_metering_1,col="black")
lines(hpc2$Time,hpc2$Sub_metering_2,col="red")
lines(hpc2$Time,hpc2$Sub_metering_3,col="blue")
legend("topright",legend=c("1","2","3"),
       col=c("black","red","blue"),bty="n",lty=1)
with(hpc2,plot(Time,Global_reactive_power,
               main="",
               ylab="Global Reactive Power",
               xlab="DateTime",
               type="n"
))
lines(hpc2$Time,hpc2$Global_reactive_power)

dev.copy(png,file="plot4.png")
dev.off()
