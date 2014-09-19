# Clean workspace
rm(list=ls())

# Load data; this takes some time
X_train <- read.table(unz('getdata-projectfiles-UCI HAR Dataset.zip', 
                            'UCI HAR Dataset/train/X_train.txt'))
X_test <- read.table(unz('getdata-projectfiles-UCI HAR Dataset.zip', 
                           'UCI HAR Dataset/test/X_test.txt'))
y_train <- read.table(unz('getdata-projectfiles-UCI HAR Dataset.zip', 
                          'UCI HAR Dataset/train/y_train.txt'))
y_test <- read.table(unz('getdata-projectfiles-UCI HAR Dataset.zip', 
                         'UCI HAR Dataset/test/y_test.txt'))
subject_train <- read.table(unz('getdata-projectfiles-UCI HAR Dataset.zip', 
                                'UCI HAR Dataset/train/subject_train.txt'))
subject_test <- read.table(unz('getdata-projectfiles-UCI HAR Dataset.zip', 
                               'UCI HAR Dataset/test/subject_test.txt'))

features <- read.table(unz('getdata-projectfiles-UCI HAR Dataset.zip', 
                           'UCI HAR Dataset/features.txt'))
activity_labels <- read.table(unz('getdata-projectfiles-UCI HAR Dataset.zip', 
                                  'UCI HAR Dataset/activity_labels.txt'))

print("Data loaded")

# 1. Merges the training and the test sets to create one data set.
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Free memory that we don't need anymore
rm(X_train)
rm(X_test)
rm(y_train)
rm(y_test)
rm(subject_train)
rm(subject_test)

xyz_signals <- c("tBodyAcc", 
                 "tGravityAcc", 
                 "tBodyAccJerk", 
                 "tBodyGyro", 
                 "tBodyGyroJerk", 
                 "fBodyAcc", 
                 "fBodyAccJerk", 
                 "fBodyGyro")

xyz_desc <- c("body_acceleration_time", 
              "gravity_acceleration_time", 
              "body_acceleration_jerk_time", 
              "body_angularvelocity_time", 
              "body_angularvelocity_jerk_time", 
              "body_acceleration_frequency", 
              "body_acceleration_jerk_frequency", 
              "body_angularvelocity_frequency")

other_signals <- c("tBodyAccMag", 
                   "tGravityAccMag", 
                   "tBodyAccJerkMag", 
                   "tBodyGyroMag", 
                   "tBodyGyroJerkMag", 
                   "fBodyAccMag", 
                   "fBodyBodyAccJerkMag", 
                   "fBodyBodyGyroMag", 
                   "fBodyBodyGyroJerkMag")

other_signal_desc <- c("body_acceleration_time", 
                       "gravity_acceleration_time", 
                       "body_acceleration_jerk_time", 
                       "body_angularvelocity_time", 
                       "body_angularvelocity_jerk_time", 
                       "body_acceleration_frequency", 
                       "body_body_acceleration_jerk_frequency", 
                       "body_body_angularvelocity_frequency", 
                       "body_body_angularvelocity_jerk_frequency")

# We ignore ...-meanFreq() since it is not clear from the 
# assignment description (2.) whether to include it or not

names <- c()
names_descriptive <- c()

array_idx <- 1

for (array_idx in 1:length(xyz_signals)) {
  for (type in c("mean", "std")) {
    for (coord in c("X", "Y", "Z")) {
      names <- c(names, paste0(xyz_signals[array_idx], "-", type, "()-", coord))
      
      if (type == "mean") {
        curr_desc_name <- "mean"
      } else {
        curr_desc_name <- "standard_deviation"
      }
      curr_desc_name = paste0(curr_desc_name, "_of_", xyz_desc[array_idx], "_", coord)
      names_descriptive <- c(names_descriptive, curr_desc_name)
    }
  }
}

array_idx <- 1

for (array_idx in 1:length(other_signals)) {
  for (type in c("mean", "std")) {
    names <- c(names, paste0(other_signals[array_idx], "-", type, "()"))
    
    if (type == "mean") {
      curr_desc_name <- "mean"
    } else {
      curr_desc_name <- "standard_deviation"
    }
    curr_desc_name = paste0(curr_desc_name, "_of_", other_signal_desc[array_idx], "_magnitude")
    names_descriptive <- c(names_descriptive, curr_desc_name)
  }
}

cols <- vector(length=length(names))
idx <- 1

for (name in names) {
  cols[idx] <- as.numeric(which(features[,2] == name))
  idx <- idx + 1
}

activity_column <- activity_labels[y[,1], 2]
clean_dataset1 <-data.frame(subject, activity_column, X[,cols])
colnames(clean_dataset1) <- c("subject", "activity", 
                              names_descriptive
                              #names
                              )

clean_dataset2 <- aggregate(clean_dataset1[,!names(clean_dataset1) %in% c("subject", "activity")], by=list(clean_dataset1$subject, clean_dataset1$activity), FUN=mean)
varnames <- colnames(clean_dataset2)[3:ncol(clean_dataset2)]
varnames <- paste0("mean_per_subject_and_activity_of_", varnames)
colnames(clean_dataset2) <- c("subject", "activity", varnames)

write.table(clean_dataset1, file = "dataset_step4.txt", row.name=FALSE)
write.table(clean_dataset2, file = "dataset_step5.txt", row.name=FALSE)
