 Data Dictionary - Column Names
==================================
 
 - subject
	-- Identity given to a human subject.Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
 - activity_name
	-- Activity the subject was performing , i.e, one of 
	WALKING
	WALKING_UPSTAIRS
	WALKING_DOWNSTAIRS
	SITTING
	STANDING
	LAYING
 - variable
	-- The variables is from features.txt that represents some of mean or standard deviation of observation made via gyroscope and accelerator. 
	The variable represents either mean or standard deviation of
	tBodyAcc-XYZ
	tGravityAcc-XYZ
	tBodyAccJerk-XYZ
	tBodyGyro-XYZ
	tBodyGyroJerk-XYZ
	tBodyAccMag
	tGravityAccMag
	tBodyAccJerkMag
	tBodyGyroMag
	tBodyGyroJerkMag
	fBodyAcc-XYZ
	fBodyAccJerk-XYZ
	fBodyGyro-XYZ
	fBodyAccMag
	fBodyAccJerkMag
	fBodyGyroMag
	fBodyGyroJerkMag
	fBodyGyroJerkMag
	gravityMean
	tBodyAccMean
	tBodyAccJerkMean
	tBodyGyroMean
	tBodyGyroJerkMean	
 - average
	-- This is the average of the value calculated by "melt"ing both test and train data and grouped by subject,activity & device sensor's observation variable.
	If the variable represents some observation of acceleration, the accelerometer X axis is in standard gravity units 'g'.The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. If the variable represents gyroscope observation the units are the angular velocity vector measured by the gyroscope for each window sample(128 readings/2.56 sec). The units are radians/second. 