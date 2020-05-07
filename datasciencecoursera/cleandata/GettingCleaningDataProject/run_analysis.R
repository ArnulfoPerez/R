
fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFile ="./Data/dataset.zip"

if (!file.exists("./Data")) {dir.create("Data")}

if (!file.exists(dataFile)) {
  download.file(fileURL, destfile = dataFile , method = "curl")
  dateDownloaded <- date()
}

# Checking if UCI HAR Dataset folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(dataFile) 
}

list.files("UCI HAR Dataset")
list.files("UCI HAR Dataset/test")
list.files("UCI HAR Dataset/train")

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index","fun"))
str(features)
head(features)

# 1. Merge the training and the test sets to create one data set.
# 4. Use descriptive column names

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subjectId")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$fun)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityId")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjectId")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$fun)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityId")

str(subject_test)
str(x_test)
nrow(x_test)
nrow(y_test)
nrow(subject_test)

x_merge <- rbind(x_test, x_train)
y_merge <- rbind(y_test, y_train)
subject_merge <- rbind(subject_test, subject_train)

all_merge <- cbind(x_merge,y_merge,subject_merge)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

t<-all_merge[,grepl("activityId|subjectId|mean|std",colnames(all_merge))]

# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activity"))

tidy <- merge(t, activities, by='activityId', all.x=TRUE)

# 5. Create an independent tidy data set with the average of each variable for each activity and each subject.

tidySet <- aggregate(. ~subjectId + activityId, tidy, mean)
tidySet <- tidySet[order(tidySet$subjectId, tidySet$activityId),]
str(tidySet)
head(tidySet)

write.table(tidySet, "Data/tidySet.txt", row.name=FALSE)


