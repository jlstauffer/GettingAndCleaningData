#GettingAndCleaningData README


Course project for the Coursera class "Getting and Cleaning Data" in the Data Science track.

Contains script file run_analysis.R. File contains a single function,
run_analysis(), which creates a tidy data set and exports to a file, per the
terms of the assignment. The data set is based on data taken from a test of
30 subjects using a smartphone-enabled inertial sensor. The subjects were
randomly separated into two groups, test and train, which have similarly
structured files.

run_analysis() performs the following steps:

1. Downloads and unzips the data file.
2. Reads in the files that will serve as data labels.
3. Determines which measure labels will be used. For this assignment, only
   measurements of mean and standard deviation are to be returned. It is
   assumed that measures that have "-mean()-" or "-std()-" in their name are
   mean and standard deviation measures respectively.
4. Reads in the test data files and combines into a single data frame.
5. Reads in the train data files and combines into a single data frame.
6. Combines the test and train data frames into a single data frame.
7. Combines the resulting data set with the activity labels read in earlier to
   get descriptive activity names.
8. Aggregates the data set by activity name and subject ID. Gets the average of
   each of the variables.
9. Writes the resulting data frame to a file.
