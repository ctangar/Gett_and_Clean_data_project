#Course project Getting and Cleaning Data

##What you find in this repository

3 files listed below:

*	**CodeBook.md:** information about raw and tidy data set and elaboration made to transform them
*	**README.md:** this file
*	**run_analysis.R:** R script to transform raw data set in a tidy one

## Operation "run_analysis.R" script

The script does the following:

1.	Merge the training and the test sets to create one data set.
2.	Extract only the measurements on the mean and standard deviation for each measurement.
3.	Use descriptive activity names to name the activities in the data set
4.	Label the data set with descriptive activity names.
5.	Create a tidy data set with the average of each variable for each activity and each subject.

## Dependencies

Dependencies are automatically installed by the script

## How to work with this course project

1.	You should download the data source and unzip it in your working directory, the data now are located into a "UCI HAR Dataset" folder
2.	Copy run_analysis.R in the parent folder of UCI HAR Dataset.
3.	Run source("run_analysis.R"), then it will generate a new file tiny_data_set.txt in your working directory.






