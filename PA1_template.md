 
## Project 1

read dataset


```r
activedf <- read.csv("activity.csv", header = TRUE)
str(activedf)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : Factor w/ 61 levels "2012-10-01","2012-10-02",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```


transform to date


```r

activedf$date <- as.Date(activedf$date)
```



```r
hist(activedf$steps)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 



calculate mean/median


```r

mean(activedf$steps, na.rm = TRUE)
```

```
## [1] 37.38
```

```r
median(activedf$steps, na.rm = TRUE)
```

```
## [1] 0
```





plot average no. of steps across all days


```r

plot(aggregate(steps ~ interval, data = activedf, mean), type = "l")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 



calculate missing values


```r
table(is.na(activedf))
```

```
## 
## FALSE  TRUE 
## 50400  2304
```



find interval with highest no. of steps across all days



```r
df <- aggregate(steps ~ interval, data = activedf, mean)
maxvalue <- which.max(df$steps)
df[maxvalue, ]
```

```
##     interval steps
## 104      835 206.2
```


calculate and substitue NA values with mean no. of steps per interval



```r


library(plyr)
```

```
## Warning: package 'plyr' was built under R version 3.0.3
```

```r

avgdf <- ddply(activedf, .(interval), transform, mean = mean(steps, na.rm = TRUE))
missing <- which(is.na(avgdf$steps))
avgdf$steps[missing] <- avgdf$mean[missing]

```





```r
hist(avgdf$steps)
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


calculate mean and median



```r

mean(avgdf$steps)
```

```
## [1] 37.38
```

```r
median(avgdf$steps)
```

```
## [1] 0
```

```r

```





add new column to dataframe and factor by weekday/weekend


```r
date <- avgdf$date
date <- weekdays(date)
weekday <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
weekend <- c("Saturday", "Sunday")
weekendindex <- which(date %in% weekend)
weekdayindex <- which(date %in% weekday)
date[weekdayindex] <- "Weekday"
date[weekendindex] <- "Weekend"
date <- factor(date)
avgdf <- cbind(avgdf, date)
names(avgdf)[5] <- "day"

```


plot average steps with 5 minute intervals by days 


```r
library(lattice)
```

```
## Warning: package 'lattice' was built under R version 3.0.3
```

```r
avgdf <- ddply(avgdf, .(interval, day), summarise, steps = mean(steps))
```




```r

xyplot(steps ~ interval | day, data = avgdf, type = "l", layout = c(1, 2), ylab = "Nuber of Steps", 
    xlab = "Interval")
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 



