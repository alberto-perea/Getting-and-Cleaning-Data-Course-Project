# Code Book

This code book explains the different variables used and how the data was manipulated to create a tidy data set.

## run_analysis.R
* features_labels: data set with the labels of the feature measured variables
* activity_labels: data set with the labels of each activity with a unique ID
<br/><br/>
* train_data: data set with all the train feature measured variables with its corresponding names
* train_act_id: data set of all the train activities IDs. 
* train_act: data set with all the train activities matching its corresponding label using the **activity labels** data set and column name *activity*.
* train_subj_id: data set with all the train subjects id  and column name *subject*.
* train_df: this data set merge the data sets:
  + train_subj_id.
  + train_act.
  + train_data.
<br/><br/>
* test_data: data set with all the test feature measured variables with its corresponding names.
* test_act_id: data set of all the test activities IDs.
* test_act: data set with all the test activities matching its corresponding label using the **activity labels** data set and column name *activity*.
* test_subj_id: data set with all the test subjects id  and column name *subject*.
* test_df: this data set merge the data sets:
  + test_subj_id.
  + test_act.
  + test_data.
<br/><br/>
* total_df: data set that merge the **train_df** and **test_df**.
<br/><br/>
* col_idx: indexes of the columns where in their name has ether mean() or std().
* mean_std_df: data set extracted from **total_df** but only with the **col_idx** columns.
<br/><br/>
* average: data set extracted from **mean_std_df** grouped by subject and activity, calculating the mean of each column.