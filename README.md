# jhu_gcd_project
repository for the project work of "Getting and Cleaning Data" by Johns Hopkins University

# run_analysis.R
This script is supposed to output a text "gcd_project.txt" in the work directory  
Before you run this script, please locate following files to the work directory
1. x_train.txt
2. y_train.txt
3. subject_train.txt
4. x_test.txt
5. y_test.txt
6. subject_test.txt
7. features.txt
8. activity_labels.txt

This script creates/removes following variables as intermediate
* data: Dataframe to store training/test data
* activity: Dataframe to store training/test activity labal data
* subject: Dataframe to store training/test subject data
* id: Integer array to store training/test data
* trainingData: Dataframe to store training data (after merged with activity and subject dataframe)
* testData: Dataframe to store test data (after merged with activity and subject dataframe)
* mergedData: Dataframe created by merging trainingData and testData
* activities: Dataframe to store activities description
* features: Dataframe to store features description
* subsetFeatures: Dataframe to store subset of features (only mean,std features)
* subsetData: Subset dataframe of mergedData about subsetFeatures
* resultData: Subset dataframe summerizing subsetData with the average of each feature by subject and activity
