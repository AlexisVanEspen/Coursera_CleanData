# COURSERA DATA SCIENCE SPECIALIZATION
**Getting and Cleaning Data**
*Last edited on 2016.06.10 by Alexis Van Espen.*


The purpose of the script is to go from the original data to a cleaned version.

### Location of the original data
The original data can be found here : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Location of the cleaned dataset
The cleaned dataset has been submitted as part of the assignment.

### Location of the data relative to the script
The cleaning script is named run_analysis.R.
The directory where the script is located contains some files and two subfolders.

#### Same level as the script
* activity_labels.txt : maps the labels of activities to their numbers in the dataset.
* features.txt : list of the variables names of the test and train datasets.
* README.md : overview of the reprodubile cleaning process.
* CodeBook.md : this document - describes the files, locations and relationships.

#### *train* subdirectory
*Data about the training set*
* subject_train.txt : identifiers of the participants in the survey. Ranges from 1 to 30.
* X_train.txt : measurements made over 561 variables, for 30 participants taking part in 6 activities.
* y_train.txt : code numbers of the activities.

#### *test* subdirectory
*Data about the test set*
* subject_test.txt : identifiers of the participants in the survey. Ranges from 1 to 30.
* X_test.txt : measurements made over 561 variables, for 30 participants taking part in 6 activities.
* y_test.txt : code numbers of the activities.
