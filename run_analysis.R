## Create a temporary file. Download file from internet as temp.
temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, temp, mode="wb")

## Read proper txt files from zipped temp. Delete temp.
actLabels <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))
features <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))
subjectTest <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))
XTest <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
yTest <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))
subjectTrain <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))
XTrain <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
yTrain <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
unlink(temp)

## Create a column to distinguish between test & train cases in ther merged data set.
## Assign names to activities in test & train data sets.
subjectTest["Study"] <- "Test"
subjectTrain["Study"] <- "Train"
activTest <- merge(yTest, actLabels, by="V1")
activTrain <- merge(yTrain, actLabels, by="V1")

## Combine by columns subjects, activities and variables in test & train data sets.
## Merge test & train data sets.
DataSet <- rbind(cbind(subjectTest, activTest, XTest), cbind(subjectTrain, activTrain, XTrain))

## Assign names to data set columns.
## Subset data set by variable names to only extract mean and standard deviation variables
## Drop auxiliary columns. Extract variables names.
colnames(DataSet) <- c("ID_Subject", "Study", "ID_Activity", "Activity", t(features[2]))
columnSelec <- 4+which(1*grepl("std|mean", features[,2]) != 0)
DataSubSet <- DataSet[, c(1:2,4, columnSelec)]
columnSelecNames <- colnames(DataSubSet[,4:82])

## Obtain average of each variable for each activity and each subject.
## Drop auxiliary columns. Change variables names. Assign names to data set columns.
attach(DataSubSet)
DataSubSetAvGr <- aggregate(DataSubSet[,-2:-3], by=list(ID_Subject, Activity), FUN=mean, na.rm=TRUE)
detach(DataSubSet)
DataSubSetAvGr <- subset(DataSubSetAvGr, select=-ID_Subject)
columnNewNames <- paste("AVG -", columnSelecNames)
names(DataSubSetAvGr) <- c("Subject","Activity", columnNewNames)

## Order data set by subject & activity
DataSubSetAvGrOr <-  DataSubSetAvGr[with(DataSubSetAvGr, order(Subject, Activity)), ]

## Export final data set to txt file.
write.table(DataSubSetAvGrOr, "UCI HAR Data SubSet AvGrOr.txt", row.name=FALSE)
