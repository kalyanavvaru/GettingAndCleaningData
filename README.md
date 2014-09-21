Tidy data output
==================================
 The tidy data generated contains summarized information about **subject** (identified by an id given to the subject), **activity_name** (identified by one of activities listed in the activity labels), **variable**( some of 561 features listed that represents some form of mean or standard deviation) and its **average** value among both test and train data.
 
The tidy data generated qualifies to be the tidy data as it confirms to the "tidy data" principles in the following ways.

 - *each variable forms a column*
    >Each column infacts represents one "facets"  of the observation the assignment intends to find, including observation **variable** column.
 - *each observation forms a row*
    >Each row has information about average of **variable** (mean or SD from raw data) grouped by subject and activity(subject was performing during the observation)


Steps performed to achieve this "tidy" data was as follows
* **read files** that are relevant to the assignments into dataframes. This includes X_train, Y_train, features, subject_train, activity_labels, X_test, Y_test, subject_test.
* **set colnames** of X_train and X_test to values in features dataframe.
* **extract mean and sd columns** from X_train and X_test so that only columns that represent a variable that represents only mean and standard deviation of some obervation in the raw data supplied.
* add subject info by **cbind**'ing X_train/X_test to have **subject** dataframe as additional column.
* Translate the **identity to be descriptive** activity labels by joinig with activity_labels dataframe.
* All the above steps were performed both on test and train data independently to reduce CPU/space complexity. 
* After both train and test data is complete on its own, they are both joined to form a unison.
* The data obtained in the above step will be melted(reshaped) so that device variable observations are strctured with subject and activity_name as facts and variable values as measures.
* another sqldf operation was run on the above data structure so that the mean is calculated over observations group by subject, activity_name,variable.
* data is writted to the file.