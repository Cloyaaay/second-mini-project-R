# 2nd-mini-project-R

Explanation of processes used in problem #1:

1. After everything was loaded and unpacked, we first need to create dataframes where each variable will be stored with their corresponding column values. To do this, the table was read and the name of the columns were assinged to a varible related to the column name. Now, we have all variables as dataframes, containing all values in its column.

2. Now that we have created the needed dataframes, we need to create a merged data containing the training and test data. After both x and y were collected, they were then merged into one.

3. We only need the mean and standard deviation on each measurement, therefore, we extracted the data by selecting only the mean and std from the merged data. Then, it was stored into ExtractedData.

4. Next, we must use descriptive activity names to name the activities in the data set, so we substituted the original variable names with readable descriptive names. We now have readable descriptive variable names which can be used in the next step.

5. Now that we have the variables with their mean and standard deviation only, we then created a clean data set which contains the mean of each variable. In other words, we have tidied up the data by creating a FinalData containing the summary of the results in each variable.