# Reproduceable Research Course Project 1:
# This calculates the mean number of steps taken per day
# of the Activity.csv data set as specified in the project.

rm(list = ls())

# Read in data set. Convert to a data frame and remove NA observations
setwd("/Users/pmanta/Documents/GitHub/RepData_PeerAssessment1")
rawData <- read.csv("activity.csv", header=TRUE)
dfData <- data.frame(rawData)
dfData <- na.omit(dfData)

# Now instead of grouping by days, we want to calculate the means
# of each 5 minute interval across all days. This results in a new
# data frame with 2 columns. First is the interval and 2nd is the
# mean steps taken in that interval.
meanData <- aggregate(dfData$steps, list(dfData$interval), FUN=mean)
colnames(meanData) <- c("Interval", "MeanSteps")

# And now we can plot the time series. Using base R since this is a simple plot.
plot(meanData$Interval, meanData$MeanSteps, type = "l", 
     xlab = "5-Minute Interval", ylab = "Mean Steps", main = "Mean Steps Over Time")

# Now we need to answer the following:
# Which 5-minute interval, on average across all the days in the dataset,
# contains the maximum number of steps?
max_steps <- max(meanData$MeanSteps)
max_interval <- meanData[meanData$MeanSteps == max_steps, "Interval"]
print(max_interval)

