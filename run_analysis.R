run_analysis <- function() {

      ## Download and unzip the data files
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(url = fileURL, destfile = "./Dataset.zip", method = "curl")
      unzip(zipfile = "Dataset.zip")
      
      
      ## Set up the activity.label and measurement.type data frames.
      ## These data frames will serve as lookup values for the main data set.
      activity.label <- read.table("./UCI HAR Dataset/activity_labels.txt"
                                    ,stringsAsFactors = FALSE)
      colnames(activity.label) <- c("ActivityID", "ActivityName")
      
      measurement.type <- read.table("./UCI HAR Dataset/features.txt"
                                 , stringsAsFactors = FALSE)
      colnames(measurement.type) <- c("MeasurementID","MeasurementName")
      
      
      ## The measurements in question are mean and standard deviation. These are
      ## assumed to be measurements with "-mean()-" or "-std()-" in their names.
      
      ## Find the applicable measurements in measurement.type$MeasurementName.
      ## The resulting vector will be the applicable column indices in the collected
      ## data set.
      meanMeasurement <- grep(pattern = "-mean()-",
                              x = measurement.type$MeasurementName,
                              fixed = TRUE)
      stdDevMeasurement <- grep(pattern = "-std()-",
                                x = measurement.type$MeasurementName,
                                fixed = TRUE)
      measurementToUse <- c(meanMeasurement, stdDevMeasurement)
      
      
      
      ## TEST DATA SECTION #####################################
      
      ## Read in the files containing the test data.
      ## The X file contains the actual measurements. Column names correspond to the
      ##   values in measurement.type
      xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                          col.names = measurement.type$MeasurementName,
                          colClasses = "numeric")
      ## The Y file contains the ID for the activity that was performed in the 
      ##    respective row in the X file.
      ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt",
                          col.names = "ActivityID",
                          colClasses = "integer")
      ## The subject file contains the ID for the test subject who performed the
      ##   activities in the respective row in the X file.
      subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                                col.names = "SubjectID",
                                colClasses = "integer")
      ## Take only the applicable columns in the actual measurements.
      xtest <- xtest[,measurementToUse]
      ## Combine X, Y, and subect into single data frame.
      test <- cbind(subjecttest, ytest, xtest)
      
      
      ## TRAIN DATA SECTION #####################################
      ## See the notes under the TEST DATA SECTION. The procedure is the same.
      xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                          col.names = measurement.type$MeasurementName,
                          colClasses = "numeric")
      ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt",
                          col.names = "ActivityID",
                          colClasses = "integer")
      subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                                 col.names = "SubjectID",
                                 colClasses = "integer")
      xtrain <- xtrain[,measurementToUse]
      train <- cbind(subjecttrain, ytrain, xtrain)
      
      
      ## Combine the test and train data frames into a single data frame.
      tidyData <- rbind(test, train)
      
      
      ## Combine with the activity.label data frame to get the activity names.
      tidyData <- merge(x = activity.label, y = tidyData,
                       by.x = "ActivityID", by.y = "ActivityID",
                       all.x = FALSE, all.y = TRUE)
      
      ## Clean up the variable names (stray characters, spelled-out variables)
      colnames(tidyData) <- gsub("..", "", colnames(tidyData), fixed=TRUE)
      colnames(tidyData) <- gsub(".", "_", colnames(tidyData), fixed=TRUE)
      colnames(tidyData) <- gsub("std","standard_deviation",
                                 colnames(tidyData) ,fixed=TRUE)
      
      
      ## Get the average of each variable for each activity and subject
      library(reshape2)
      tidyDataMelt <- melt(tidyData, id = c("ActivityName","SubjectID"),
                           measure.vars = colnames(tidyData[,4:ncol(tidyData)]))
      tidyDataAverages <- dcast(tidyDataMelt,
                                ActivityName + SubjectID ~ variable, mean)
      
      ## Rename columns to appropriately reflect the averages
      for (i in 3:ncol(tidyDataAverages)) {
            colnames(tidyDataAverages)[i] <-
                  paste("Average",colnames(tidyDataAverages)[i],sep = "_")
      }
      
      ## Write the final data set
      write.table(tidyDataAverages,
                  file = "./UCI HAR Dataset/tidyDataAverages.txt",
                  row.names = FALSE)

}