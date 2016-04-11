library(dplyr)

setwd('/Users/Daniel/Desktop/APU/Data Science/Getting and Cleaning Data/UCI HAR Dataset')

#1: Merges the training and the test sets to create one data set.

# initialize the variables with the data in the text files
activities <- read.table("activity_labels.txt")
features <- read.table("features.txt")
xTest <- read.table("test/X_test.txt")
yTest <- read.table("test/y_test.txt")
subjectTest <- read.table("test/subject_test.txt")
xTrain <- read.table("train/X_train.txt")
yTrain <- read.table("train/y_train.txt")
subjectTrain <- read.table("train/subject_train.txt")

# initialize and combine the x and y data set
dataOfX <- rbind(xTrain, xTest)
dataOfY <- rbind(yTrain, yTest)

# initialize and combine the data set
combineData <- rbind(subjectTrain, subjectTest)

# 2: Extract only the measurements on the mean and standard deviation for each measurement

# gather the data that relates to finding the mean and standard deviation
MaS <- grep("-(mean|std)\\(\\)", features[, 2])

# from the mean and standard deviation, organize the data
dataOfX <- dataOfX[, MaS]

# reorganize the columns by name
names(dataOfX) <- features[MaS, 2]

# 3: Use descriptive activity names to name the activities in the data set

# update the values in activity
dataOfY[, 1] <- activities[dataOfY[, 1], 2]

# rename the column name
names(dataOfY) <- "activity"

# 4: Appropriately label the data set with descriptive variable names

# rename the column name
names(combineData) <- "subject"

# gather all of the data and put them into a single data set
final_data <- cbind(dataOfX, dataOfY, subjectData)

# 5: Create a second, independent tidy data set with the average of each 
# variable for each activity and each subject

final_data <- ddply(final_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(final_data, "./final_data.txt", row.name=FALSE)
