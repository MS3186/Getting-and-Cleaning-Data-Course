# Code book for work performed

## Initial data
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate 
of 50Hz. The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training 
data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width 
sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, 
was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 
See 'features_info.txt' for more details. 

### For each record it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

### The dataset includes the following files:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- *'train/subject_train.txt': 
Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- *'train/Inertial Signals/total_acc_x_train.txt': 
The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- *'train/Inertial Signals/body_acc_x_train.txt': 
The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- *'train/Inertial Signals/body_gyro_x_train.txt': 
The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Resulting data
There are 2 resulting data sets:
* one data set - tbl_overall_activity - is a data set that
  * aggregates training and test sample data gathered during the study
  * identifies each observation with a subject number and the subject activity during the observation
  * only includes mean and standard deviation of the variables measured during the study
* one data set - grouped_average - is a data set that
  * is based on the tbl_overall_activity, for which every measurment is average after a grouping by subject and by activity

## Cleaning performed
The following tranformations were performed for tbl_overall_activity
* The data sets "training" and "test" were gathered as a single data set using the following steps for the data set dealing 
with subject (subject_),activity (y_) and features observations (X_)
  * download and loading of each csv file
  * use of rbind to gather observations in a single data set
  * name the columns to make them descriptive. 
  
 * For the feature observations, the data set was filtered to only keep observation mean and standard deviation, using a filtering criteria
 based on the feature names
 
 * Data for test and train were then, aggregated in a single data that includes subject, activity and mean/std observations. 
 A mapping was done to make the activity index descriptive using the activity csv resource file
 
 Additional actions performed on the top of the previously mentioned ones to create grouped_average
 * the data set was grouped by subject and activity
 * every observation was averaged keeping result for each subject and activity groups

