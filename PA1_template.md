## read dataset


```r
activedf <- read.csv("activity.csv", header = TRUE)
```

```
## Warning: cannot open file 'activity.csv': No such file or directory
```

```
## Error: cannot open the connection
```

```r
str(activedf)
```

```
## Error: object 'activedf' not found
```


## transform to date


```r

activedf$date <- as.Date(activedf$date)
```

```
## Error: object 'activedf' not found
```



```r
hist(activedf$steps)
```

```
## Error: object 'activedf' not found
```



## calculate mean/median


```r

mean(activedf$steps, na.rm = TRUE)
```

```
## Error: object 'activedf' not found
```

```r
median(activedf$steps, na.rm = TRUE)
```

```
## Error: object 'activedf' not found
```





## plot average no. of steps across all days


```r

plot(aggregate(steps ~ interval, data = activedf, mean), type = "l")
```

```
## Error: object 'activedf' not found
```



## calculate missing values


```r
table(is.na(activedf))
```

```
## Error: object 'activedf' not found
```



## find interval with highest no. of steps across all days



```r
df <- aggregate(steps ~ interval, data = activedf, mean)
```

```
## Error: object 'activedf' not found
```

```r
maxvalue <- which.max(df$steps)
```

```
## Error: object of type 'closure' is not subsettable
```

```r
df[maxvalue, ]
```

```
## Error: object 'maxvalue' not found
```


## calculate and substitue NA values with mean no. of steps per interval



```r


library(plyr)
```

```
## Warning: package 'plyr' was built under R version 3.0.3
```

```r

avgdf <- ddply(activedf, .(interval), transform, mean = mean(steps, na.rm = TRUE))
```

```
## Error: object 'activedf' not found
```

```r
missing <- which(is.na(avgdf$steps))
```

```
## Error: object 'avgdf' not found
```

```r
avgdf$steps[missing] <- avgdf$mean[missing]
```

```
## Error: object 'avgdf' not found
```

```r

```





```r
hist(avgdf$steps)
```

```
## Error: object 'avgdf' not found
```


## calculate mean and median



```r

mean(avgdf$steps)
```

```
## Error: object 'avgdf' not found
```

```r
median(avgdf$steps)
```

```
## Error: object 'avgdf' not found
```

```r

```





## add new column to dataframe and factor by weekday/weekend


```r
date <- avgdf$date
```

```
## Error: object 'avgdf' not found
```

```r
date <- weekdays(date)
```

```
## Error: no applicable method for 'weekdays' applied to an object of class
## "function"
```

```r
weekday <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
weekend <- c("Saturday", "Sunday")
weekendindex <- which(date %in% weekend)
```

```
## Error: 'match' requires vector arguments
```

```r
weekdayindex <- which(date %in% weekday)
```

```
## Error: 'match' requires vector arguments
```

```r
date[weekdayindex] <- "Weekday"
```

```
## Error: object 'weekdayindex' not found
```

```r
date[weekendindex] <- "Weekend"
```

```
## Error: object 'weekendindex' not found
```

```r
date <- factor(date)
```

```
## Error: unique() applies only to vectors
```

```r
avgdf <- cbind(avgdf, date)
```

```
## Error: object 'avgdf' not found
```

```r
names(avgdf)[5] <- "day"
```

```
## Error: object 'avgdf' not found
```

```r

```


## plot average steps with 5 minute intervals by days 


```r
library(lattice)
```

```
## Warning: package 'lattice' was built under R version 3.0.3
```

```r
avgdf <- ddply(avgdf, .(interval, day), summarise, steps = mean(steps))
```

```
## Error: object 'avgdf' not found
```




```r

xyplot(steps ~ interval | day, data = avgdf, type = "l", layout = c(1, 2), ylab = "Nuber of Steps", 
    xlab = "Interval")
```

```
## Error: object 'avgdf' not found
```

```r

```



