Getting and Cleaning Data Course Project
========================================

The script run\_analysis.R is designed to take two data sets from the same
experiment, merge them, run some analysis, and tidy the data before writing it
out to the file system. The script is split up into five sections, each of which
will be discussed below.

Step 1: Merging the data
------------------------

The first step is to take two directories, test/ and train/, and merge their
data into a single data set. In order to do that, we first read in all the file
names from the test/ and train/ directories. Then we send those file paths into
a function called mergeTwoFiles that takes two file paths, reads in the files,
merges them out, and writes them out to the file system. Once that piece of the
script completes, we're finished with step 1.

Step 2: Extracting the means and standard deviations
----------------------------------------------------

In this step, we intend to throw away all columns from the merged data aside
from those indicating some sort of mean or standard deviation measurement. In
order to do that, we read in the column names from the features.txt file, and
then use a regular expression to extract only column names that contain the
character group "mean" or "std", the indicators of mean and standard deviation
that the dataset uses. We create a logical vector based on that regular
expression, then subset the merged data by passing that logical vector into the
columns argument of the subsetting operation. We're left with only the columns
representing means or standard deviations from the merged data set.

Step 3: Naming the activities
-----------------------------

In this step, we name the activities meaningfully, and merge them into the
dataset. In order to do this, we create a character vector of human readable
activities based on the activity\_labels.txt file. Then we read in the file
indicating the activities, and create a table where the numbered activities have
been made human-readable by translating via the character vector we created. We
then bind this column to the data.

Step 3a: Adding the subjects to the data
----------------------------------------

Since the subjects are in a separate file from the measurements taken, for
convenience we add the subjects to the table by reading in the subjects file,
then binding the subjects to the data as a separate column.

Step 4: Naming the columns
--------------------------

In this step, we must name the columns meaningfully. In order to do that, we
take the column names we found in step 2 and use string manipulation to remove
any special characters from them and to make them more human readable. Once
we've done that, we assign the column names to the data directly.

Step 5: Creating tidy data from this modified data set
------------------------------------------------------

In the last step, we utilize the dplyr library, which makes summarizing data
very easy in R. First we convert our data.frame into a tbl\_df object. Then,
using the group\_by function, we add groups based on activity and subject to
the data. From there, we can summarize the data based on these groups by taking
the average of each measurement, and then write them out to the file system.

Conclusion
----------

Once these steps have been performed, we have a file called tidy\_data.txt in
our directory which has our summarized, cleaned data!
