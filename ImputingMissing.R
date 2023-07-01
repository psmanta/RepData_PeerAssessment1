# Reproduceable Research Course Project 1:
# Note that there are a number of days/intervals where there are missing values
# (coded as NANA). The presence of missing days may introduce bias into some
# calculations or summaries of the data.

rm(list = ls())

# Calculate and report the total number of missing values in the dataset
# (i.e. the total number of rows with NAs)

# Read in data set. Convert to a data frame.
setwd("/Users/pmanta/Documents/GitHub/RepData_PeerAssessment1")
rawData <- read.csv("activity.csv", header=TRUE)
dfData <- data.frame(rawData)

# First calculate number of NA in the data
naCount <- sum(is.na(dfData$steps))
print(paste("Number of observations with no step data:", naCount))

# Devise a strategy for filling in all of the missing values in the dataset.
# I am going to use the mean steps for the particular interval containing
# each NA.I also tried different approaches, using mean steps per day
# and just mean steps overall.

# To calculate mean steps per interval, first remove rows with NA values
dfData_noNA_df <- na.omit(dfData)

# Calculate mean steps per interval
meanSteps_df <- aggregate(dfData_noNA_df$steps, list(dfData_noNA_df$interval), FUN = mean)
colnames(meanSteps_df) <- c("Interval", "MeanSteps")

# Replace NA values in dfData$steps with imputed mean values
dfData$steps <- ifelse(is.na(dfData$steps),
                       meanSteps_df$MeanSteps[match(dfData$interval, meanSteps_df$Interval)],
                       dfData$steps)


# Make a histogram of the total number of steps taken each day. Calculate and 
# report the mean and median total number of steps taken per day.
# Do these values differ from the estimates from the first part of the 
# assignment? What is the impact of imputing missing data on the estimates of
# the total daily number of steps?

# First make a data frame of steps aggregated per day rather than interval.
# We need this because the histogram needs to be by day.
# Keep in mind at this point, dfData should not contain any NA observations
dailySteps_df <- aggregate(dfData$steps, list(dfData$date), FUN=sum)
colnames(dailySteps_df) <- c("Date", "DailySteps")

# And generate the histogram
hist(dailySteps_df$DailySteps, xlab = "Total Steps", main = "Histogram - Total Steps with Impution")

# Now we can calculate mean & median steps per day
mean_steps <- mean(dailySteps_df$DailySteps)
median_steps <- median(dailySteps_df$DailySteps)

