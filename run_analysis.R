#Add dplyr library for easy data frames manipulation
library(dplyr)

##READ ALL THE DATA

#Read labels of measured variables from the data set and change text
features_labels <- read.table("./UCI HAR Dataset/features.txt")
features_labels$V2 <-tolower(features_labels$V2)

#Read the labels of the activities done by each subject and change text 
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels$V2<-gsub("_"," ", tolower(activity_labels$V2))

#------------------------------------
##TRAIN DATA SET
#Read train data set features measurements and assign variable names
train_data <-  read.table("./UCI HAR Dataset/train/X_train.txt", 
                             col.names = features_labels$V2)
names(train_data) <- features_labels$V2
#Read train data set activities ID and match it with its names
train_act_id <-  read.table("./UCI HAR Dataset/train/y_train.txt")
train_act <- data.frame(activity = left_join(train_act_id, activity_labels)[,2])
#Read train data set subjects ID
train_subj_id <-  read.table("./UCI HAR Dataset/train/subject_train.txt", 
                             col.names = "subject")

##Join everything in one Data Frame
train_df <- cbind(train_subj_id, train_act,train_data)

#------------------------------------
##TEST DATA SET
#Read test data set features measurements and assign variable names
test_data <-  read.table("./UCI HAR Dataset/test/X_test.txt", 
                             col.names = features_labels$V2)
names(test_data) <- features_labels$V2
#Read test data set activities ID and match it with its names
test_act_id <-  read.table("./UCI HAR Dataset/test/y_test.txt")
test_act <- data.frame(activity = left_join(test_act_id, activity_labels)[,2])
#Read test data set subjects ID
test_subj_id <-  read.table("./UCI HAR Dataset/test/subject_test.txt", 
                             col.names = "subject")

##Join everything in one Data Frame
test_df <- cbind(test_subj_id, test_act,test_data)
#------------------------------------

##Merge the train and test data frame
total_df <- rbind(train_df, test_df)
#Get Columns where there is mean() or std() measurements
col_idx <- grep("mean\\(\\)|std\\(\\)",names(total_df))
#Create new Data Frame with this columns and take out "()" from feature names
mean_std_df <- select(total_df,subject,activity, all_of(col_idx))
names(mean_std_df)<-gsub("\\(\\)","", names(mean_std_df))

#Group subjects and activities and calculate average of each measurment
average<-mean_std_df %>% group_by(subject, activity) %>% summarise_all(mean)

#Export the resulting table in text format
write.table(average,"./average.txt", row.names = FALSE)