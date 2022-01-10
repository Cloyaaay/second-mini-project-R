library(dplyr) #Load the library

#Unpack the data
filename <- "UCI-HAR-Dataset.zip"

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Creating dataframes and assigning them
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merging the training and data sets into Merged_Data
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#Only extract mean and standard deviation on each measurement into ExtractedData
ExtractedData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

#Use descriptive activity names to name the activities in the data set
ExtractedData$code <- activities[ExtractedData$code, 2]

# Label the data set with descriptive variable names.
names(ExtractedData)[2] = "activity"
names(ExtractedData)<-gsub("Acc", "Accelerometer", names(ExtractedData))
names(ExtractedData)<-gsub("Gyro", "Gyroscope", names(ExtractedData))
names(ExtractedData)<-gsub("BodyBody", "Body", names(ExtractedData))
names(ExtractedData)<-gsub("Mag", "Magnitude", names(ExtractedData))
names(ExtractedData)<-gsub("^t", "Time", names(ExtractedData))
names(ExtractedData)<-gsub("^f", "Frequency", names(ExtractedData))
names(ExtractedData)<-gsub("tBody", "TimeBody", names(ExtractedData))
names(ExtractedData)<-gsub("-mean()", "Mean", names(ExtractedData), ignore.case = TRUE)
names(ExtractedData)<-gsub("-std()", "STD", names(ExtractedData), ignore.case = TRUE)
names(ExtractedData)<-gsub("-freq()", "Frequency", names(ExtractedData), ignore.case = TRUE)
names(ExtractedData)<-gsub("angle", "Angle", names(ExtractedData))
names(ExtractedData)<-gsub("gravity", "Gravity", names(ExtractedData))

#Using data set in step 4, create a second, independent tidy data set with the average of each variable
for each activity and each subject.
FinalData <- ExtractedData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

str(FinalData)