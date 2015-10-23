# Getting-and-Cleaning-Data-Course-Project
The goal is to prepare tidy data from data collected from Human Activity Recognition Using Smartphones Data Set.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The created R script called run_analysis.R does the following:
1. Create a temporary file. Download file from internet as temp.
2. Read proper txt files from zipped temp. Delete temp.
3. Create a column to distinguish between test & train cases in ther merged data set.
4. Assign names to activities in test & train data sets.
5. Combine by columns subjects, activities and variables in test & train data sets.
6. Merge test & train data sets.
7. Assign names to data set columns.
8. Subset data set by variable names to only extract mean and standard deviation variables.
9. Drop auxiliary columns. Extract variables names.
10. Obtain average of each variable for each activity and each subject.
11. Drop auxiliary columns. Change variables names. Assign names to data set columns.
12. Order data set by subject & activity
13. Export final data set to txt file.
