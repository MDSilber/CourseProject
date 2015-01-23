# import dplyr library for later use
library(dplyr)

# helper function to merge two files (since we do it for all three
# files in test/ and train/ respectively)
mergeTwoFiles <- function(firstFileName, secondFileName) {
    # grab the "base name", or the name of the file before "test", "train", etc
    fileBaseName <- strsplit(firstFileName, "_")[[1]][1];
    
    # read the respective files into R
    firstFile <- read.table(paste("test", firstFileName, sep="/"));
    secondFile <- read.table(paste("train", secondFileName, sep="/"));
    
    # bind them using rbind
    mergedFile <- rbind(firstFile, secondFile);
    
    # write them out to the file system
    mergedFileBaseName <- paste(fileBaseName, "merged.txt", sep="_");
    write.table(mergedFile, paste("merged", mergedFileBaseName, sep="/"));
}

# main script that processes the data
run_analysis <- function() {
    # step 1 - merge files
    ############################
    
    # grab files that need to be merged
    testFileNames <- list.files("test", pattern = "*.txt");
    trainFileNames <- list.files("train", pattern = "*.txt");
    
    # bind the file names into a table to be processed
    filePairs <- cbind(testFileNames, trainFileNames);
    
    dir.create("merged");        
    # merge each file pair and write them out to the console
    for (row in 1:nrow(filePairs)) {
        firstFile <- filePairs[row,][[1]];
        secondFile <- filePairs[row,][[2]];
        mergeTwoFiles(firstFile, secondFile);    
    }
    
    print("Merged!!");
    
    # step 2 - extract means and standard deviations
    ############################
    
    # read in the features from the feature file and extract the
    # columns indicating mean or standard deviation with a regex
    features <- read.table("features.txt")$V2;
    meanAndStdevRegEx <- "(-mean\\(\\))|(-std\\(\\))";
    meansAndStdevs <- as.logical(sapply(features, function(f) { grepl(meanAndStdevRegEx, f); }));
    
    # read in the merged data and subset it with the
    # logical vector indicating which columns are desired
    fileData <- read.table("merged/X_merged.txt");
    fileDataSubset <- fileData[, meansAndStdevs];
    
    print("Mean and standard deviation extracted!");
    
    # step 3 - Name activities meaningfully and merge them into the table
    ############################
    
    # create human-readable names for the activities based on the activity_labels file
    activity_labels <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying");
    
    # read in the activities and create a list with the numbered
    # activities translated into the human-readable activities
    unnamedActivities <- read.table("merged/y_merged.txt")[, 1];
    namedActivities <- sapply(unnamedActivities, function(x) { activity_labels[x] });
    
    # bind these human-readable activities to the existing data
    fileDataSubset <- cbind(namedActivities, fileDataSubset);

    print("Activities named!");

    # step 3a - Add subjects to table
    ############################
    
    # add the test subjects to the table, since they'll be useful later
    subjects <- read.table("merged/subject_merged.txt")[, 1];
    fileDataSubset <- cbind(subjects, fileDataSubset)
    
    # step 4 - Name columns meaningfully
    ############################
    
    # name columns with appropriate column names
    columnNames <- unlist(sapply(features[meansAndStdevs], function(x) {

        # split each string into components to remove special characters
        splitString <- sapply(strsplit(as.character(x), "-"), function(y) {
            firstLetter <- substring(y, 1, 1);
            tidiedString <- gsub("\\(\\)", "", substring(y, 2, nchar(y)));
            paste(toupper(firstLetter), tidiedString, sep="");
        });
        
        # paste the components together to make the column name human readable
        paste(splitString[,1], collapse="");
    }))
    
    # Name the columns of the dataset
    names(fileDataSubset) <- c("Subject", "Activity", columnNames);
    print ("Columns named!");

    # step 5 - Create tidy data using dplyr
    ############################
    
    # create a tbl_df from the data and group it by activity and subject
    dfTblFileDataSubset <- tbl_df(fileDataSubset);
    groupedData <- group_by(dfTblFileDataSubset, Activity, Subject);
    
    # summarize all columns by the groups by taking the average
    # of each column per activity/subject pair
    summarizedData <- summarise_each(groupedData, funs(mean));
    
    # write the tidy data to the file system!
    write.table(summarizedData, file="tidy_data.txt", row.names = FALSE);
    unlink("merged/", recursive = TRUE);
    print ("Tidy data generated in tidy_data.txt!");
}

run_analysis()