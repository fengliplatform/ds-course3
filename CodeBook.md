# Code Book for the tidy data set in course project

## Summary
The raw data set can be found at [UCI link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 
Using script `run_analysis.R`, we downloaded the data, did analysis and clean up, finaly created a tidy data set called `meandata.txt`.

This file will describe how the data analysis and clean up have been done. Also will explain all the variables.

## Data analysis process
0. Raw data set download
   + Use `download.file`, and `unzip` to download and unzip raw data set to current directory
1. Read train and test data set and combine them to a data frame
   + read train data from `train/X_train.txt` to train data frame `train.df`
   + read test data from `test/X_test.txt` to test data frame `test.df`
   + use rbind to combind the two data frame to be one full data frame `full.df`
2. Extract only mean and std mesurements to create a new data frame
   + read all variable(feature) names from `features.txt` into `feature.names`
   + grep `mean()` or `std()` in all feature names
   + use `select` from `dplyr package` to create new data frame `full.df.mean.sd` that only contains required variables
3. Attach activity names and subject to the data frame
   + read train and test activity labels from `train/y_train.txt` and `test/y_test.txt` and combine to be data frame `activity.label.df` 
   + use `cbind` to attach activity label to data frame `full.df.mean.sd`
   + read train and test subject from `train/subject_train.txt` and `test/subject_test.txt` and combine to be data frame `subject .df`
   + use `cbind` to attach subject data frame to `full.df.mean.sd`
   + read activity names from `activity_labels.txt` to data frame `activity.name.df`
   + mearge `full.df.mean.sd` and `activity.name.df` by activity labels to give descriptive name to all activities.
4. Label the data set with descriptive variable names
   + replace "-" with "." for all variable names
   + also label activity.label, activity.name and subject columns
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
   + convert measure values from factor to numeric
   + use `group_by` and `summarize_each` to create required tidy data set and write to file `meandata.txt`
   
## Variables in this tidy data set
* "activity.name" 
    - Factor. Descriptive names for all activities including
       + WALKING
       + WALKING_UPSTAIRS
       + WALKING_DOWNSTAIRS
       + SITTING
       + STANDING
       + LAYING 
* "subject"
    - Integer subject id. Range 1-30, inclusive. 
* "activity.label"
    - Integer activity labels. 
	   + 1 WALKING
	   + 2 WALKING_UPSTAIRS
	   + 3 WALKING_DOWNSTAIRS
	   + 4 SITTING
	   + 5 STANDING
	   + 6 LAYING 

Following variables are measures without unit as they are already normalized to 0-1:  
  *t: time domain variables*
  *f: frequency domain variables*
  *X|Y|Z: 3-axial measurement*
  *mean: mean of the variable*
  *std: standard deviation of the variable*
  *see [UCI data set link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for more details*   

* "tBodyAcc.mean...X"              
* "tBodyAcc.mean...Y"              
* "tBodyAcc.mean...Z"              
* "tBodyAcc.std...X"               
* "tBodyAcc.std...Y"               
* "tBodyAcc.std...Z"               
* "tGravityAcc.mean...X"           
* "tGravityAcc.mean...Y"           
* "tGravityAcc.mean...Z"           
* "tGravityAcc.std...X"            
* "tGravityAcc.std...Y"            
* "tGravityAcc.std...Z"            
* "tBodyAccJerk.mean...X"          
* "tBodyAccJerk.mean...Y"          
* "tBodyAccJerk.mean...Z"          
* "tBodyAccJerk.std...X"           
* "tBodyAccJerk.std...Y"
* "tBodyAccJerk.std...Z"
* "tBodyGyro.mean...X"
* "tBodyGyro.mean...Y"
* "tBodyGyro.mean...Z"
* "tBodyGyro.std...X"
* "tBodyGyro.std...Y"
* "tBodyGyro.std...Z"
* "tBodyGyroJerk.mean...X"
* "tBodyGyroJerk.mean...Y"
* "tBodyGyroJerk.mean...Z"
* "tBodyGyroJerk.std...X"
* "tBodyGyroJerk.std...Y"
* "tBodyGyroJerk.std...Z"
* "tBodyAccMag.mean.."
* "tBodyAccMag.std.."
* "tGravityAccMag.mean.."
* "tGravityAccMag.std.."
* "tBodyAccJerkMag.mean.."
* "tBodyAccJerkMag.std.."
* "tBodyGyroMag.mean.."
* "tBodyGyroMag.std.."
* "tBodyGyroJerkMag.mean.."
* "tBodyGyroJerkMag.std.."
* "fBodyAcc.mean...X"
* "fBodyAcc.mean...Y"
* "fBodyAcc.mean...Z"
* "fBodyAcc.std...X"
* "fBodyAcc.std...Y"
* "fBodyAcc.std...Z"
* "fBodyAcc.meanFreq...X"
* "fBodyAcc.meanFreq...Y"
* "fBodyAcc.meanFreq...Z"
* "fBodyAccJerk.mean...X"
* "fBodyAccJerk.mean...Y"
* "fBodyAccJerk.mean...Z"
* "fBodyAccJerk.std...X"
* "fBodyAccJerk.std...Y"
* "fBodyAccJerk.std...Z"
* "fBodyAccJerk.meanFreq...X"
* "fBodyAccJerk.meanFreq...Y"
* "fBodyAccJerk.meanFreq...Z"
* "fBodyGyro.mean...X"
* "fBodyGyro.mean...Y"
* "fBodyGyro.mean...Z"
* "fBodyGyro.std...X"
* "fBodyGyro.std...Y"
* "fBodyGyro.std...Z"
* "fBodyGyro.meanFreq...X"
* "fBodyGyro.meanFreq...Y"
* "fBodyGyro.meanFreq...Z"
* "fBodyAccMag.mean.."
* "fBodyAccMag.std.."
* "fBodyAccMag.meanFreq.."
* "fBodyBodyAccJerkMag.mean.."
* "fBodyBodyAccJerkMag.std.."
* "fBodyBodyAccJerkMag.meanFreq.."
* "fBodyBodyGyroMag.mean.."
* "fBodyBodyGyroMag.std.."
* "fBodyBodyGyroMag.meanFreq.."
* "fBodyBodyGyroJerkMag.mean.."
* "fBodyBodyGyroJerkMag.std.."
* "fBodyBodyGyroJerkMag.meanFreq.."
