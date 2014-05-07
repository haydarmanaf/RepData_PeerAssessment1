Markdown
========================================================

#download file and unzip
url<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(url,destfile="C:./activity.zip")
unzip("activity.zip",unzip="internal")

#read dataset
activedf<-read.csv("activity.csv",header=TRUE)
str(activedf)

#transform date
activedf$date<-as.Date(activedf$date)

#calculate mean/median
plot0<-hist(activedf$steps)
mean(activedf$steps,na.rm=TRUE)
median(activedf$steps,na.rm=TRUE)

##plot average no. of steps across all days
plot(aggregate(steps~interval,data=activedf,mean),type="l")

##find interval with highest no. of steps across all days
df<-aggregate(steps~interval,data=activedf,mean)
maxvalue<-which.max(df$steps)
df[maxvalue,]

##calculate missing values
table(is.na(activedf))

##calculate and substitue NA values with mean no. of steps per interval
library(plyr)

avgdf<-ddply(activedf,.(interval),transform,mean=mean(steps,na.rm=TRUE))
missing<-which(is.na(avgdf$steps))
avgdf$steps[missing]<-avgdf$mean[missing]

##calculate mean and median
plot1<-hist(avgdf$steps)

mean(avgdf$steps)
median(avgdf$steps)

##add new column to dataframe and factor by weekday/weekend
date<-avgdf$date
date<-weekdays(date)
weekday<-c("Monday","Tuesday","Wednesday","Thursday","Friday")
weekend<-c("Saturday","Sunday")
weekendindex<-which(date %in% weekend)
weekdayindex<-which(date %in% weekday)
date[weekdayindex]<-"Weekday"
date[weekendindex]<-"Weekend"
date<-factor(date)
avgdf<-cbind(avgdf,date)
names(avgdf)[5]<-"day"

##plot average steps with 5 minute intervals by days 
library(lattice)
avgdf<-ddply(avgdf,.(interval,day),summarise,steps=mean(steps))
plot2<-xyplot(steps~interval|day,data=avgdf,type="l",layout=c(1,2),ylab="Nuber of Steps",xlab="Interval")
plot2
