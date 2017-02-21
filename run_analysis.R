############################## 
# course3 project - Feng Li
##############################

########
# 0. Download dataset
########

# create data dir if necessary
setwd("~/course/ds_coursera/course3")
if(!file.exists("./data")) {
  dir.create("./data")
}
# download dataset zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/project.zip", method="curl")
list.files("./data")

# unzip file and rename created directory
setwd("~/course/ds_coursera/course3/data")
unzip("./project.zip")
file.rename(from="UCI HAR Dataset", to="UCI_HAR_Dataset")
setwd("~/course/ds_coursera/course3/data/UCI_HAR_Dataset")
list.files("./")

########
# 1. read train and test dataset.
# This is to do step 1 from project instruction: 1. Merges the training and the test 
# sets to create one data set.
######## 

# read train dataset as txt file
trainfile <- "./train/X_train.txt"
lines <- readLines(trainfile)
# clean up spaces between values and create train data frame: train.df
lines <- sub("^ +","",lines)
lines <- gsub(" +"," ",lines)
lines <- strsplit(lines, split=" ")
lines <- unlist(lines)
lines.m <-matrix(lines, ncol=561, byrow=TRUE) # There are 561 features based on README.txt
train.df <- as.data.frame(lines.m)

# read test dataset as txt file
testfile <- "./test/X_test.txt"
lines <- readLines(testfile)
# clean up spaces between values and create test data frame: test.df
lines <- sub("^ +","",lines)
lines <- gsub(" +"," ",lines)
lines <- strsplit(lines, split=" ")
lines <- unlist(lines)
lines.m <-matrix(lines, ncol=561, byrow=TRUE) # There are 561 features based on README.txt
test.df <- as.data.frame(lines.m)

# Merges the training and the test sets to create one data set.
full.df <- rbind(train.df, test.df)

########
# 2. Extract required columns to be new data frame
# This is to do step 2 from project instruction: 2. Extracts only the measurements on 
# the mean and standard deviation for each measurement.
######## 
library(dplyr)
# read feature names
featurefile <- "./features.txt"
feature.df <- read.table(featurefile, header=FALSE)
feature.names <- feature.df[,2]
feature.names <- as.character(feature.names)

# get position vector and names vector to required columns
feature.mean.sd.position <- grep("mean()|std()", feature.names)
# This will be used to give column names in section 4.
feature.mean.sd.names <- grep("mean()|std()", feature.names,value=TRUE)

# create new data frame only includes required columns
full.df.mean.sd <- select(full.df, feature.mean.sd.position)

########
# 3. Handle activity names and subjects to data frame created from above
# This is to do step 3 from project instruction: 3. Uses descriptive activity names to 
# name the activities in the data set 
########
# read activity labels for train dataset
train.activity.file <- "./train/y_train.txt"
train.activity.label.df <- read.table(train.activity.file, header=FALSE)
#names(train.activity.label.df) <- "activity.label"

# read activity labels for test dataset
test.activity.file <- "./test/y_test.txt"
test.activity.label.df <- read.table(test.activity.file, header=FALSE)
#names(test.activity.label.df) <- "activity.label"

# combine train and test activity label datasets to be one dataset
activity.label.df <- rbind(train.activity.label.df, test.activity.label.df)

# read and create activity names dataset
activity.name.file <- "./activity_labels.txt"
activity.name.df <- read.table(activity.name.file, header=FALSE)

# merge activity label dataset and activity names dataset 
activity.df <- merge(activity.label.df, activity.name.df, by.x="V1", by.y="V1")

# attach activity names to full.df.mean.sd data frame - this will give each record a human readable
# activity description
full.df.mean.sd <- cbind(full.df.mean.sd, activity.name=activity.df$V2)

# Finally add subject to dataset
# read subjects for train dataset
train.subject.file <- "./train/subject_train.txt"
train.subject.df <- read.table(train.subject.file, header=FALSE)

# read subjects for test dataset
test.subject.file <- "./test/subject_test.txt"
test.subject.df <- read.table(test.subject.file, header=FALSE)

# combine train and test subject datasets to be one dataset
subject.df <- rbind(train.subject.df, test.subject.df)

# attach subject to full.df.mean.sd dataset
full.df.mean.sd <- cbind(full.df.mean.sd, subject=subject.df$V1)

########
# 4. Give column names
# This is to do step 4 from project instruction: 4. Appropriately labels 
# the data set with descriptive variable names. 
########
# use feature.mean.sd.names created in section 2 to name columns
feature.mean.sd.names <- gsub("-", "", feature.mean.sd.names)
feature.mean.sd.names <- c(feature.mean.sd.names, "activity.name")
feature.mean.sd.names <- c(feature.mean.sd.names, "subject")
names(full.df.mean.sd) <- feature.mean.sd.names

########
# 5. Give column names
# This is to do step 5 from project instruction: 5. From the data set in step 4, 
# creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject. 
########
# Temporarily change activity name from factor to character 
full.df.mean.sd$activity.name <- as.character(full.df.mean.sd$activity.name)

# change measure variables from factor to numeric before calculating mean
index <- sapply(full.df.mean.sd, is.factor)
full.df.mean.sd[index] <- lapply(full.df.mean.sd[index], function(x) as.numeric(as.character(x)))

# change activity name back from character to factor
full.df.mean.sd$activity.name <- as.factor(full.df.mean.sd$activity.name)

# create new dataset based on requirements
new.df <- full.df.mean.sd %>%
  group_by_(.dots=c("activity.name", "subject")) %>%
  summarize_each(funs(mean(., na.rm=TRUE)))

# create dataset file to submit
setwd("~/course/ds_coursera/course3")
write.table(new.df, file="meandata.txt", sep=" ", row.names=FALSE)


