# Nashville Housing Data Cleaning

## Project Overview

The Nashville Housing Data Cleaning Project is a hands-on data cleaning exercise using real-world housing data from Nashville, Tennessee.

Through this project, I aim to enhance my SQL skills by identifying and addressing common data quality issues such as inconsistent formatting, missing values, and duplicated records. This project will serve as a foundation for building reliable and clean datasets that are ready for further analysis or dashboard creation.

Dataset: [Nashville Housing Data](https://www.kaggle.com/datasets/tmthyjames/nashville-housing-data)

Skills: MySQL

## Initial Data Exploration

What columns are present?

What types of data?

Nulls, duplicates, strange values?

## Cleaning Steps

- Standardize Date Format
- Filled missing `PropertyAddress`   
- Split `PropertyAddress` into street & city   
- Split OwnerAddress into Street, City, State   
- Cleaned inconsistent values in `SoldAsVacant`  
- Removed duplicate entries  
- Dropped unnecessary columns


## Learnings

Things I have learned

- Using Microsoft SQL Server Management Studio 20
- Importing CSV files to .SQL
- Changing Data types while Importing
- Using `PARSENAME()`
- Using CTE

What I found tricky

- Converting CSV files to .SQL
