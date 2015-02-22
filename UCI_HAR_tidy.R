# Download file in the data folder
if (!file.exists('data')) {dir.create('data', recursive=TRUE)}
if (!file.exists('data/UCI HAR Dataset.zip')) {
  message('Downloading data file')
  url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  download.file(url, destfile='data/UCI HAR Dataset.zip', method='curl')
  rm(url)
}

# Unzip file. Will probably not working on windows because of the /
unzip('data/UCI HAR Dataset.zip', exdir='data')

# Read the data files and merge them
d1 <- read.table('data/UCI HAR Dataset/test/X_test.txt', sep='', header=F)
d2 <- read.table('data/UCI HAR Dataset/train/X_train.txt', sep='', header=F)
HAR.tidy <- rbind(d1, d2)

# Add the correct column names
features <- read.table('data/UCI HAR Dataset/features.txt', header=F)
names(HAR.tidy) <- features[,2]

# Add activity info
l1 <- read.table('data//UCI HAR Dataset/test/y_test.txt')
l2 <- read.table('data//UCI HAR Dataset/train/y_train.txt')
l <- rbind(l1, l2)
HAR.tidy <- cbind(l, HAR.tidy)
names(HAR.tidy)[1] <- 'Activity'

# Add subject info
s1 <- read.table('data/UCI HAR Dataset/test/subject_test.txt')
s2 <- read.table('data/UCI HAR Dataset/train/subject_train.txt')
s <- rbind(s1, s2)
HAR.tidy <- cbind(s, HAR.tidy)
names(HAR.tidy)[1] <- 'Subject'

# Correct activities label
activities <- read.table('data/UCI HAR Dataset/activity_labels.txt')
for (i in 1:nrow(activities)) {
  HAR.tidy$Activity <- replace(HAR.tidy$Activity, HAR.tidy$Activity==i,
                               as.vector(activities[i, 2]))
}

# Remove non mean and non std columns
mean.or.std.cols <- grep('(mean|std)\\(\\)', features[,2])
HAR.tidy <- HAR.tidy[,mean.or.std.cols]

# Create dataset with average for each activity and each dataset
HAR.tidy.means <- aggregate(HAR.tidy[3:length(HAR.tidy)],
                             by=list(Subject=HAR.tidy$Subject,
                                     Activity=HAR.tidy$Activity), FUN=mean)


# Write averaged dataset to file
message('Writing averaged tidy data to file')
write.table(HAR.tidy.means, file="HAR-UCI-mean.txt", row.names=FALSE)

# Cleanup temporary vars
rm(d1, d2)
rm(l1, l2, l)
rm(s1, s2, s)
rm(i)
rm(mean.or.std.cols)
rm(activities, features)
