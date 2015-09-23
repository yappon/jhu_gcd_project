library(plyr)

## Training Data
## Read training data/activity/subject
trainingData <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainingLabel <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
trainingSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
## Create ID to join 3 dataframes
id <- as.integer(row.names(trainingLabel))
## Append id to each data
trainingData <- cbind(id,trainingData)
trainingLabel <- cbind(id,trainingLabel)
trainingSubject <- cbind(id,trainingSubject)
## Merge 3 tables
mergedTrainingData <- merge(trainingSubject, trainingLabel, by.x="id", by.y="id")
names(mergedTrainingData) <- c("id","subject","activity")
mergedTrainingData <- merge(mergedTrainingData, trainingData, by.x="id", by.y="id")

## Test Data
## Read test data/activity/subject
testData <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
## Create ID to join 3 dataframes
id <- as.integer(row.names(testLabel))
## Append id to each data
testData <- cbind(id,testData)
testLabel <- cbind(id,testLabel)
testSubject <- cbind(id,testSubject)
## Merge 3 tables
mergedTestData <- merge(testSubject, testLabel, by.x="id", by.y="id")
names(mergedTestData) <- c("id","subject","activity")
mergedTestData <- merge(mergedTestData, testData, by.x="id", by.y="id")

## Merge training/test data
mergedData <- rbind(mergedTrainingData, mergedTestData)

## Remove intermediate dataframes
remove(mergedTrainingData)
remove(trainingData)
remove(trainingLabel)
remove(trainingSubject)
remove(mergedTestData)
remove(testData)
remove(testLabel)
remove(testSubject)
remove(id)

## Read features
feature <- read.table("./data/UCI HAR Dataset/features.txt")
## Extract feature contains "mean()" or "std()"
subsetFeature <- feature[grep("mean\\(\\)|std\\(\\)",feature$V2),]
## Select variables id, subject, activity and feature containing "mean()" or "std()"
subsetData <- mergedData[,c(1,2,3,subsetFeature$V1+3)]

## Read activities
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
names(activities)<-c("activity","activity description")
## Merge with the test/training data
subsetData <- merge(activities,subsetData,by.x = "activity", by.y = "activity")

## Rename variable names (making feature vectors with more decriptive)
names(subsetData) <- append(c("activity_id","activity","id","subject"),as.character(subsetFeature$V2))

## Summarize with calculating average of each activity by subject and activity
resultData <- ddply(subsetData, c("subject","activity"), function(x) colMeans(x[5:70]))

## Output to text file
write.table(x = resultData, file = "gcd_project.txt", row.names = FALSE)
