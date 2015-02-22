# Information about the dataset
From the [UCI's Machine learning repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones):

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

# Purpose of the script
The script UCI-HAR_tidy.R aims to download the UCI HAR dataset, unzip it, and
create a new R set of merged and tidy-ed data with pruned data.

From this dataset a new dataset will be created, with computed average for all
values by subject and by activity.

# Script details
## Script output
The script run in a R session will create two new datasets:

 - HAR.tidy: tidy and pruned dataset
 - HAR.tidy.means: dataset with the averages of HAR.tidy dataset, computed by
 subject and by activity.
 
## Tidy data
### Merge all data
The source data has been divided in two sets: a training and a test one.

The first action of the script is to merge both datasets into one, and add to
all columns meaningfull names (columns names are indicated in a separate file).

### Append activity info
Measured activy is a separate file from the measured data, and it's coded in a
numeric fashion.

The second action of the script is to append plain text activity info to the
tidy dataset.

### Add subject information
Subject information is also in another file.

The third action of the script is to add the subject information to the tidy
data.

## Data extraction
Only meaningful data has to be retained. So the script prunes all data that is
not a mean or a standard deviation.

## Average computation
The all data is aggregated by subject and by activity in a new dataset.

## File output
Averaged dataset is written in a new file named HAR-UCI-mean.txt

# Data details
The final HAR.tidy dataset consists of list of 10299 observations of 66
variables.

The first two columns are:

 - Subject: numeric value from 1 to 30, indicating the test subject
 - Activity: plain text name of the performed activity
 
Other 64 columns are numeric values of measurements means and standards
deviations.

The script is run in a totally agnostic way concerning the data. It's based
only on file positions in the downloaded archive, so it should be able to run
with a new archive conserving the same file structure.
