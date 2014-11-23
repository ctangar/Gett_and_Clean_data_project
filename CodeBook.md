#CodeBook
This is a code book that describes the variables, the data, and any transformations or work performed to clean up the data in the Course Project of “Getting and Cleaning Data.
##The data source

*  **Original data:** https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* **Dataset description**:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data[1]. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain[1]. 


![plot of chunk unnamed-chunk-2](data.jpg) 


#Dataset

The dataset includes the following files:

'README.txt'

* **'features_info.txt':** Shows information about the variables used on the feature vector.

* **'features.txt':** List of all features.

* **'activity_labels.txt':** Links the class labels with their activity name.

* **'train/X_train.txt':** Training set.

* **'train/y_train.txt':** Training labels.

* **'test/X_test.txt':** Test set.

* **'test/y_test.txt':** Test labels.

#Train and test data descriptions

The following files are available for the train and test data. Their descriptions are equivalent.

* **'train/subject_train.txt':** Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

* **'train/Inertial Signals/total_acc_x_train.txt':** The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

* **'train/Inertial Signals/body_acc_x_train.txt':** The body acceleration signal obtained by subtracting the gravity from the total acceleration.

* **'train/Inertial Signals/body_gyro_x_train.txt':** The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

#Signals
The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window at 50 Hz). From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
The set of variables that were estimated from these signals are:

*	mean(): Mean value
*	std(): Standard deviation
*	mad(): Median absolute deviation
*	max(): Largest value in array
*	min(): Smallest value in array
*	sma(): Signal magnitude area
*	energy(): Energy measure. Sum of the squares divided by the number of values.
*	iqr(): Interquartile range
*	entropy(): Signal entropy
*	arCoeff(): Autoregression coefficients with Burg order equal to 4
*	correlation(): Correlation coefficient between two signals
*	maxInds(): Index of the frequency component with largest magnitude
*	meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*	skewness(): Skewness of the frequency domain signal
*	kurtosis(): Kurtosis of the frequency domain signal
*	bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
*	angle(): Angle between some vectors.

#Data transformation

The raw data sets are processed with run_analisys.R script to create a tidy data set.

**Merge training and test sets**
Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt, subject_test.txt) and activity ids (y_train.txt, y_test.txt) are merged to obtain a single data set.

**Extract mean and standard deviation variables**
From the merged data set is extracted and intermediate data set with only the values of estimated mean (variables with labels that contain "mean") and standard deviation (variables with labels that contain "std").

**Use descriptive activity names**
A new column is added to intermediate data set with the activity description. Activity id column is used to look up descriptions in activity_labels.txt.

**Label variables appropriately**
Labels given from the original collectors were changed: to obtain valid R names without parentheses, dashes and commas to obtain more descriptive labels

**Create a tidy data set**
From the intermediate data set is created a final tidy data set where numeric variables are averaged for each activity and each subject.



##Citation

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
