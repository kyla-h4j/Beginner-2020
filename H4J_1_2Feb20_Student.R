## File: H4J_1_1_Feb20.R
## Course: Day 1, Afternoon Session
## Author: Kyla Bourne, kyla@hacking4justice.org
## Date: Feb 2 2020

####### Exploring CCSAO Sentencing Dataset ########

# Now we'll apply the skills from the morning with real data!

# In this session, you'll learn about:
# 1: R Packages and CRAN
# 2: Importing existing datasets
# 3: Wrangling a complex dataset 
# 4: Dig deeper and get curious!

#### PACKAGES ####

# R Packages are pre-writte code that adds new functions 

# R Packages can be either included with R already (base) or are created by third-parties

# Base packages are already installed and just need to be loaded from your library
# To do this, use the library( ) function

# Load the 'foreign' package in order to load the CCSAO data




# Third-party packages need to be downloaded from CRAN and installed to your hard-drive first
# For these, begin with install.packages( ) function, then use library( )
# CRAN stands for the "Comprehensive R Archive Network" 
# www.cran.r-project.org (Packages, Task View)

# Let's try to installing the 'psych' package



# To learn more about any package with documentation, vignettes and fuctions, type ?'package'





# NOTE: You can always also google the package documentation or vignettes!

# In foreign, we're about to use the 'read.csv' function. Have a look at what it does




# HINT: Unless you are updating the package version, you don't need to reinstall to your hard-drive
# But in each new session, you will need to re-load packages to make them available to your current routines

# HINT 1: To manage the CCSAO data frames, you might explore the 'data.table' or 'dplyr' packages
# To create beautiful graphics, you can use 'ggplot2'

#### IMPORT CCSAO DATA ####

# check your working directory

# to set or change your working directory use for example setwd("~/Desktop/R Class/R")

# HINT: Be sure the CCSAO data is saved in your working directory!

# .csv ia a 'comma separated value' file and is a common way of storing and opening spreadsheet-style data
# versus, e.g. .xlsx files which are tied to the Excel program, so less flexible

# using the foreign package, use the read.csv() function 
# Can you find the syntax from the ?read.csv command, above?


 # What does 'header = TRUE' do?

# if it worked, a new dataframe will appear in your environment after several seconds



#### DATASET WRANGLING ####

# After uploading the CCSAO data, try the following summary functions


 # set col names to lower to avoid typos

 # first 6 rows
#first 16 rows
 # last 6 rows

 #an overall glimpse of the variables


## EXERCISE: FIRST STEPS ##

# 1) What does each row represent? Here, think back to your CLUE dataframe.

# 2) What does each column represent? What type of data is each column (e.g. factor, interger, numeric, logical)?

# 3) Are there columns we are certain to not need? We will drop some to make things clearer.  

# HINT: ALWAYS keep ID columns

# keep all rows with blank space, delete columns after comma


# 4) Split df.sent table into two new data frames: defendant and sentence result (reverse of CLUE task)

# HINT: This will make row counts more intuitive. Why? Be sure to keep case_participant_id: why?



# the subset( ) function allows for row selection conditional on a column value
# syntax: newdf <- subset(olddf, selection condition)

# What values of 'charge_disposition' make sense to subset the sentencing dataframe?

 #levels( ) lists the possible values of a given column



 # note how useful operators are here


 #check to see the subset is accurate

 #droplevels( ) gets rid over empty values above


#make a quick guilty plea logical variable


 # 89 percent total guilty dispos from plea

#then subset columns relevant to sentencing





# 5) Why are there 34943 duplicated rows in the defendant subset data frame?

 # the duplicated() function checks if rows in the dataframe are duplicated 
# removes duplicated rows


#### DIG DEEPER ####

## EXERCISE: EXPLORE THE DATA ##

# 1) What are the possible values for each column variable? How common or rare are these values?

# HINT: Use the levels( ) and table( ) functions on both sub.def and sub.sent


#Problem: 'offense_title' takes more than one thousand values! Solution: count dataframe




# sort charges into descending frequency



# plot top 5 most common charges


# barplot is useful for categorical variables like charge.
# Note here how to add labels!



# 2) Can you identify problematic data values (e.g. rare, missing, or nonsensical) using familiar functions?

# you might need to coercie the column into a different type, remove or change values, or make matrices, etc, to help

# e.g. age


# histogram reveals nonsensical values here


# replace over 86 ages with NA

# 3059 NA values in this column
 # this histogram makes more sense



# 3) Use describe( ) and describeBy( ) to explore descriptive statistics and interesting relationships between variables

# e.g. look at prison length by plea/trial

 # subset to prison sentences measured in years

# time is a factor

# check what these labels are: a mess from inconsistent data input. 

# to really fix this, you would have to use string manipulation, for now lets just do a rough conversion to get the idea

# Try skipping this step and turning the factor directly into numeric

# make illogical numbers NA

# 333 NA values

# now the prison term can be described using basic measures of central tendency (mean, median) and variability (min, max, standard deviation) 





# it can be informative to group these measures according to a variable of interest e.g. whether the defendant pleaded guilty using describeBy( )

# syntax: describeBy(quant variable, grouping variable)

# HINT: Practice for tomorrow's discussion of theory and hypothesis building. 

# Do you expect prison length to be on average LONGER or SHORTER for defendants who plead guilty? Why?



# What do we find? What are the limits of this technique?





