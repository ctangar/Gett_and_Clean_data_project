# Carlos Tangarife-Course Project
# run_analysis.R Script that does the following: 
#1) Merges the training and the test sets to create one data set.
#2) Extracts only the measurements on the mean and standard deviation for each measurement. 
#3) Uses descriptive activity names to name the activities in the data set
#4) Appropriately labels the data set with descriptive variable names. 
#5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#---------------------------------------------------------------------------------------
# Checks required libraries
#---------------------------------------------------------------------------------------

if(require("data.table")){
    print("data.table is loaded correctly")
} else {
    print("trying to install data.table")
    install.packages("data.table")
    if(require("data.table")){
        print("data.table installed and loaded")
    } else {
        stop("could not install data.table")
    }
}

if(require("reshape2")){
    print("reshape2 is loaded correctly")
} else {
    print("trying to install reshape2")
    install.packages("reshape2")
    if(require("reshape2")){
        print("reshape2 installed and loaded")
    } else {
        stop("could not install reshape2")
    }
}



# Load activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Load data column names
features_file <- read.table("./UCI HAR Dataset/features.txt")[,2]
extract_features <- grepl("mean|std", features_file)


#---------------------------------------------------------------------------------------
# Load and process X_test & y_test data.
#---------------------------------------------------------------------------------------

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(X_test) = features_file

#---------------------------------------------------------------------------------------
# Extract only the measurements on the mean and standard deviation for each measurement.
#---------------------------------------------------------------------------------------
X_test = X_test[,extract_features]

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]

#--------------------------------------------------------------------------
# Uses descriptive activity names to name the activities in the data set
#--------------------------------------------------------------------------

names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Load and process X_train & y_train data.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")



names(X_train) = features_file

#---------------------------------------------------------------------------------------
# Extract only the measurements on the mean and standard deviation for each measurement.
#---------------------------------------------------------------------------------------
X_train = X_train[,extract_features]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Bind data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)



#------------------------------------------
# Merge test and training data
#------------------------------------------


data = rbind(test_data, train_data)

#--------------------------------------------------------------
# Appropriately labels the data set with descriptive names.
#--------------------------------------------------------------

colnames(data) <- gsub('\\(|\\)',"",colnames(data), perl = TRUE)
# Make clearer names
colnames(data) <- gsub('Acc',"Acceleration",colnames(data))
colnames(data) <- gsub('GyroJerk',"AngularAcceleration",colnames(data))
colnames(data) <- gsub('Gyro',"AngularSpeed",colnames(data))
colnames(data) <- gsub('Mag',"Magnitude",colnames(data))
colnames(data) <- gsub('^t',"TimeDomain.",colnames(data))
colnames(data) <- gsub('^f',"FrequencyDomain.",colnames(data))
colnames(data) <- gsub('\\-mean',".Mean",colnames(data))
colnames(data) <- gsub('\\-std',".StDev",colnames(data))
colnames(data) <- gsub('Freq\\.',"Frequency.",colnames(data))
colnames(data) <- gsub('Freq$',"Frequency",colnames(data))

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Calculate mean using dcast function
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

#--------------------------------------------------------------
# Tidy data set with the average of each variable for each activity and each subject.
#--------------------------------------------------------------

write.table(tidy_data, file = "./tidy_data_set.txt")