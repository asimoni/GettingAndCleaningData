setwd('C:\\Users\\Andrea\\Documents\\Coursera\\Data cleaning\\Course Assignment')

library(data.table)

fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", junkpaths=TRUE, exdir = '.')
}

##Loading data

## test data:
data.X.Test <- read.table("UCI HAR Dataset/test/X_test.txt")
data.Y.Test <- read.table("UCI HAR Dataset/test/Y_test.txt")
data.Subject.Test <- read.table("UCI HAR Dataset/test/subject_test.txt")

## train data:
data.X.Train <- read.table("UCI HAR Dataset/train/X_train.txt")
data.Y.Train <- read.table("UCI HAR Dataset/train/Y_train.txt")
data.Subject.Train <- read.table("UCI HAR Dataset/train/subject_train.txt")

## get features labels
desc.features<-read.table("UCI HAR Dataset/features.txt")
features <- as.character(desc.features[,2])

data.Train <-  data.frame(data.Subject.Train, data.Y.Train, data.X.Train)
names(data.Train) <- c(c('subject', 'activity'), features)

data.Test <-  data.frame(data.Subject.Test, data.Y.Test, data.X.Test)
names(data.Test) <- c(c('subject', 'activity'), features)

# merge Train and Test datasets
data.All <- rbind(data.Train, data.Test)


# find 'mean' and 'standard deviations' measurements
selected.columns <- grep('mean|std', features)

# extract a subset containing 'mean' and 'standard deviations' measurements only
data.Subset <- data.All[,c(1,2,selected.columns + 2)]

# load activity description
desc.activity<-read.table("UCI HAR Dataset/activity_labels.txt")
activities <- as.character(desc.activity[,2])

#replace activity id with corresponding description
data.Subset$activity <- activities[data.Subset$activity]


# labels the data with descriptive variable names
data.Subset.names <- names(data.Subset)
data.Subset.names <- gsub("[(][)]", "", data.Subset.names)
data.Subset.names <- gsub("^t", "Time_", data.Subset.names)
data.Subset.names <- gsub("^f", "Frequency_", data.Subset.names)
data.Subset.names <- gsub("Acc", "Accelerometer", data.Subset.names)
data.Subset.names <- gsub("Gyro", "Gyroscope", data.Subset.names)
data.Subset.names <- gsub("Mag", "Magnitude", data.Subset.names)
data.Subset.names <- gsub("-mean\\(\\)", "Mean", data.Subset.names)
data.Subset.names <- gsub("-std\\(\\)", "StdDev", data.Subset.names)
data.Subset.names <- gsub("-", "_", data.Subset.names)
names(data.Subset) <- data.Subset.names

# create a tidy data set with the average of each variable for each activity and each subject.
data.tidy <- aggregate(data.Subset[,3:81], by = list(activity = data.Subset$activity, subject = data.Subset$subject),FUN = mean)
# write data on file 'data_tidy.txt'
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)