# Getting and Cleaning Data : Project

## Introduction

This repository contains the results of the Getting and Cleaning Data course project. The goal of this project is to prepare and generate a Tidy Data Set from a collection of different data files.

## Data

Raw data files are from the project "Human Activity Recognition Using Smartphone". These files have information from the accelerometers from Samsung Galaxy S smartphone.

## Script file

The run_analysis.R script file reads the training and test data files, merges them to a temporary data frame and labels data according to a more meaningful description. The feature file is used to filter out columns that contain the words mean or std. The final outcome is a text file grouped by "Subject ID" and "Activity" with the mean value of each column. 

Note: The script file searches for data under ./UCIData/