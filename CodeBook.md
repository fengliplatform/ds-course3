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
   
## variables in this tidy data set
 [1] "activity.name" 
    Factor. Descriptive names for all activities including
    WALKING
    WALKING_UPSTAIRS
    WALKING_DOWNSTAIRS
    SITTING
    STANDING
    LAYING 
 [2] "subject"
    Integer subject id. Range 1-30, inclusive. 
 [3] "activity.label"
    Integer activity labels. 
	1 WALKING
	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS
	4 SITTING
	5 STANDING
	6 LAYING 

Following variables are measures. 
   * t: time domain variables
   * f: frequency domain variables
   * X|Y|Z: 3-axial measurement
   * mean: mean of the variable
   * std: standard deviation of the variable
   * see [UCI data set link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for more details   
 [4] "tBodyAcc.mean...X"              
 [5] "tBodyAcc.mean...Y"              
 [6] "tBodyAcc.mean...Z"              
 [7] "tBodyAcc.std...X"               
 [8] "tBodyAcc.std...Y"               
 [9] "tBodyAcc.std...Z"               
[10] "tGravityAcc.mean...X"           
[11] "tGravityAcc.mean...Y"           
[12] "tGravityAcc.mean...Z"           
[13] "tGravityAcc.std...X"            
[14] "tGravityAcc.std...Y"            
[15] "tGravityAcc.std...Z"            
[16] "tBodyAccJerk.mean...X"          
[17] "tBodyAccJerk.mean...Y"          
[18] "tBodyAccJerk.mean...Z"          
[19] "tBodyAccJerk.std...X"           
[20] "tBodyAccJerk.std...Y"           
[21] "tBodyAccJerk.std...Z"           
[22] "tBodyGyro.mean...X"             
[23] "tBodyGyro.mean...Y"             
[24] "tBodyGyro.mean...Z"             
[25] "tBodyGyro.std...X"              
[26] "tBodyGyro.std...Y"              
[27] "tBodyGyro.std...Z"              
[28] "tBodyGyroJerk.mean...X"         
[29] "tBodyGyroJerk.mean...Y"         
[30] "tBodyGyroJerk.mean...Z"         
[31] "tBodyGyroJerk.std...X"          
[32] "tBodyGyroJerk.std...Y"          
[33] "tBodyGyroJerk.std...Z"          
[34] "tBodyAccMag.mean.."             
[35] "tBodyAccMag.std.."              
[36] "tGravityAccMag.mean.."          
[37] "tGravityAccMag.std.."           
[38] "tBodyAccJerkMag.mean.."         
[39] "tBodyAccJerkMag.std.."          
[40] "tBodyGyroMag.mean.."            
[41] "tBodyGyroMag.std.."             
[42] "tBodyGyroJerkMag.mean.."        
[43] "tBodyGyroJerkMag.std.."         
[44] "fBodyAcc.mean...X"              
[45] "fBodyAcc.mean...Y"              
[46] "fBodyAcc.mean...Z"              
[47] "fBodyAcc.std...X"               
[48] "fBodyAcc.std...Y"               
[49] "fBodyAcc.std...Z"               
[50] "fBodyAcc.meanFreq...X"          
[51] "fBodyAcc.meanFreq...Y"          
[52] "fBodyAcc.meanFreq...Z"          
[53] "fBodyAccJerk.mean...X"          
[54] "fBodyAccJerk.mean...Y"          
[55] "fBodyAccJerk.mean...Z"          
[56] "fBodyAccJerk.std...X"           
[57] "fBodyAccJerk.std...Y"           
[58] "fBodyAccJerk.std...Z"           
[59] "fBodyAccJerk.meanFreq...X"      
[60] "fBodyAccJerk.meanFreq...Y"      
[61] "fBodyAccJerk.meanFreq...Z"      
[62] "fBodyGyro.mean...X"             
[63] "fBodyGyro.mean...Y"             
[64] "fBodyGyro.mean...Z"             
[65] "fBodyGyro.std...X"              
[66] "fBodyGyro.std...Y"              
[67] "fBodyGyro.std...Z"              
[68] "fBodyGyro.meanFreq...X"         
[69] "fBodyGyro.meanFreq...Y"         
[70] "fBodyGyro.meanFreq...Z"         
[71] "fBodyAccMag.mean.."             
[72] "fBodyAccMag.std.."              
[73] "fBodyAccMag.meanFreq.."         
[74] "fBodyBodyAccJerkMag.mean.."     
[75] "fBodyBodyAccJerkMag.std.."      
[76] "fBodyBodyAccJerkMag.meanFreq.." 
[77] "fBodyBodyGyroMag.mean.."        
[78] "fBodyBodyGyroMag.std.."         
[79] "fBodyBodyGyroMag.meanFreq.."    
[80] "fBodyBodyGyroJerkMag.mean.."    
[81] "fBodyBodyGyroJerkMag.std.."     
[82] "fBodyBodyGyroJerkMag.meanFreq.."
