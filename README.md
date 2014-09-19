getdata_project
===============

Course project for Getting and Cleaning Data

Running the code
----------------

To run the script just call

> source('run_analysis.R')

Code book
---------

A code book is given in the codebook.md file.

Explanation of the source code
------------------------------

First the workspace is cleaned (makes sense to avoid problems). Next lots of data is loaded:
* X_*: To quote from README.txt from the data set: "561-feature vector with time and frequency domain variables".
* y_*: The labels, i.e. the actions that the subject did.
* subject_*: The id of the subject for each row.
* features: A table naming each column of X_*.
* activity_labels: A table naming each activity.

First we merge the training and test data in the obvious way (rbind). This satisfies step "1. Merges the training and the test sets to create one data set." of the assignment.

Next we do step "2. Extracts only the measurements on the mean and standard deviation for each measurement.". I interpreted as getting the fields having "mean()" or "std()" in its name. This interpretation explicitly means that I ignore the fields having "meanFreq()" in their name. Why this decision? You can read in feature_info.txt of the dataset: "meanFreq(): Weighted average of the frequency components to obtain a mean frequency". Thus meanFreq() is a more complicated average than a mean and thus not to be considered in the exercise. So it is principally clear which fields to extract and I only have to explain my implementation.

Instead of (error-prone) looking up for column indices, the program will determine the row indices by itself. The code for this purpose might look a little bit confusing. To understand it, consider (compare the file features.txt of the dataset for reference) that each field that we are interested in, is of one of the following two formats:

* A-C()-D
* B-C()

where A, B are some labels, C is from {mean, std} and D is from {X, Y, Z}. Thus we just have to provide the labels for A and B to build all the strings. These are in the variables "xyz_signals" and "other_signals". We just run a serious of two multiple nested for loops and after that we have all the names that we are interested in in a variable called "names". Then we just check (the file "feature.txt" or the variable "features" (where this dataset is loaded into) contain the key for this) what the column indices of this field names are (stored in variable "cols") - job done. Then we just have to use

> out_dataset1 <-data.frame(X[,cols])

to get the correct columns (but we won't do that since we want additional columns).

For "3. Uses descriptive activity names to name the activities in the data set.", we simply use
> activity_column <- activity_labels[y[,1], 2]
where (as described) y denotes the activity of each row and activity labels tells us the name of each activity. Now we can create a first dataset:
> clean_dataset1 <-data.frame(X[,cols], subject, activity_column)
The variable names will be ugly, but this is the work for the next step:

Concerning part "4. Appropriately labels the data set with descriptive variable names." Since most reviewers would not consider the naming of the columns from features.txt as descriptive, we have to find better names.