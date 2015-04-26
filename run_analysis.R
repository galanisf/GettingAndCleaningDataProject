#### run_analysis.r
#
#  Description: Script to prepare tidy data that can be used for later analysis. 
#  Data : UCI Data - Human Activity Recognition Using Smartphones
#  URL  : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### Download the zip file and extracted to the forlder; UCI HAR Dataset
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./UCIDataset.zip", mode='wb')
unzip("UCIDataset.zip")
file.rename("UCI HAR Dataset", "UCIData")

#### Read labels and create data files.
activityLbls <- read.csv("./UCIData/activity_labels.txt", header = FALSE, sep= " ", col.names=c("id","activityName"))
featureLbls <- read.csv("./UCIData/features.txt", header = FALSE, sep= " ", col.names=c("id","featureName"))

#### Read training data files.
XTrain <- read.csv("./UCIData/train/X_train.txt", header = FALSE, sep= "")
YTrain <- read.csv("./UCIData/train/y_train.txt", header = FALSE, sep= "",col.names="Activity")
subjectTrain <- read.csv("./UCIData/train/subject_train.txt", header = FALSE, sep= "",col.names="SubjectId")

#### Read test data files.
XTest <- read.csv("./UCIData/test/X_test.txt", header = FALSE, sep= "")
YTest <- read.csv("./UCIData/test/y_test.txt", header = FALSE, sep= "",col.names="Activity")
subjectTest <- read.csv("./UCIData/test/subject_test.txt", header = FALSE, sep= "",col.names="SubjectId")

#### Merge the data
train <- cbind(subjectTrain,YTrain,XTrain)
test <- cbind(subjectTest,YTest,XTest)
tidyData <- rbind(train,test)

#### Extract mean & std
tidyData <- tidyData[,c(1:2,grep("mean.*\\(\\)",featureLbls[,2],ignore.case=T)+3,
                            grep("std\\(\\)",featureLbls[,2],ignore.case=T)+3)]

#### Assign descriptive names
activityIdx = 1
for (currentActivityLabel in activityLbls$activityName) {
    tidyData[,2] <- gsub(activityIdx, currentActivityLabel, tidyData[,2])
    activityIdx <- activityIdx + 1
}

#### A dataset is created with the mean of each variable for each activity and each subject
tidyData$Activity <- as.factor(tidyData$Activity)
tidyData$SubjectId <- as.factor(tidyData$SubjectId)
tidyAverage = aggregate(tidyData, by=list(Subject = tidyData$SubjectId, ActivityName = tidyData$Activity), mean)
tidyAverage$SubjectId <- NULL
tidyAverage$Activity <- NULL
write.table(tidyAverage, "./UCIData/tidyData.txt", row.name=FALSE )
