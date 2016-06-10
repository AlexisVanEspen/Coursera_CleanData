#
# COURSERA DATA SCIENCE SPECIALIZATION
# Getting and Cleaning Data
#
# Alexis Van Espen
#

# 0. Import files.

## Import training set.
d.trainData <- read.table(file = "train/X_train.txt")
d.trainLabels <- read.table(file = "train/y_train.txt", sep = " ")
d.trainSubjects <- read.table(file = "train/subject_train.txt", sep = " ")

## Import test set.
d.testData <- read.table(file = "test/X_test.txt")
d.testLabels <- read.table(file = "test/y_test.txt", sep = " ")
d.testSubjects <- read.table(file = "test/subject_test.txt", sep = " ")


# 1. Merge the training and the test sets to create one data set.

## Create one training set.
d.train <- cbind(d.trainData, d.trainLabels, d.trainSubjects)

## Create one test set.
d.test <- cbind(d.testData, d.testLabels, d.testSubjects)

## Combine both datasets into one.
d.run <- rbind(d.train, d.test)

## Clean up the workspace
rm(d.trainData, d.trainLabels, d.trainSubjects, d.train,
   d.testData, d.testLabels, d.testSubjects, d.test)


# 2. Extract only the measurements on the mean and standard deviation for each measurement.

## Import features vector.
d.features <- read.table("features.txt", stringsAsFactors = FALSE)
names(d.features) <- c("index", "feature")

## Add two elements for the activity and subject columns.
vc.features <- d.features[["feature"]]
vc.features <- c(vc.features, "activity", "subject")

## Retrieve indices corresponding to mean or std features.
## Do not forget the last two columns (activity and subject).
vc.indices <- which(grepl("mean|std", vc.features))
vc.indices <- c(vc.indices, (length(vc.features) - 1):length(vc.features))

## Restrict the data to the corresponding columns.
d.run <- d.run[, vc.indices]


# 3. Use descriptive activity names to name the activities in the dataset

## Import descriptive activity names.
d.activityLabels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
names(d.activityLabels) <- c("index", "activity")
vc.activities <- d.activityLabels[, "activity"]

d.run[, length(vc.indices) - 1] <- vc.activities[d.run[, length(vc.indices) - 1]]


# 4. Appropriately labels the data set with descriptive variable names.
names(d.run) <- vc.features[vc.indices]


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

d.run.average <- d.run[, -((length(d.run) - 1):length(d.run))]

d.run.average <- aggregate(d.run.average, by = list(subject = d.run$subject, activity = d.run$activity), mean, na.rm = TRUE)


