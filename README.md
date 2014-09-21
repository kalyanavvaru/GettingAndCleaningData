Tidy data output
==================================
 The tidy data generated contains summarized information about **subject** (identified by an id given to the subject), **activity_name** (identified by one of activities listed in the activity labels), **variable**( some of 561 features listed that represents some form of mean or standard deviation of gyroscope and accelerometer) and its **average** value among both test and train data.
 
The tidy data generated qualifies to be the tidy data as it confirms to the "tidy data" principles in the following ways.

 - *each variable forms a column*
    >Each column infacts represents one "facets"  of the observation the assignment intends to find, including observation **variable** column.
 - *each observation forms a row*
    >Each row has information about average of **variable** (mean or SD from raw data) grouped by subject and activity(subject was performing during the observation)


Steps performed to achieve this "tidy" data was as follows
* **read files** that are relevant to the assignments into dataframes. This includes files that represent X_train, Y_train, features, subject_train, activity_labels, X_test, Y_test, subject_test info.
* **set colnames** of X_train and X_test to values in features dataframe.
* **extract "mean" and "sd" columns** from X_train and X_test in the raw data supplied.
* add subject identity info by **cbind**'ing X_train/X_test to have **subject** dataframe as additional column.
* Translate the activity number into descriptive by joining with activity_labels dataframe.
* All the above steps were performed both on test and train data independently to reduce CPU/space complexity, and ignored time complexity(as time is not a constraint for me, but system resources are for my computer).
* After both train and test data is "complete" with subject and activity info, they are both joined to form a unison.
* The data obtained in the above step will be melted(reshaped) so that device variable observations are strctured with subject and activity_name as facts and gyro/accelerometer observation variable as measures.
* A sqldf operation was run on the above data structure so that the mean is calculated over observations group by subject, activity_name,variable.
* data is written to the file.