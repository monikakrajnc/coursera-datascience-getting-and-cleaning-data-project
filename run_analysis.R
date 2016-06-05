run_analysis <- function(workingDirectory){

##Sets the work directory, needs to be specified when calling the function
setwd(workingDirectory)

##Load and bind data from the test folder
test_X <- read.table("test/X_test.txt")
test_Y <- read.table("test/Y_test.txt")
test_S <- read.table("test/subject_test.txt")
test_SYX <- cbind(test_S, test_Y, test_X)

##Load and bind data from the train folder
train_X <- read.table("train/X_train.txt")
train_Y <- read.table("train/y_train.txt")
train_S <- read.table("train/subject_train.txt")
train_SYX <- cbind(train_S, train_Y, train_X)

##Bind the test and train data
T_T <- rbind(test_SYX, train_SYX) 

##Load features.txt and name the columns
features <- read.table("features.txt")
a <- subset(features, select = V2)
ta <- t(a)
colnames(T_T)[3:563] <- ta[1,1:561]

##Name the first two columns
colnames(T_T)[1] <- "Subject"
colnames(T_T)[2] <- "Activity"

##Creates a subset of the mean values
b <- grep("mean", names(T_T))
T_Tmean <- subset(T_T, select = c(b))

##Creates a subset of the std values
c <- grep("std", names(T_T))
T_Tstd <- subset(T_T, select = c(c))

##Creates a subset of Subject and Activity
T_Tsa <- subset(T_T, select = c(1:2))

##Merges all the above subsets into T_TSAMS
T_TSAMS <- cbind(T_Tsa, T_Tmean, T_Tstd)

##Rename the variables to be more descriptive
names(T_TSAMS)<-gsub("mean", "Mean", names(T_TSAMS))
names(T_TSAMS)<-gsub("std", "StandardDeviation", names(T_TSAMS))
names(T_TSAMS)<-gsub("^t", "Time", names(T_TSAMS))
names(T_TSAMS)<-gsub("^f", "Frequency", names(T_TSAMS))
names(T_TSAMS)<-gsub("Acc", "Accelerometer", names(T_TSAMS))
names(T_TSAMS)<-gsub("Gyro", "Gyroscope", names(T_TSAMS))
names(T_TSAMS)<-gsub("Mag", "Magnitude", names(T_TSAMS))
names(T_TSAMS)<-gsub("BodyBody", "Body", names(T_TSAMS))
names(T_TSAMS)<-gsub("()", "", names(T_TSAMS))
names(T_TSAMS)<-gsub("-", "", names(T_TSAMS))

##Calculate averages of each variable for each activity and each subject
avg <- aggregate(T_TSAMS, list(T_TSAMS$"Activity",T_TSAMS$"Subject"), mean, simplify=TRUE)
avg <- avg[,3:83]

#Take the row names from activity_labels.txt and apply them to the avg data.frame
act_labels <- read.table("activity_labels.txt")
d <- subset(act_labels, select = V2)
td <- t(d)
for(i in 1:6){
avg$"Activity"[avg$"Activity"==i]<-td[i]
}

##Write avg data.table to a txt file, without row names
write.table(avg, file="tidy_data.txt", row.name=FALSE)

}