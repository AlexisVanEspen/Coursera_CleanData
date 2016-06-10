# COURSERA DATA SCIENCE SPECIALIZATION : Getting and Cleaning Data
*Last edited on 2016.06.10 by Alexis Van Espen.*

This file describes how to go from the original dataset to the cleaned version.

## Assumptions
The script is named run_analysis.R.

### Location of the original data
The original data can be found here : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Location of the data relative to the script
Relative to run_analysis.R,
* The training related data are in a **train** subdirectory.
* The test related data are in a **test** subdirectory.
* Other files are in the same directory.

## 1. Merge the training and the test sets to create one data set.

### Create one training set (d.train).
* Column-bind the data, the activity labels and the subjects identifiers.
* The order of the binding matters!
* d.train is a dataframe with 7,352 rows and 563 columns.
* 561 columns for the features, followed by the activity and subject columns.

### Create one test set (d.test).
* Column-bind the data, the activity labels and the subjects identifiers.
* The order of the binding matters!
* d.test is a dataframe with 2,947 rows and 563 columns.
* 561 columns for the features, followed by the activity and subject columns.

### Create one single dataset (d.run).
* Row-bind d.train and d.test.
* **d.run** is a dataframe with 10,299 rows and 563 columns.

In the upcoming steps, we will only use **d.run**. d.train and d.test can now be dispensed of.

## 2. Extract only the measurements on the mean and standard deviation for each measurement.
To do this, we need to know which variable represents which kind of measure.
**d.run** has presently no variable names, but these names are stored in features.txt.
Let's have a look at the first ten variable names (as found in features.txt).
```
1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
7 tBodyAcc-mad()-X
8 tBodyAcc-mad()-Y
9 tBodyAcc-mad()-Z
10 tBodyAcc-max()-X
```
We can see that the words *mean* and *std* appear in the names of the variables which apply those summary statistics.

### Create a variable *vc.features* to store the column names of d.run.
* The names of the 561 first columns are found in features.txt.
* The last two columns are (by construction) "activity" and "subject".
* We create a vector with these 563 values, in this order.

### Create a variable *vc.indices* to store the indices of *vc.features* corresponding to the variables holding either the mean or the standard deviation.
* This is done with grepl().
```
vc.indices <- which(grepl("mean|std", vc.features))
```
* Do not forget to add the indices of the last two columns (activity and subject)!
* Subset d.run to keep all the rows, but only the columns specified in *vc.indices*.
* **d.run** now has 10,299 rows and 81 columns.
* The last two columns of d.run are activity and subject.

## 3. Use descriptive activity names to name the activities in the dataset.
* The activity column in **d.run** contains numbers. Each of these numbers corresponds to an activity.
* This mapping is shown in activity_labels.txt, as shown below.
```
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
```
* We create a vector *vc.activities* which holds the labels of the six activities.
* Each number in the activity column of **d.run** is the position of the activity in vc.activities.
* So we just use the activity column of **d.run** as a vector of indices for vc.activities.
* This gives a vector with the activity labels, which replaces the previous activity column in d.run. 

## 4. Appropriately labels the data set with descriptive variable names.
* This step makes use of *vc.features* and *vc.indices*, created before.
* We use *vc.indices* as a vector of indices for *vc.features*.
* The names of **d.run** are set to the resulting vector.

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* This step is straightforward with the aggregate() function.
* It is easier at this point to just show the instructions.

```
d.run.average <- d.run[, -((length(d.run) - 1):length(d.run))]
d.run.average <- aggregate(d.run.average, by = list(subject = d.run$subject, activity = d.run$activity), mean, na.rm = TRUE)
```

* We now have a dataframe called **d.run.average** with 180 rows and 81 columns.
* The first two columns are the grouping variables: subject and activity.
* The next 79 columns are the measurement variables.
* **d.run.average** has one row for each combination of subject and activity. Since we have 30 subjects and 6 activities, we must end up with 180 rows. The columns are kept unchanged, except that the two grouping variables are now at the beginning.

**d.run.average** is the tidy dataset submitted for this assignment.
