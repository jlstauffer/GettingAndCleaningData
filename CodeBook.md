CodeBook for tidyDataAverages.txt produced by run_analysis

This data set is based on measurements taken from smartphone-enabled inertial
sensors. 30 people were tested doing 6 different activities using 48 different
variables by mean or standard deviation of particular measurements. The
resultant data set is the average of each variable by subject and activity.

For additional information about the specific measurements taken in these
trials, refer to the README and features_info files in the original dataset here
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

180 rows
50 columns

Columns:
ActivityName (character) - the type of activity that was performed
SubjectID (integer) - a number between 1 and 30 representing a particular person performing the activities
Average_[measurename]_mean_XYZ (numeric) - the average of that particular mean measurement on the X, Y, or Z axis. Units are specific to the particular measurement (acceleration, angular velocity, etc.). Refer to features_info file in original data set.
Average_[measurename]_standard_deviation_XYZ - the average of that partciular standard deviation measurement on the X, Y, or Z axis. Units are specific to the particular measurement. Refer to features_info file in original data set.
