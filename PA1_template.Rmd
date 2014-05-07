## read dataset

```{r,echo=TRUE}

activedf<-read.csv("activity.csv",header=TRUE)
str(activedf)
```

## transform to date

```{r,echo=TRUE}

activedf$date<-as.Date(activedf$date)

```

## calculate mean/median
```{r,echo=TRUE}
hist(activedf$steps)
mean(activedf$steps,na.rm=TRUE)
median(activedf$steps,na.rm=TRUE)

```

## plot average no. of steps across all days

```{r,echo=TRUE}

plot(aggregate(steps~interval,data=activedf,mean),type="l")

```


## calculate missing values

```{r,echo=TRUE}
table(is.na(activedf))

```


## find interval with highest no. of steps across all days


```{r,echo=TRUE}
df<-aggregate(steps~interval,data=activedf,mean)
maxvalue<-which.max(df$steps)
df[maxvalue,]

```

## calculate and substitue NA values with mean no. of steps per interval


```{r,echo=TRUE}


library(plyr)

avgdf<-ddply(activedf,.(interval),transform,mean=mean(steps,na.rm=TRUE))
missing<-which(is.na(avgdf$steps))
avgdf$steps[missing]<-avgdf$mean[missing]



```

## calculate mean and median


```{r,echo=TRUE}

hist(avgdf$steps)
mean(avgdf$steps)
median(avgdf$steps)


```

## add new column to dataframe and factor by weekday/weekend

```{r,echo=TRUE}
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


```

## plot average steps with 5 minute intervals by days 

```{r,echo=TRUE}
library(lattice)
avgdf<-ddply(avgdf,.(interval,day),summarise,steps=mean(steps))
xyplot(steps~interval|day,data=avgdf,type="l",layout=c(1,2),ylab="Nuber of Steps",xlab="Interval")


```


