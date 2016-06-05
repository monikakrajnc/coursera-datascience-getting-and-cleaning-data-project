# Getting and cleaning data - Project 

The script in the repo binds data tables, creates a subset, renames variables, calculates averages and save the output.

The dataset for this project can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. It contains data labels, descriptions, test and trains data sets, seperated into folders and across multiple files.

The R-Script run_analysis.R loads and binds the Test and Train data together. Then creates a subset of the "mean" and "std" variables, and renames them to be more descriptive. In the end it calculates averages of each variable for each activity and subject and saves them to a txt file.

The script requires the path to the dataset - your work directory - in order to run. For example run_anaylsis("../data/UCI HAR Dataset")

This repo also contains an example of what the cleaned and processed data should look like, called tidy_data.txt
