## Getting and Cleaning Data
## 1.Merge the training and the test sets to create one data set.
testData <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
allData <- rbind(testData, trainData)

## 2.Extract only the measurements on the mean and standard deviation for each measurement. 
subData<-allData[,c("V1","V2","V3","V4","V5","V6",
              "V41","V42","V43","V44","V45","V46",
              "V81","V82","V83","V84","V85","V86",
              "V121","V122","V123","V124","V125","V126",
              "V161","V162","V163","V164","V165","V166",
              "V201","V202","V214","V215","V227","V228","V240","V241","V253","V254",
              "V266","V267","V268","V269","V270","V271",
              "V345","V346","V347","V348","V349","V350",
              "V424","V425","V426","V427","V428","V429",
              "V503","V504","V516","V517","V529","V530","V542","V543")]

## 3.Use descriptive activity names to name the activities in the data set
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                              col.names = c("activity.no", "activity.name"), 
                              stringsAsFactors=FALSE,
                              header = FALSE)
test.labels <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
train.labels <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
allLabels <- rbind(test.labels, train.labels)

activity<-matrix(nrow=10299,ncol=1) ##create a matrix of activity names
for (i in 1:10299){
  j <- allLabels$V1[i]
  activity[i] <- activity.labels$activity.name[j]  
}
subData<-cbind(subData,activity) ##cbind the activity names to subData

test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subjects <- rbind(test.subject, train.subject)
subData <- cbind(subData,subjects$V1) ##cbind the subject numbers to subData

## 4.Appropriately label the data set with descriptive variable names. 
features.text <- read.table("./UCI HAR Dataset/features.txt", 
                            col.names = c("feature.no", "feature.name"), 
                            stringsAsFactors=FALSE,
                            header = FALSE)

##remove special chars from variable names
for (i in 1:561){
  features.text$feature.name[i]<-(gsub("[[:punct:]]", "", features.text$feature.name[i]))
}
##give descriptive variable names
index<-as.numeric(gsub("V","",names(subData[1:66])))
colnames(subData)[1:66]<-features.text$feature.name[index[1:66]]
colnames(subData)[68]<-c("subject")

## 5.From the data set in step 4, create a second, independent tidy data set 
##     with the average of each variable for each activity and each subject.
vars<-features.text$feature.name[index]
meanData<-aggregate(subData[vars], 
                    by=list(subject=subData$subject,activity=subData$activity),mean)
orderData<-meanData[order(meanData$subject,meanData$activity),]

## melt orderData into tidyData
library(reshape2)
tidyData<-melt(orderData,id=c("subject","activity"))

## write tidyData to current directory
write.csv(tidyData, file="tidy.csv",row.names=FALSE)
## read tidy.csv from local directory
viewTidyData <- read.csv("tidy.csv",header=TRUE)
