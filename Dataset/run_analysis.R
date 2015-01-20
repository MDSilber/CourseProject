# Step 1

mergeDataSets <- function() {
    testFileNames <- list.files("test", pattern = "*.txt");
    trainFileNames <- list.files("train", pattern = "*.txt");
    
    filePairs <- cbind(testFileNames, trainFileNames);
    
    dir.create("merged");

    for (row in 1:nrow(filePairs)) {
        firstFile <- filePairs[row,][[1]];
        secondFile <- filePairs[row,][[2]];
        mergeTwoFiles(firstFile, secondFile);    
    }
    
    print("Merged!!");
}

mergeTwoFiles <- function(firstFileName, secondFileName) {
    fileBaseName <- strsplit(firstFileName, "_")[[1]][1];
    print(firstFileName);
    print(secondFileName);
    
    firstFile <- read.table(paste("test", firstFileName, sep="/"));
    secondFile <- read.table(paste("train", secondFileName, sep="/"));
    
    mergedFile <- rbind(firstFile, secondFile);
    
    mergedFileBaseName <- paste(fileBaseName, "merged.txt", sep="_");
    write.table(mergedFile, paste("merged", mergedFileBaseName, sep="/"));
}

# Step 2

extractMeansAndStandardDeviations <- function(filePath) {
    features <- read.table("./features.txt")$V2;
    meanAndStdevRegEx <- "(-mean\\(\\))|(-std\\(\\))";
    meansAndStdevs <- as.logical(sapply(features, function(f) { grepl(meanAndStdevRegEx, f); }));
    
    fileData <- read.table(filePath);
    fileDataSubset <- fileData[, meansAndStdevs];
    fileDataSubset;
}

# Step 3

nameActivities <- function() {
    
}

# Step 4

labelDataSet <- function() {
    
}

# Step 5

createTidyDataSet <- function() {
    
}