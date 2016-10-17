library(reshape2)

# Set name of file when downloaded
filename <- "getcleandataset.zip"

# Download dataset from source
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, mode='wb')
}  

# Unzip the dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels data
actLabel <- read.table("UCI HAR Dataset/activity_labels.txt")
actLabel[,2] <- as.character(actLabel[,2])

# Load the features data
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
featuresMeans <- grep(".*mean.*|.*std.*", features[,2])
featuresMeans.name <- features[featuresMeans,2]
featuresMeans.name = gsub('-mean', 'Mean', featuresMeans.name)
featuresMeans.name = gsub('-std', 'Std', featuresMeans.name)
featuresMeans.name <- gsub('[-()]', '', featuresMeans.name)

# Load the training datasets
training <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresMeans]
trainingActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
training <- cbind(trainingSubjects, trainingActivities, training)

# Load the test datasets
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresMeans]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge the training and test datasets and add labels
allData <- rbind(training, test)
colnames(allData) <- c("subject", "activity", featuresMeans.name)

# Change the activities and subjects columns into factors
allData$activity <- factor(allData$activity, levels = actLabel[,1], labels = actLabel[,2])
allData$subject <- as.factor(allData$subject)

# Make subject and activity into id's
allData.melt <- melt(allData, id = c("subject", "activity"))

# Cast a dataset as id's versus the means and variables in allData
allData.mean <- dcast(allData.melt, subject + activity ~ variable, mean)

# Make a .txt file from the tidied dataset
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)