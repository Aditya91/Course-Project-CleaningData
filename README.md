# Course-Project-CleaningData
This repository has the materials for the course project on "Getting and Cleaning Data"

The repository includes the following files:
=========================================

- 'README.md'

- 'Documents': **This folder has a sub-folder 'repo' which has the following two files**
- 'CodeBook.pdf': Shows information about the variables of the tidy dataset submitted (output) and the different operations performed on the raw datasets to obtain the tidy dataset

- 'run_analysis.R': The R script with the complete R code on how to transform the raw data to tidy dataset as specified by the problem requirements


Notes: 
======
- The R script has been coded as a function. The function does not need any input arguments
- The function has code which uses static directory references to read different files. Hence, prior to running the code, the directories should be relatively changed according to the target system
- Further, the code requires the Samsung Dataset to already be present in the working directory of R.
- The code to write to an external file the tidy dataset is embedded within the R code.
- The code additionally displays the tidy dataset on the console for a quick overview.
