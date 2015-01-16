Course Project
===================




Description of run_analysis.R
-------------
- Downloading all necessary files for analysis
object **train_data** [7532x561]holds training data
object **test_data** [2941x561holds test data
object **train_labels** [7352x1] holds activity (described by number 1:4) for training data set.
object **test_labels** [2941x1] holds activity (described by number 1:4) for test data set.
object **train_subject**[7532x1] contains id number of person carried out the test in training test
object **test_subject** [2941x1]  contains id number of person carried out the test in testing test
object **features**[1x561] holds the names of all variables the test been performed for.
object **activities** holds description of activities for variables in **train_labels** and **test_labels**

- Merging the training and test data set
function **rbind()** clips the **train_data** and **test_data**
The new data set is stored as **df** object with column names representing the all 561 features.

- Extracting columns that only have 'mean' and 'std 
function **grep** extracts only those features that contains 'mean' and 'std in it. The outcome is 79 columns. The data set is stored as object 
**df_sub**
- Changing **train/test-labels** by its descriptive activity from **activity** object
It is implemented by loop with **replace()** function. 

- Labeling data set with appropriate **Subject** and **Activity** labels
 First **rbind** is used to clip **train_subject** and **test_subject** together and stored as **df_sub_labels** object. Second, modified **train_labels** and **test_labels** are clipped with **rbind** and stored as **df_sub_subject**. Lastly, **df_sub_labels** and **df_sub_subject** is added as two additional columns to **df_sub** object and stored as **df_sub_complete** object.
- Creating tidy data set
First data set **df_sub_complete** is sorted by "Subject" and "Activity" factors with function **order()**.
Second, the mean of all variables is computed by "Subject" and "Activity" factor using the loop and **aggregate()** function.
The final result is stored in object **tidy** and written in the text file **"tidy_data.txt"**.
