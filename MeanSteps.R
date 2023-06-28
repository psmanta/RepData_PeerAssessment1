# Reproduceable Research Course Project 1:
# This calculates the mean number of steps taken per day
# of the Activity.csv data set as specified in the project.

rm(list = ls())

# Read in data set
setwd("/Users/pmanta/Documents/GitHub/RepData_PeerAssessment1")
rawData <- read.csv("activity.csv", header=TRUE)
dfData <- data.frame(rawData)

# Group by date. Can't calculate mean of the raw data as we want mean steps
# per day. Then remove days where we don't have data and rename the columns.
dfData <- aggregate(dfData$steps, list(dfData$date), FUN=sum)
dfData <- na.omit(dfData)
colnames(dfData) <- c("Date", "TotalSteps")

# Now we can calculate mean steps per day
mean_steps <- mean(dfData$TotalSteps)
median_steps <- median(dfData$TotalSteps)

# A histogram is appropriate here rather than a barplot. Histograms
# plot continuous observations which we have with TotalSteps.
# a barplot isn't appropriate as it would plot discrete categories.
hist(dfData$TotalSteps, xlab = "Total Steps", main = "Histogram of Daily Total Steps")