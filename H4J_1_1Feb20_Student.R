## File: H4J_1_1_Feb20.R
## Course: Day 1, Morning Session
## Author: Kyla Bourne, kyla@hacking4justice.org
## Date: Feb 2 2020

####### Understanding the Building Blocks ########

# Before we open the actual data, we will practice some fundamental R skills

# To do this, we will build our own dataset to get you comfortable with:
# 1: Vectors, Matrices and Data Frames
# 2: Operators and Conditional Statements
# 3: Basic Data Frame Manipulation
# 5: Basic Tables and Plots


#### CLUES ####

# Imagine the following scenario:

# There was a incident at a mansion that lead to the death of Mr. Bobby
# After investigation, the CCSAO filed various charges on six defendants:

# Mr. Green (M, 45, White) is charged with murder (Class M) using a knife in the kitchen. 
# Miss Scarlet (F, 23, Latina) is charged with two counts of aggrevated battery, police officer (Class 3) for resisting arrest in the library.
# Colonel Mustard (M, 60, Black) is charged with the unlawful use of a weapon (Class 4) for carrying a revolver in the ballroom. 
# Mrs. Peacock (F, 35, Asian) is charged with the possession of a controlled susbtance (Class 4) for carrying poison in the lounge.
# Mrs. White (F, 78, Black) is charged with two counts of theft (Class 4) for two stolen candlesticks found in the dining room. 
# Prof. Plum (M, 39, White) is charged murder (Class M) using a lead pipe in the kitchen. He is Mr. Green's co-defendant.

# The following were the results of the charges:

# Mr. Green is found guilty of murder at trial and sentenced to life in prison. 
# Miss Scarlet pleaded guilty for three years probation on the first charge in exchange for the second charge being dropped "nolle prosequi"
# Colonel Mustard pleaded guilty and is given 2 years in prison.
# Mrs. Peacock pleaded guilty and is offered 2 years probation.
# Mrs. White dies soon after both charges are filed.
# Prof. Plum is found not guilty at trial. 


#### CREATE BASIC VECTORS, MATRICES AND DATA FRAMES ####

# Make three vectors for defendant name, age and gender
# Hint: use the syntax: vector <- c(); here, the <- assignment operator creates a object named 'vector' using c( ) or 'concatenate'
# c is for collect, combine

# Defendant Name, Race and Gender: Character





# Defendant Age: Interger





# create Defendant ID (note colon operator)




# But want to make sure to never forget that these represent labels, not quantities!
# so 'coerce' the numeric vector into a factor, or 'label' or bucket-type of data





# Create basic defendant matrix
# Hint: use the syntax: matrix <- matrix(data, nrow, ncol, byrow, dimnames)




# name rows, columns with a list
# Hint: use the syntax: list <- list(data)
# difference between list and vector? List can store different data types in one object!





# What is wrong with age in the matrix above?
# Hint: Remember what quotation marks mean!

# Solution: Create basic defendant data frame!





## EXERCISE: CREATE TWO ADDITIONAL DATA FRAMES ##

# Hint: Always remember the defendant-level row ID. It may need to duplicate if there are multiple charges!

# In this assignment, we care primarily about defendants, so they are the only category that needs an ID variable

# First, create a data frame that represents all the filed charges, cases and what we know about them

# Try nesting the c( ) within the rep( ) function to repeat







# Next, create a data frame that represents all the sentencing results

# HINT: you can re-use the ID variable for defendants from the charge table! 





#### OPERATORS and CONDITIONAL STATEMENTS ####

# R can be used as a calculator with familiar Arithmetic operators. Try it out! This is useful to avoid repeating complex formulas

# R also uses Relational operators to compare the relationship between two values. These are extremely useful.
# Notice the Boolean-type variables I created above for Trial and Plea. 
# vec.trial is true if the defendant had a trial on the charge, and false otherwise. 
# vec.plea is true if the defendant plead guilty on the charge, and false otherwise.
# Can you use Relational operators to determine which charges were resolved neither through a plea nor through a trial?

# Hint: Here assume trials and pleas are mutually exclusive i.e. they cannot both be true; use equal to (==) to compare the vectors
# Be careful to use two equals signs (one equal sign acts like the <- assignment operator)





# This shows that Miss Scarlet's second charge was nolled; and both Mrs. White's charges were abated after her death

# Other useful operators are: not equal to (!=), greater than (>), greater than or equal to (>=), less than (<), less than or equal to (<=)

# Use the Relational operators to test if any defendant is older than 65





# We find Mrs. White is the only defendant older the 65. Remember she is 78 years old.

# Finally, there are three Logical operators: AND (&), OR (|), NOT (!) 
# Learn how they work by comparing vec.trial and vec.plea like above





# The AND operator checks if both of the vectors are true. If they are, then it returns a TRUE.
# This test confirms that no charge can be resolved by both a trial and a guilty plea




# The OR operator checks if one of the vector values is TRUE, and if so, returns TRUE





# The not operator reverses the values


# Operators are most often used in Conditional Statements: IF, IF ELSE, ELSE (and CASE SWITCH)

# IF statement asks if a given condition is true. If the condition is true, then it excecutes a set of statements
# If the condition is not true, then it ignores the statements

# Syntax: if (expression)
	#{
	#	\\statement 1
	#}




# If you want to add additional conditions, use ELSE IF. If the first condition is false, the second condition will be checked in sequence

# Syntax: if (expression 1)
	#{
	#	\\statement 1
	#} else if (expression 2)
	#{
	#	\\statement 2
	#}




# But what if all the conditions are false? Then the ELSE condition can return a statement if no other conditions are met

# Syntax: if (expression 1)
	#{
	#	\\statement 1
	#} else if (expression 2)
	#{
	#	\\statement 2
	#} else
	#{
	#	\\statement 3
	#}





# To use a conditional statement with our vectors use the ifelse( ) function
# As above, The function tests a logical condition in its first argument. 
# If the test is TRUE, ifelse() returns the second argument. If the test is FALSE, ifelse() returns the third argument.

# Syntax: ifelse(expression, true statement, false statement)

# Use ifelse() with relational and logical operators 

## EXERCISE: Quickly check which of the defendants are white men ##




#### BASIC DATA FRAME MANIPULATION ####

# We made three separate data frames: one for defendants, one for charges, and one for sentencing results





# Each of the 6 rows in the defendant table represents a single person along with their attributes
# Each of the 8 rows in the charge/result tables represents a single charge

# We know only Ms. White is older than 65. How old is she exactly, though?

# Look at one defendant (one row) and their age (value in one column) in two ways

# Index using square brackets
# syntax: df[rnum, cnum]




# Using $ 
# syntax: df$colname



# Since the charge and result tables have equivalent rows, use the cbind( ) function to pair the charge with its ouctome

# syntax: newdf <- cbind(df1, df2)




# note that the ID variable has simply been duplicated because cbind( ) just appending columns
# the equivalent function for rows is rbind( )

# an easy way to subset data by column or row is to select by their sequntial position

#syntax: newdf <- olddf[c(position numbers)]




# excludes duplicate ID variable using indexing



# the equivalent to include non-duplicate variables would be:
# df.charres <- df.charres[c(1:7, 9:13)]
# be careful with this method, as the sequential positions change when you make deletions


# To combine the new charge/result table with the defendant table, we must use the merge( ) function, why?

# Syntax: merge(df1, df2, by = "colname")




# We included a common ID label throughout. This will help you merge the separate dataframes together

# Checking for missing values in columes
# Use is.na( ) function




# Creating new variable column that combines the strings Term and Type with the paste( ) function

#Sytax: df$newvar <- value; paste(df$var1, df$var2)




## EXERCISE: How to make "NA NA" be an <NA> value? ##

# Hint: Use logical operators, is.na() and ifelse() functions

#put sentence term and sentence type together in a new character vector



#final created dataset


#### TABLES AND PLOTS ####

# Play with the plot( ) and table( ) functions to see what you can learn from the data!

# Try these examples and explain what they are showing you





# After lunch we'll use these tools on a real CCSAO dataset!

