##The following function performs the required analysis on the dataset
##in order to run this code, please place extract the ZIP Folder and place
##the subfolder "UCI HAR Dataset" in your working directory. All the sub-folders
##must be present within this directory for this code to work properly.

run_analysis <- function()
{

##READ ALL THE TEST RELATED DATA
setwd("UCI HAR Dataset")
setwd("test")
test_data <- read.table("X_test.txt") ##Reading testing data set
sub_test <- read.table("subject_test.txt") ##Reading subject test set
act_test <- read.table("y_test.txt") ##Reading activity test set
setwd("C:/Users/AdityaS/Documents/UCI HAR Dataset") ##Go back to parent dir

##READ ALL THE TRAINING RELATED DATA
setwd("train")
train_data <- read.table("X_train.txt") ##Reading training data set
sub_train <- read.table("subject_train.txt") ##Reading subject train set
act_train <- read.table("y_train.txt") ##Reading activity train set
setwd("C:/Users/AdityaS/Documents/UCI HAR Dataset")

##STEP ONE: MERGING- merge the two tables along with subject and activity numbers
test_data <- cbind(act_test,test_data) ##Add activity number info: test
test_data <- cbind(sub_test,test_data) ##Add subject test info: test
train_data <- cbind(act_train,train_data) ##Add activity number info: train
train_data <- cbind(sub_train,train_data) ##Add subject train info: train
subset_data <- rbind(test_data,train_data)

##LABEL THE COLUMNS OF THE RESULTANT DATASET
features_data <- read.table("features.txt") ##Reading features data
act_lables <- read.table("activity_labels.txt") ##Reading activity labels
colnames(subset_data) <- c("Subject Number", "Activity Number", as.character(features_data$V2))
##Setting column names for test data

##SUBSET THE NEW DATA TO HAVE ONLY MEANS AND STD DEVIATIONS
col_index <- 2 + c(-1,0,1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,294:296,345:350,373:375,424:429,452:454,503,504,513,516,517,526,529,530,539,542,543,552,559:561)
new_data <- subset(subset_data,select=col_index) ##Subset the new data

##ADD ACTIVITY NAMES TO THE SUBSETTED DATA FRAME
for(i in 1:10299)
{
  if(new_data$`Activity Number`==1)
    new_data$Activity_Name <- "WALKING"
  else if(new_data$`Activity Number`==2)
    new_data$Activity_Name <- "WALKING_UPSTAIRS"
  else if(new_data$`Activity Number`==3)
    new_data$Activity_Name <- "WALKING_DOWNSTAIRS"
  else if(new_data$`Activity Number`==4)
    new_data$Activity_Name <- "SITTING"
  else if(new_data$`Activity Number`==5)
    new_data$Activity_Name <- "STANDING"
  else if(new_data$`Activity Number`==6)
    new_data$Activity_Name <- "LAYING"
}
#Reordering columns so that activity names are in 3rd column
new_data <- new_data[c(1,2,85,3:84)]
final_data <- NULL

#Group the data and apply the mean for different measurements within each
#subject for the same activity numbers and store result in new frame, final_frame
for(i in 1:30)
{
sub_data <- subset(new_data,`Subject Number`==i)
f_data <- apply(sub_data[,c(4:85)], 2, function(x) tapply(x, sub_data$`Activity Number`, mean))
final_data <- rbind(final_data,cbind(Subject_Number=rep(i,6),Activity_Number=act_lables$V1,Activity_Name=as.character(act_lables$V2),f_data))
}
final_frame <- data.frame(final_data)

#Write contents of the frame to text file and display the frame in console
write.table(final_frame,"Ouput_CleanedData.txt",row.names = FALSE, sep="\t")
View(final_frame)
}