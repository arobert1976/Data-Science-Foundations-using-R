## This function downloads the raw data set and generates a tidy data set. Check the README.md for a complete description. 
run_analysis <- function(){
  
  ## Get the raw data file and unzip it 
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "getdata_projectfiles_UCI HAR Dataset.zip")
  unzip("getdata_projectfiles_UCI HAR Dataset.zip")
  
  ## Merge the subject, train and test data into one dataframe
  df_subject_train = read.table("UCI HAR dataset/train/subject_train.txt")
  df_subject_test = read.table("UCI HAR dataset/test/subject_test.txt")
  df_X_train = read.table("UCI HAR dataset/train/X_train.txt")
  df_X_test = read.table("UCI HAR dataset/test/X_test.txt") ##note: no precision is lost, that is an issue with the print --> options(digits=9)
  df_y_train = read.table("UCI HAR dataset/train/y_train.txt")
  df_y_test = read.table("UCI HAR dataset/test/y_test.txt")
  df_merged = cbind(cbind(rbind(df_subject_train,df_subject_test), rbind(df_X_train,df_X_test)),rbind(df_y_train,df_y_test)) ##dim(df_mrged) = 10299x563
  
  ## Keep only the measurements on the mean and standard deviation for each measurement + subject + activity
  ## subject is stored in the 1st column, activity in the last
  ## Note that the grep below ignores column names like fBodyBodyAccJerkMag-meanFreq() as we expect
  df_features = read.table("UCI HAR dataset/features.txt")
  df_merged_1 = df_merged[,c(1, grep("mean\\(\\)|std\\(\\)", df_features$V2)+1, 563)] ##dim(df_merged_s) = 10299,68
  
  ## Setting descriptive activity names (WALKING, WALKING_UPSTAIRS, ...) instead of activity codes (1, 2, ...) 
  convert_activity = function(x){
    if(x==1){x="WALKING"}
    else if(x==2){x="WALKING_UPSTAIRS"}
    else if(x==3){x="WALKING_DOWNSTAIRS"}
    else if(x==4){x="SITTING"}
    else if(x==5){x="STANDING"}
    else if(x==6){x="LAYING"}
  }
  df_merged_1[,68] = sapply(df_merged_1[,68],convert_activity)
  
  ## Setting descriptive variable names
  ## names(df_merged_1) = c("subject", grep("mean\\(\\)|std\\(\\)", df_features$V2, value=TRUE), "activity")
  names(df_merged_1) = c("subject", sub("\\(\\)","",grep("mean\\(\\)|std\\(\\)", df_features$V2, value=TRUE)), "activity")
  
  ## Generating the 1st tidy data set -- this command is commented as it was used for debugging purpose
  ## write.table(df_merged_1, file="tidy_data_intermediar.txt", quote=FALSE, row.names=FALSE)
  
  ## Creating an independant tidy dataset with the average of each variable for each activity and each subject
  library(dplyr)
  df_merged_2 = df_merged_1 %>% group_by(activity, subject) %>% summarise(across(everything(), mean))
  write.table(df_merged_2, file="tidy_data.txt", quote=FALSE, row.names=FALSE)
}