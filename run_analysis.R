library(dplyr)

mergeTwoFiles <- function(firstFileName, secondFileName) {
    fileBaseName <- strsplit(firstFileName, "_")[[1]][1];
    
    firstFile <- read.table(paste("test", firstFileName, sep="/"));
    secondFile <- read.table(paste("train", secondFileName, sep="/"));
    
    mergedFile <- rbind(firstFile, secondFile);
    
    mergedFileBaseName <- paste(fileBaseName, "merged.txt", sep="_");
    write.table(mergedFile, paste("merged", mergedFileBaseName, sep="/"));
}

run_analysis <- function() {
    # step 1 - merge files
    testFileNames <- list.files("test", pattern = "*.txt");
    trainFileNames <- list.files("train", pattern = "*.txt");
    
    filePairs <- cbind(testFileNames, trainFileNames);
    
    if (!file.exists("merged")) {
        dir.create("merged");
        for (row in 1:nrow(filePairs)) {
            firstFile <- filePairs[row,][[1]];
            secondFile <- filePairs[row,][[2]];
            mergeTwoFiles(firstFile, secondFile);    
        }
    }
    
    print("Merged!!");
    
    # step 2 - extract means and standard deviations
    features <- read.table("features.txt")$V2;
    meanAndStdevRegEx <- "(-mean\\(\\))|(-std\\(\\))";
    meansAndStdevs <- as.logical(sapply(features, function(f) { grepl(meanAndStdevRegEx, f); }));
    
    fileData <- read.table("merged/X_merged.txt");
    fileDataSubset <- fileData[, meansAndStdevs];
    
    print("Mean and standard deviation extracted!");
    
    # step 3 - Name activities meaningfully and merge them into the table
    
    activity_labels <- c("Laying", "Sitting", "Standing", "Walking", "Walking Downstairs", "Walking Upstairs");
    unnamedActivities <- read.table("merged/y_merged.txt")[, 1];
    namedActivities <- sapply(unnamedActivities, function(x) { activity_labels[x] });
    fileDataSubset <- cbind(namedActivities, fileDataSubset);

    print("Activities named!");

    # step 3a - Add subjects to table
    subjects <- read.table("merged/subject_merged.txt")[, 1];
    fileDataSubset <- cbind(subjects, fileDataSubset)
    
    # step 4 - Name columns meaningfully
    
    columnNames <- unlist(sapply(features[meansAndStdevs], function(x) {
        splitString <- sapply(strsplit(as.character(x), "-"), function(y) {
            firstLetter <- substring(y, 1, 1);
            tidiedString <- gsub("\\(\\)", "", substring(y, 2, nchar(y)));
            paste(toupper(firstLetter), tidiedString, sep="");
        });
        
        paste(splitString[,1], collapse="");
    }))
    
    names(fileDataSubset) <- c("Subject", "Activity", columnNames);
    print ("Columns named!");

    # step 5 - Create tidy data using dplyr
    dfTblFileDataSubset <- tbl_df(fileDataSubset);
    groupedData <- group_by(dfTblFileDataSubset, Activity, Subject);
    summarizedData <- summarise_each(groupedData, funs(mean));
    
    write.table(summarizedData, file="tidy_data.txt", row.names = FALSE);
    print ("Tidy data generated in tidy_data.txt!");
}

run_analysis()