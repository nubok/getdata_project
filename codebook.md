Code book
=========

The first two variables (in both datasets) are "subject" and "activity". "subject" is taken from test/subject_test.txt and train/subject_train.txt. The value for "activity" is taken from test/y_test.txt and train/y_train.txt, but is replaced by the string representation taken from activity_labels.txt.

The remaining columns of dataset_step4.txt are taken from test/X_test.txt and train/X_train.txt. The file features.txt tells the columns (they are just renamed; this text will tell how). To understand them, we have to look at features_info.txt. There are two instruments of measurements:
* accelerometer
* gyroscope
They deliver
* acceleration
* angular velocity
data. To quote from features_info.txt:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
>
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

Also you can read in this file:

> The set of variables that were estimated from these signals are: 
> 
> mean(): Mean value
> std(): Standard deviation

So with this background we can describe how the data from dataset_step4.txt corresponds to the original data:

* mean_of_body_acceleration_time_X/mean_of_body_acceleration_time_Y/mean_of_body_acceleration_time_Z: Corresponds to tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z
* standard_deviation_of_body_acceleration_time_*: Corresponds to tBodyAcc-std()-*.
* mean_of_gravity_acceleration_time_*: Corresponds to tGravityAcc-mean()-*.
* standard_deviation_of_gravity_acceleration_time_*: Corresponds to tGravityAcc-std()-*.
* mean_of_body_acceleration_jerk_time_*: Corresponds to tBodyAccJerk-mean()-*.
* standard_deviation_of_body_acceleration_jerk_time_*: Corresponds to tBodyAccJerk-std()-*.
* mean_of_body_angularvelocity_time_*: Corresponds to tBodyGyro-mean()-*.
* standard_deviation_of_body_angularvelocity_time_*: Corresponds to tBodyGyro-std()-*.
* mean_of_body_angularvelocity_jerk_time_*: Corresponds to tBodyGyroJerk-mean()-*.
* standard_deviation_of_body_angularvelocity_jerk_time_*: Corresponds to tBodyGyroJerk-std()-*.
* mean_of_body_acceleration_frequency_*: Corresponds to fBodyAcc-mean()-*.
* standard_deviation_of_body_acceleration_frequency_*: Corresponds to fBodyAcc-std()-*.
* mean_of_body_acceleration_jerk_frequency_*: Corresponds to fBodyAccJerk-mean()-*.
* standard_deviation_of_body_acceleration_jerk_frequency_*: Corresponds to fBodyAccJerk-std()-*.
* mean_of_body_angularvelocity_frequency_*: Corresponds to fBodyGyro-mean()-*.
* standard_deviation_of_body_angularvelocity_frequency_*: Corresponds to fBodyGyro-std()-*.
* mean_of_body_acceleration_time_magnitude: Corresponds to tBodyAccMag-mean().
* standard_deviation_of_body_acceleration_time_magnitude: Corresponds to tBodyAccMag-std().
* mean_of_gravity_acceleration_time_magnitude: Corresponds to tGravityAccMag-mean().
* standard_deviation_of_gravity_acceleration_time_magnitude: Corresponds to tGravityAccMag-std().
* mean_of_body_acceleration_jerk_time_magnitude: Corresponds to tBodyAccJerkMag-mean().
* standard_deviation_of_body_acceleration_jerk_time_magnitude: Corresponds to tBodyAccJerkMag-std().
* mean_of_body_angularvelocity_time_magnitude: Corresponds to tBodyGyroMag-mean().
* standard_deviation_of_body_angularvelocity_time_magnitude: Corresponds to tBodyGyroMag-std().
* mean_of_body_angularvelocity_jerk_time_magnitude: Corresponds to tBodyGyroJerkMag-mean().
* standard_deviation_of_body_angularvelocity_jerk_time_magnitude: Corresponds to tBodyGyroJerkMag-std().
* mean_of_body_acceleration_frequency_magnitude: Corresponds to fBodyAccMag-mean().
* standard_deviation_of_body_acceleration_frequency_magnitude: Corresponds to fBodyAccMag-std().
* mean_of_body_body_acceleration_jerk_frequency_magnitude: Corresponds to fBodyBodyAccJerkMag-mean().
* standard_deviation_of_body_body_acceleration_jerk_frequency_magnitude: Corresponds to fBodyBodyAccJerkMag-std().
* mean_of_body_body_angularvelocity_frequency_magnitude: Corresponds to fBodyBodyGyroMag-mean().
* standard_deviation_of_body_body_angularvelocity_frequency_magnitude: Corresponds to fBodyBodyGyroMag-std().
* mean_of_body_body_angularvelocity_jerk_frequency_magnitude: Corresponds to fBodyBodyGyroJerkMag-mean().
* standard_deviation_of_body_body_angularvelocity_jerk_frequency_magnitude: Corresponds to fBodyBodyGyroJerkMag-std().

For the dataset_step5.txt we averaged all of these numeric variables over each combination of "subject" and "activity". For the naming we simply prefixed a "mean_per_subject_and_activity_of_" to the beginning of each numeric variable from dataset_step4.txt.
