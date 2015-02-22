# 0 settings
data.path <- 'data'
data.name <- 'UCI HAR Dataset'

# 1 Dowload file

# 2 Unzip file
unzip(paste(data.path, paste(data.name, 'zip', sep='.'), sep='/'), exdir=data.path)

# Read the data files and merge them
d1 <- read.table('data/UCI HAR Dataset/test/X_test.txt', sep='', header=F)
d2 <- read.table('data/UCI HAR Dataset/train/X_train.txt', sep='', header=F)
d <- rbind(d1, d2)
rm(d1, d2)

# Add the correct column names
features <- read.table('data/UCI HAR Dataset/features.txt', header=F)
names(d) <- features[,2]

# Add activity info
l1 <- read.table('data//UCI HAR Dataset/test/y_test.txt')
l2 <- read.table('data//UCI HAR Dataset/train/y_train.txt')
l <- rbind(l1, l2)
d <- cbind(l, d)
names(d)[1] <- 'Activity'
rm(l1, l2, l)

# Add subject info
s1 <- read.table('data/UCI HAR Dataset/test/subject_test.txt')
s2 <- read.table('data/UCI HAR Dataset/train/subject_train.txt')
s <- rbind(s1, s2)
d <- cbind(s, d)
names(d)[1] <- 'Subject'
rm(s1, s2, s)

# Correct activities label
activities <- read.table('data/UCI HAR Dataset/activity_labels.txt')
for (i in 1:nrow(activities)) {
  d$Activity <- replace(d$Activity, d$Activity==i, as.vector(activities[i, 2]))
}
rm(i)

# Remove non mean and non std columns
mean.or.std.cols <- grep('(mean|std)\\(\\)', features[,2])
e <- d[,mean.or.std.cols]
