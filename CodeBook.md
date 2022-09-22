# Code Book

## Data transformations

The raw data was downloaded and uzipped, resulting in *UCI HAR Dataset* folder which included *test* and *train* subdirectories. The .txt data files were read in as dataframes. These included:

-   *features*, *activity_labels*: meta data
-   *X_test*, *X_train*: test and train measured features (column names assigned based on *features*)
-   *y_test*, *y_train*: test and train activities (codes were replaced by activity names based on *activity_labels*)
-   *subject_test*, *subject_train*: test and train subjects

After merging test and train data, measured features (*x*), activities (*y*) and *subjects* data were merged as a single dataframe. Subsequently, mean and standard deviation (SD) features were extracted and their means were calculated per subject per activity.

## Variables in output

-   subject
-   activity

The remaining variables were the measured features which were coded using the following:

-   t/f: time/frequency
-   Body/Gravity
-   Acc/Gyro: Acceleration/Gyroscope
-   Jerk
-   X/Y/Z/Mag: 3-dimensional directions/magnitude
-   Mean/SD: mean/standard deviation
