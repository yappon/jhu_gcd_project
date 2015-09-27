# jhu_gcd_project
The repository for the project work of "Getting and Cleaning Data" by Johns Hopkins University

## run_analysis.R
This script is supposed to output a text "gcd_project.txt" in the work directory  

Before you run this script, please locate following files to the work directory;
* x_train.txt
* y_train.txt
* subject_train.txt
* x_test.txt
* y_test.txt
* subject_test.txt
* features.txt
* activity_labels.txt

You can run this script in your work directory just by;
'source('run_analysis.R')'

This script creates/removes following variables as intermediate;
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
