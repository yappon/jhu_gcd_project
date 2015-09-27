## Before you run this script: 
## Please locate following files to the work directory
## 1) x_train.txt
## 2) y_train.txt
## 3) subject_train.txt
## 4) x_test.txt
## 5) y_test.txt
## 6) subject_test.txt
## 7) features.txt
## 8) activity_labels.txt
##
## After you run this script:
## This script is supposed to output a text "gcd_project.txt" in the work directory

## Begining of the script

## Load plyr library for ddply function call later in this script
library(plyr)

## Training Data
## Read training data/activity/subject
data <- read.table("./X_train.txt")
activity <- read.table("./y_train.txt")
subject <- read.table("./subject_train.txt")
## Create ID to join 3 dataframes
id <- as.integer(row.names(activity))
## Append id to each datadrame
data <- cbind(id,data)
activity <- cbind(id,activity)
subject <- cbind(id,subject)
## Merge 3 dataframes
trainingData <- merge(subject, activity, by.x="id", by.y="id")
trainingData <- merge(trainingData, data, by.x="id", by.y="id")
## Rename merged dataframe
names(trainingData)[1:3] <- c("id","subject","activity")

## Test Data
## Read training data/activity/subject
data <- read.table("./X_test.txt")
activity <- read.table("./y_test.txt")
subject <- read.table("./subject_test.txt")
## Create ID to join 3 dataframes
id <- as.integer(row.names(activity))
## Append id to each datadrame
data <- cbind(id,data)
activity <- cbind(id,activity)
subject <- cbind(id,subject)
## Merge 3 dataframes
testData <- merge(subject, activity, by.x="id", by.y="id")
testData <- merge(testData, data, by.x="id", by.y="id")
## Rename merged dataframe
names(testData)[1:3] <- c("id","subject","activity")

## Merge training/test data
mergedData <- rbind(trainingData, testData)

## Remove intermediate dataframes
remove(trainingData)
remove(testData)
remove(data)
remove(activity)
remove(subject)
remove(id)

## Read features
features <- read.table("./features.txt")
## Extract feature contains "mean()" or "std()"
subsetFeatures <- features[grep("mean\\(\\)|std\\(\\)",features$V2),]
## Select variables id, subject, activity and feature containing "mean()" or "std()"
subsetData <- mergedData[,c(1,2,3,subsetFeatures$V1+3)]

## Read activities
activities <- read.table("./activity_labels.txt")
names(activities)<-c("activity_id","activity")
## Merge activities with the test/training data
subsetData <- merge(activities,subsetData,by.x = "activity_id", by.y = "activity")

## Rename variable names (making feature vectors with more decriptive)
names(subsetData) <- append(c("activity_id","activity","id","subject"),as.character(subsetFeatures$V2))

## Summarize with calculating average of each activity by subject and activity
resultData <- ddply(subsetData, c("subject","activity"), function(x) colMeans(x[5:70]))

## Output to text file
write.table(x = resultData, file = "gcd_project.txt", row.names = FALSE)

## Remove all dataframes
remove(activities)
remove(features)
remove(subsetFeatures)
remove(mergedData)
remove(subsetData)
remove(resultData)

## End of the script