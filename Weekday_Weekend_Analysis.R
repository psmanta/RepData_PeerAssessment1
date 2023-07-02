# Reproduceable Research Course Project 1:
# Are there differences in activity patterns between weekdays and weekends?

# Install and load the lubridate package. Already done so I've commented it out.
#install.packages("lubridate")
library(lubridate)
library(ggplot2)

rm(list = ls())

# Read in data set. Convert to a data frame.
setwd("/Users/pmanta/Documents/GitHub/RepData_PeerAssessment1")
rawData <- read.csv("imputed_data.csv", header=TRUE)
dfData <- data.frame(rawData)

# Create a new factor variable in the dataset with two levels – 
# “weekday” and “weekend” indicating whether a given date is
# a weekday or weekend day.
dfData$date <- as.Date(dfData$date)
dfData$day_type <- ifelse(weekdays(dfData$date) %in% c("Saturday", "Sunday"),
                          "weekend", "weekday")


# Make a panel plot containing a time series plot (i.e. type = "l") 
# of the 5-minute interval (x-axis) and the average number of steps taken,
# averaged across all weekday days or weekend days (y-axis).

# First calculate the average number of steps taken per 5 minute interval.
# We need to do this for both weekends and weekdays.
# Again, this is using the data from the previous exercise with imputed 
# values so there will be no NA observations.
# So the order of arguments to the list() is important. We first want to 
# group by day_type, then for each day_type group by interval and calculate
# the mean of those groupings.
meanSteps_byDayType <- aggregate(dfData$steps, 
                               list(dfData$day_type, dfData$interval), FUN=mean)
colnames(meanSteps_byDayType) <- c("day_type", "interval", "mean_steps")

# Now we can create the plot. Using ggplot because I know how to make panel
# plots with it..
plot <- ggplot(meanSteps_byDayType, aes(x = interval, y = mean_steps)) +
  geom_line() + xlab("Interval") + ylab("Mean Steps") +
  theme_bw()

plot_panel <- plot + facet_wrap(~ day_type, nrow=2)

print(plot_panel)