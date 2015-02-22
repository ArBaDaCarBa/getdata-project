# 0 settings
data.path <- 'data'
data.name <- 'UCI HAR Dataset'

# Download file

# Unzip file. Will probably not working on windows because of the /
unzip(paste(data.path, paste(data.name, 'zip', sep='.'), sep='/'),
      exdir=data.path)

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


# Cleanup temporary vars
rm(d1, d2)
rm(l1, l2, l)
rm(s1, s2, s)
rm(i)
rm(mean.or.std.cols)
rm(activities, features)
rm(data.path, data.name)
