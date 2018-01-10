## change working directory to location where data was unzipped
## setwd("./UCI HAR Dataset")

## load data.table package to use fread function
## load dplyr to use mutate function
library(data.table)
library(dplyr)

## load resource data used for naming
        ## activity mapping for assignment item 5
        activity <- fread("activity_labels.txt")
        names(activity)<- c("index","ActivityName")
        
        ## features mapping to be used for set naming for assignment item 3
        feature <- fread("features.txt")

## Gather test and training data in a unique dataset for each type of data
        ## X data - read from files, combine and rename
        datXtest <- fread("./test/X_test.txt")
        datXtrain <- fread("./train/X_train.txt")
        datX <- rbind(datXtest,datXtrain)
        ## create descriptive column name (item 4) from the features support file and extract only data with mean or std value
        names(datX) <- feature$V2
        sub_name <- grep("mean|std",names(datX),value=TRUE)
        datXMeanStd <- subset(datX,select = sub_name)
        rm("datXtest","datXtrain","datX")
        
        ## Y data - read from files, combine and rename
        datYtest <- fread("./test/y_test.txt")
        datYtrain <- fread("./train/y_train.txt")
        datY <- rbind(datYtest,datYtrain)
        rm("datYtest","datYtrain")
        names(datY)<- "activity"
        
        
        ## subject data - read from files, combine and rename
        datSubtest <- fread("./test/subject_test.txt")
        datSubtrain <- fread("./train/subject_train.txt")
        datSub <- rbind(datSubtest,datSubtrain)
        rm("datSubtest","datSubtrain")
        names(datSub)<- "subject"
        

## create a unique dataset with subject, activity and result but concatenating columns
## transform in tbl_df to use dplyr package for further mutations
       overall <- cbind(datSub,datY,datXMeanStd)
       tbl_overall <- tbl_df(overall)
       rm("datSub","datY","datXMeanStd","overall")
       

## includes activity name in the global table 
## using the merge function between the table and the "activity" table of reference
       tbl_overall_activity <- merge(tbl_overall, activity, by.x="activity",by.y="index")
## remove the activity index that was used for the mapping to the activity name
       tbl_overall_activity <- select(tbl_overall_activity, -activity)
       rm("tbl_overall","activity","feature","sub_name")
       
## Item 5 of assignment - create a second independent tidy data with 
## the average of each variable for each activity and each subject
     grouped <- group_by(tbl_overall_activity,subject,ActivityName)
     grouped_average<-summarise_all(grouped,mean)
     rm("grouped")
     
## extract the data as csv
     write.csv(tbl_overall_activity,"tbl_overall_activity.csv")
     write.csv(grouped_average,"grouped_average.csv")   
       
       
