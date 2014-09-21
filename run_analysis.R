
# Download the raw data from the internet and extract it into "data" directory

if(!file.exists("./data")){
        dir.create("./data")
}

temp <- "./data/gyroscope_data.zip"

if(!file.exists(temp)){
        fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"        
        download.file(fileUrl,temp);                
}
unzip("./data/gyroscope_data.zip", exdir = "./data");

train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt");
train_activity <- read.table("./data/UCI HAR Dataset/train/y_train.txt");
features <- read.table("./data/UCI HAR Dataset/features.txt");
features <- features[,2]
train_subjects <- read.table("./data/UCI HAR Dataset//train//subject_train.txt") ;
activity_labels <- read.table("./data/UCI HAR Dataset//activity_labels.txt") ;
names(activity_labels) <- c("activity_id","activity_name");

test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt");
test_activity <- read.table("./data/UCI HAR Dataset/test/y_test.txt");
test_subjects <- read.table("./data/UCI HAR Dataset//test//subject_test.txt") ;


library(sqldf)
#set col names of train_data
names(train_data) <- features;
#extract columns of interest(mean and standard deviation)
train_data <- (train_data[, grepl("-mean\\(\\)|-std\\(\\)", names(train_data))])
#add activity data to the train data
train_data_with_activity <- cbind(train_data,train_activity)
#set name of newly added activity column
names(train_data_with_activity) <- c(names(train_data),"activity")
#add subject data to the train data
train_data_with_activity_and_subject <- cbind(train_data_with_activity,train_subjects)
#set name of column that contain subject identity
names(train_data_with_activity_and_subject) <- c(names(train_data_with_activity),"subject");
#translate activity number to descriptive activity text.
train_data_with_activity_and_subject <- sqldf("select * from train_data_with_activity_and_subject tdas inner join activity_labels al on (al.activity_id=tdas.activity)")
train_data_with_activity_and_subject <- train_data_with_activity_and_subject[, !(colnames(train_data_with_activity_and_subject) %in% c("activity","activity_id"))]


#repeat the same steps as above for test data
test_data <- (test_data[, grepl("-mean\\(\\)|-std\\(\\)", names(test_data))])
test_data_with_activity <- cbind(test_data,test_activity)
names(test_data_with_activity) <- c(names(test_data),"activity")
test_data_with_activity_and_subject <- cbind(test_data_with_activity,test_subjects)
names(test_data_with_activity_and_subject) <- c(names(test_data_with_activity),"subject");
test_data_with_activity_and_subject <- sqldf("select * from test_data_with_activity_and_subject tdas inner join activity_labels al on (al.activity_id=tdas.activity)")
test_data_with_activity_and_subject <- test_data_with_activity_and_subject[, !(colnames(test_data_with_activity_and_subject) %in% c("activity","activity_id"))]

#merge test data and train data
merged_data <- merge(test_data_with_activity_and_subject,train_data_with_activity_and_subject,all=TRUE)

library(reshape2)

#melt the merged data to have subject and activity as facts and variable as measure
melted_merged_data <- melt(merged_data,id=c("subject","activity_name"))

#calculate the average of measure values
melted_merged_data_summary <- sqldf("select subject, activity_name,variable,avg(value) 'average' from melted_merged_data group by subject, activity_name,variable order by 1,2,3")

#write the newly created tidy data to file
write.table(melted_merged_data_summary,"./data/result_tidy_data_2.txt");
#load and show the data in R studio
data <- read.table("./data/result_tidy_data_2.txt", header = TRUE)
View(data)


