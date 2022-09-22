library(dplyr)
#Downloading and unzipping the data
FileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FileURL,destfile = "RawData.zip")
unzip("RawData.zip")
#ImportData function takes a directory and reads in all .txt files (excluding 'feature_info.txt' and 'README.txt') inside it.
ImportData <- function(directory) { 
        Filenames <<- dir(directory)[grepl(".txt",dir(directory))&!(dir(directory) %in% c("features_info.txt","README.txt"))]
        for (i in seq_along(Filenames)) {
                CurFilename <- gsub(".txt","",Filenames[i])
                assign(CurFilename,read.table(paste0(directory,"/",Filenames[i])),envir = globalenv())
        }
}
#Getting subdirectories of the data folder ('UCI HAR Dataset') to pass in ImportData function
Dirs <- list.dirs("UCI HAR Dataset")
for (i in seq_along(Dirs)) {
        ImportData(Dirs[i])
}
#Merging the test and train data
x <- rbind(X_test,X_train)
y <- rbind(y_test,y_train)
subject <- rbind(subject_test,subject_train)
#Renaming columns of each dataframe
y$V1 <- activity_labels[y$V1,2]
names(x) <- features$V2
names(y) <- "activity"
names(subject) <- "subject"
#Merging subjects, y (activities) and x (feature measures)
MergedData <- cbind(subject,y,x)
#Excluding measured variables other than mean and standard deviation, and renaming columns including 'mean()' and 'std()'
TidyData <- MergedData %>% 
        select(subject,activity,contains("mean()"),contains("std()")) %>%
        setNames(gsub("mean()","Mean",names(.),fixed=T)) %>%
        setNames(gsub("std()","SD",names(.),fixed=T))
#Calculating the average of each variable per subject per activity
AverageData <- TidyData %>%
        group_by(subject,activity) %>%
        summarise_all(mean)
#Writing the output as a table
write.table(AverageData,"output.txt",row.names = F)
