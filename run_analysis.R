#Getting and cleaning data course project
#setting working directory
setwd(file.path("C:","Users","David","Documents","Financial Engineering","Coursera","Getting and cleaning data","Project",
                "UCI HAR Dataset")) 
#loading and analyzing the data

train_subject<-read.table("train/subject_train.txt")  # contains variable 1:30 which describes the subject who carried out the test
#object containing training data
train_data<-read.table("train/X_train.txt") #training data-data frame of 7352 rows and 561 columns
dim(train_data)
train_labels<-read.table("train/y_train.txt")#
dim(train_labels) #dimensions 7352X1
train_labels_names<-unique(train_labels) #contains numbers 1:6
#object containing 30 training subject marked with a number from 1:30
train_subject<-read.table("subject_train.txt")  # contains variable 1:30 which decribes the subject who carried out the test 7352obs 1 variable
#object containing test data

test_data<-read.table("test/X_test.txt")#test data-data frame of 2947 rows and 561 columns

dim(test_data)
#test labels
test_labels<-read.table("test/y_test.txt")#contains test labels numbers 1:6
dim(train_labels) #dimensions 2947X1
#object containing test subject market with a number from 
test_subject<-read.table("test/subject_test.txt") #  2947obs 1 variable
test_subject_values<-unique(test_subject) # unique values for test_subject
#object containing all 561 features
features<-read.table("features.txt")# nrows 561 ncol2 (features[,2]-contains names of the features)
dim(features)

#reading activity names describing "test_labels" and "train_lebels" numerical vector
activity<-read.table('activity_labels.txt')

# 1. merging train and test data sets

 
df<-rbind(train_data,test_data)
 ##adding columnnames
colnames(df)<-c(as.character(features[,2]))

#2. Extracting columns that has only mean and sd of measurments

#vector containing index of column that has either "mean" or "std" in it.
col_index<-sort(c(grep("mean",colnames(df)),grep("std",colnames(df))))

#subsetting data set with only the columns that include particular columns
df_sub<-df[,(col_index)] # 79 columns

#3. Changing activity values by descriptive name
  #Changing values in training set
for ( i in 1:6){
train_labels<-replace(train_labels,train_labels==i,as.character(activity$V2[i]))
}
  #Changing values in test set
for ( i in 1:6){
      test_labels<-replace(test_labels,test_labels==i,as.character(activity$V2[i]))
}

#4. Labeling data set with changed activity column and test subjects column

df_sub_labels<-rbind(train_labels,test_labels) #activity label
df_sub_subject<-rbind(train_subject,test_subject) #subject column
df_sub_complete<-cbind(cbind(df_sub_subject,df_sub_labels),df_sub)
colnames(df_sub_complete)<-c("Subject","Activity",colnames(df_sub))
# 5. Creating tidy data set
#sorting data frame according to subject number and activity

df_ordered<-df_sub_complete[order(df_sub_complete$Subject,df_sub_complete$Activity),]
#Creating tidy object for storing output
tidy_df<-matrix(0,nrow=180, ncol=ncol(df_ordered))
#Computing mean of every variable according to Subject and Activity 
tidy<-aggregate(df_ordered[,3],list(Subject=df_ordered$Subject , Activity=df_ordered$Activity),mean)
for (i in 4:81) {
 tidy<-cbind(tidy,aggregate(df_ordered[,i],list(Subject=df_ordered$Subject , Activity=df_ordered$Activity),mean)[,3] )

}
colnames(tidy)<-colnames(df_ordered)
write.table(tidy,"tidy_data.txt",row.name=FALSE)
  