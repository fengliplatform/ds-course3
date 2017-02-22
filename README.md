# "Getting and Cleaning Data" Course Project

## Summary
The purpose of this course project is to collect, work with, and clean a data set and to prepare tidy data 
that can be used for later analysis. The dataset used 
for this project is called "Human Activity Recognition Using Smartphones Dataset". More
information about this data set can be found at UCI link:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Repo contents
This repository includes three files:
* CodeBook.md: Describes the variables, the data, and transformations or work performed to clean up the data 
* ReadMe.md: This file. High level description to the repo and files.
* run_analysis.R: R script to download raw data set, analysis data and produce required tidy data set.

## Getting start
1. Read CodeBook.md first to understand what script run_analysis.R does and all the varibles in the tidy data set.
2. Run script run_analysis.R
+ set working directory and source the script
`setwd("/patch/to/run_analysis.R")`
`source("run_analysis.R")`
+ This script will download data set in current directory, does analysis and generate required tidy data set called "meandata.txt".
+ Following command can be used to read meandata.txt.
`read.table("meandata.txt", sep=" ", header=TRUE)`
