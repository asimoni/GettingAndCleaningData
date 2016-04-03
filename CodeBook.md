### Data description

#### Data Set Information

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the data
manually. The obtained dataset has been randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor
acceleration signal, which has gravitational and body motion components,
was separated using a Butterworth low-pass filter into body acceleration
and gravity. The gravitational force is assumed to have only low
frequency components, therefore a filter with 0.3 Hz cutoff frequency
was used. From each window, a vector of features was obtained by
calculating variables from the time and frequency domain.

#### Attribute Information

For each record in the dataset it is provided: - Triaxial acceleration
from the accelerometer (total acceleration) and the estimated body
acceleration. - Triaxial Angular velocity from the gyroscope. - A
561-feature vector with time and frequency domain variables. - Its
activity label. - An identifier of the subject who carried out the
experiment.

The features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain
signals (prefix 't' to denote time) were captured at a constant rate of
50 Hz. Then they were filtered using a median filter and a 3rd order low
pass Butterworth filter with a corner frequency of 20 Hz to remove
noise. Similarly, the acceleration signal was then separated into body
and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)
using another low pass Butterworth filter with a corner frequency of 0.3
Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to
indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for
each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

-   tBodyAcc-XYZ
-   tGravityAcc-XYZ
-   tBodyAccJerk-XYZ
-   tBodyGyro-XYZ
-   tBodyGyroJerk-XYZ
-   tBodyAccMag
-   tGravityAccMag
-   tBodyAccJerkMag
-   tBodyGyroMag
-   tBodyGyroJerkMag
-   fBodyAcc-XYZ
-   fBodyAccJerk-XYZ
-   fBodyGyro-XYZ
-   fBodyAccMag
-   fBodyAccJerkMag
-   fBodyGyroMag
-   fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

<table>
<thead>
<tr class="header">
<th align="left">Variable</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">mean()</td>
<td align="left">Mean value</td>
</tr>
<tr class="even">
<td align="left">std()</td>
<td align="left">Standard deviation</td>
</tr>
<tr class="odd">
<td align="left">mad()</td>
<td align="left">Median absolute deviation</td>
</tr>
<tr class="even">
<td align="left">max()</td>
<td align="left">Largest value in array</td>
</tr>
<tr class="odd">
<td align="left">min()</td>
<td align="left">Smallest value in array</td>
</tr>
<tr class="even">
<td align="left">sma()</td>
<td align="left">Signal magnitude area</td>
</tr>
<tr class="odd">
<td align="left">energy()</td>
<td align="left">Energy measure. Sum of the squares divided by the number of values.</td>
</tr>
<tr class="even">
<td align="left">iqr()</td>
<td align="left">Interquartile range</td>
</tr>
<tr class="odd">
<td align="left">entropy()</td>
<td align="left">Signal entropy</td>
</tr>
<tr class="even">
<td align="left">arCoeff()</td>
<td align="left">Autorregresion coefficients with Burg order equal to 4</td>
</tr>
<tr class="odd">
<td align="left">correlation()</td>
<td align="left">correlation coefficient between two signals</td>
</tr>
<tr class="even">
<td align="left">maxInds()</td>
<td align="left">index of the frequency component with largest magnitude</td>
</tr>
<tr class="odd">
<td align="left">meanFreq()</td>
<td align="left">Weighted average of the frequency components to obtain a mean frequency</td>
</tr>
<tr class="even">
<td align="left">skewness()</td>
<td align="left">skewness of the frequency domain signal</td>
</tr>
<tr class="odd">
<td align="left">kurtosis()</td>
<td align="left">kurtosis of the frequency domain signal</td>
</tr>
<tr class="even">
<td align="left">bandsEnergy()</td>
<td align="left">Energy of a frequency interval within the 64 bins of the FFT of each window.</td>
</tr>
<tr class="odd">
<td align="left">angle()</td>
<td align="left">Angle between to vectors.</td>
</tr>
</tbody>
</table>

Additional vectors obtained by averaging the signals in a signal window
sample. These are used on the angle() variable:

-   gravityMean
-   tBodyAccMean
-   tBodyAccJerkMean
-   tBodyGyroMean
-   tBodyGyroJerkMean

### Code description

#### 1. Merges the training and the test sets to create one data set.

The source data file is downloaded and unzipped into a local directory

    library(data.table)

    fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    if (!file.exists('./UCI HAR Dataset.zip')){
      download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
      unzip("UCI HAR Dataset.zip", junkpaths=TRUE, exdir = '.')
    }

Extracted files are then loaded into data frames

    ## test data:
    data.X.Test <- read.table("UCI HAR Dataset/test/X_test.txt")
    data.Y.Test <- read.table("UCI HAR Dataset/test/Y_test.txt")
    data.Subject.Test <- read.table("UCI HAR Dataset/test/subject_test.txt")

    ## train data:
    data.X.Train <- read.table("UCI HAR Dataset/train/X_train.txt")
    data.Y.Train <- read.table("UCI HAR Dataset/train/Y_train.txt")
    data.Subject.Train <- read.table("UCI HAR Dataset/train/subject_train.txt")

Features descriptions are loaded from file and stored in a 'features'
array

    desc.features<-read.table("UCI HAR Dataset/features.txt")
    features <- as.character(desc.features[,2])

Data frames are merged into a Train and Test data frames and labelled
with corresponding description

    data.Train <-  data.frame(data.Subject.Train, data.Y.Train, data.X.Train)
    names(data.Train) <- c(c('subject', 'activity'), features)

    data.Test <-  data.frame(data.Subject.Test, data.Y.Test, data.X.Test)
    names(data.Test) <- c(c('subject', 'activity'), features)

As final step, the two data frames are merged together

    # merge Train and Test datasets
    data.All <- rbind(data.Train, data.Test)

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

We use the 'grep' function to locate the 'mean' and 'standard
deviations' measurements

    selected.columns <- grep('mean|std', features)

    # extract a subset containing 'mean' and 'standard deviations' measurements only
    data.Subset <- data.All[,c(1,2,selected.columns + 2)]

#### 3. Uses descriptive activity names to name the activities in the data set

Load the activity descriptions from file, replacing activity id with
corresponding label

    desc.activity<-read.table("UCI HAR Dataset/activity_labels.txt")
    activities <- as.character(desc.activity[,2])
    data.Subset$activity <- activities[data.Subset$activity]

#### 4. Appropriately labels the data set with descriptive variable names.

We get the names vector, replacing the original description wit a more
undertandable one

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

#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Data in the subset are summarized using the 'aggregate' function (by
activity and subject) into data.tidy variable. Then we serialize the
result on 'data\_tidy.txt" file

    data.tidy <- aggregate(data.Subset[,3:81], by = list(activity = data.Subset$activity, subject = data.Subset$subject),FUN = mean)
    write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)
