# Introduction
Analysis of Human Activity Recognition / Smartphone data set. This is the final project for Coursera course "Getting and Cleaning Data." The data are available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## Description of the run_analysis.R file
The code is broken into 5 sections as described in the assignment:

You should create one R script called run_analysis.R that does the following.   
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
### 1.Merge the training and the test sets to create one data set.
Read the test and training data, and rbind the two datasets into allData.
### 2.Extract only the measurements on the mean and standard deviation for each measurement.
Subset the 66 mean/std measures into subData.
### 3.Use descriptive activity names to name the activities in the data set
Read the names of the 6 activities. 
Read the test and training label numbers, and rbind them into allLabels. Create a vector of activity names.
Cbind the activities to subData.
Read the test and training subject numbers. Rbind the two dataset into subjects
Cbind subject numbers to subData
### 4.Appropriately label the data set with descriptive variable names.
Read the variable names, and remove all special characters from the names
Replace the original variable names with descriptive data names
### 5.From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
Create a vector of column numbers of the 66 mean/std measurements. 
Aggregate the data by subject and activity for all 66 measurements, and calculate the mean. Sort by subject and activity.
Melt the data into tidyData
## Addtional section
Read and write functions for the tidy.csv file
