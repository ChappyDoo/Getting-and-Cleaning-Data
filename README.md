# Course Project for Getting and Cleaning Data on Coursera

This is Repository is for the the course project for the Getting and Cleaning Data Coursera course from Johns Hopkins University.

The R script, run_analysis.R, performs the following actions:

1. It downloads the dataset for the course, first checking to see if it already
exist in the working directory and then unpacking it from the .zip file.
2. It loads the activity and feature info first, and then extracts only those
values with means and standard deviations.
3. It loads both the training and test datasets and keeps only the columns
which contain a mean or standard deviation.
4. It loads the activity and subject data for each dataset and then merges
those columns with the previous (#3) dataset. (i.e. training means with training
activity and subjects)
5. It then merges the two datasets. (training and test)
6. It then makes the activity and subject columns into factors and casts a new
tidy dataset with the averages of each variable for the subject and activities.
7. It then creates a text file tidy.txt fo the clean dataset.

This dataset has been obtained from the following publications as per its readme:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L.
Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass
Hardware-Friendly Support Vector Machine. International Workshop of Ambient
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012