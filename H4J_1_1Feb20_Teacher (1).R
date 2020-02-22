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

vec.name <- c("Green","Scarlet","Mustard","Peacock","White","Plum")
class(vec.name)      
vec.name

vec.gender <- c("Male","Female","Male","Female","Female","Male")
class(vec.gender)
vec.gender

vec.race <- c("White","Latinx","Black","Asian","Black","White")
class(vec.race)
vec.race

# Defendant Age: Interger

vec.age <- c(45,23,60,35,78,39)
class(vec.age)
vec.age

# create Defendant ID (note colon operator)

vec.id <- c(1:6)
class(vec.id)

# But want to make sure to never forget that these represent labels, not quantities!
# so 'coerce' the numeric vector into a factor, or 'label' or bucket-type of data
vec.id <- factor(vec.id)
class(vec.id)

# Create basic defendant matrix
# Hint: use the syntax: matrix <- matrix(data, nrow, ncol, byrow, dimnames)

mat.def <- matrix(c(vec.id, vec.name, vec.age, vec.gender, vec.race), 6, 5, byrow = FALSE)
mat.def

# name rows, columns with a list
# Hint: use the syntax: list <- list(data)
# difference between list and vector? List can store different data types in one object!

vec.row <- c(1:6)

vec.col <- c("ID","Name","Age","Gender","Race")

list.dim <- list(vec.row, vec.col)

mat.def <- matrix(c(vec.id,vec.name, vec.age, vec.gender, vec.race), 6, 5, byrow = FALSE, dimnames = list.dim)
mat.def

# What is wrong with age in the matrix above?
# Hint: Remember what quotation marks mean!

# Solution: Create basic defendant data frame!

df.defendant <- data.frame(vec.id, vec.name, vec.age, vec.gender, vec.race)
df.defendant

colnames(df.defendant) <- vec.col
df.defendant


## EXERCISE: CREATE TWO ADDITIONAL DATA FRAMES ##

# Hint: Always remember the defendant-level row ID. It may need to duplicate if there are multiple charges!

# In this assignment, we care primarily about defendants, so they are the only category that needs an ID variable

# First, create a data frame that represents all the filed charges, cases and what we know about them

# Try nesting the c( ) within the rep( ) function to repeat

vec.charge <- c("Murder", rep(c("Agg Batt PO"),2), "UUW","PCS", rep(c("Theft"),2),"Murder")

vec.class <- c("M", rep(c("3"),2), rep(c("4"), 4),"M")

vec.case <- c("C1", rep(c("C2"),2),"C3","C4",rep(c("C5"),2),"C1")

vec.count <- c(rep(1,2),2,rep(1,3),2,1)

vec.evi <- c("Knife",NA, NA,"Revolver","Poison", rep(c("Candlestick"), 2), "Lead Pipe")

vec.location <- c("Kitchen",rep(c("Library"),2),"Ballroom","Lounge",rep(c("Dining Room"),2),"Kitchen")

vec.id2 <- c(1, rep(2,2), 3:4, rep(5, 2), 6)


df.charge <- data.frame(vec.id2, vec.case, vec.charge, vec.count, vec.class, vec.evi, vec.location)

colnames(df.charge) <- c("ID","Case","Charge","Count","Class","Evidence","Location")

df.charge

# Next, create a data frame that represents all the sentencing results

vec.result <- c(rep(c("Guilty"),2),"Nolle",rep(c("Guilty"),2),rep(c("Cause Abated"),2),"Not Guilty")

vec.trial <- c(TRUE,rep(FALSE,6),TRUE)

vec.plea <- c(FALSE,TRUE,FALSE,TRUE,TRUE,FALSE,rep(FALSE,2))

vec.sentterm <- c("Life", "3 Years", NA, rep(c("2 Years"),2), NA, NA, NA )

vec.senttype <- c("Prison","Probation",NA,"Prison","Probation",NA,NA,NA)

# HINT: you can re-use the ID variable for defendants from the charge table! 

df.result <- data.frame(vec.id2, vec.result, vec.trial, vec.plea, vec.sentterm, vec.senttype)

colnames(df.result) <- c("ID","Result","Trial","Plea","Term","Type")

df.result

#### OPERATORS and CONDITIONAL STATEMENTS ####

# Broadly four types of operators:
# Arithmetic
# Relational
# Logical
# Assignment

# R can be used as a calculator with familiar Arithmetic operators. Try it out! This is useful to avoid repeating complex formulas

# R also uses Relational operators to compare the relationship between two values. These are extremely useful.
# Notice the Boolean-type variables I created above for Trial and Plea. 
# vec.trial is true if the defendant had a trial on the charge, and false otherwise. 
# vec.plea is true if the defendant plead guilty on the charge, and false otherwise.
# Can you use Relational operators to determine which charges were resolved neither through a plea nor through a trial?

# Hint: Here assume trials and pleas are mutually exclusive i.e. they cannot both be true; use equal to (==) to compare the vectors
# Be careful to use two equals signs (one equal sign acts like the <- assignment operator)

vec.trial == vec.plea

# This shows that Miss Scarlet's second charge was nolled; and both Mrs. White's charges were abated after her death

# Other useful operators are: not equal to (!=), greater than (>), greater than or equal to (>=), less than (<), less than or equal to (<=)

# Use the Relational operators to test if any defendant is older than 65

vec.age > 65

# We find Mrs. White is the only defendant older the 65. Remember she is 78 years old.

# Finally, there are three Logical operators: AND (&), OR (|), NOT (!) 
# Learn how they work by comparing vec.trial and vec.plea like above

vec.trial & vec.plea

# The AND operator checks if both of the vectors are true. If they are, then it returns a TRUE.
# This test confirms that no charge can be resolved by both a trial and a guilty plea

vec.trial | vec.plea 

# The OR operator checks if one of the vector values is TRUE, and if so, returns TRUE

!vec.trial

# The not operator reverses the values


# Operators are most often used in Conditional Statements: IF, IF ELSE, ELSE (and CASE SWITCH)

# IF statement asks if a given condition is true. If the condition is true, then it excecutes a set of statements
# If the condition is not true, then it ignores the statements

# Syntax: if (expression) {
	#	\\statement 1
	#}

if (5==5) {
  print("Five equals five")
}

# EXTRA: R Style Guide: http://adv-r.had.co.nz/Style.html

# If you want to add additional conditions, use ELSE IF. If the first condition is false, the second condition will be checked in sequence

# Syntax: if (expression 1) {
	#	\\statement 1
	#} else if (expression 2) {
	#	\\statement 2
	#}

if (5>6) {
  print("Five is greater than six")
} else if (5==5) {
	print("Five equals five")
}


# But what if all the conditions are false? Then the ELSE condition can return a statement if no other conditions are met

# Syntax: if (expression 1) {
	#	\\statement 1
	#} else if (expression 2)
	#{
	#	\\statement 2
	#} else
	#{
	#	\\statement 3
	#}


 if (5>6) {
	print("Five is greater than six")
} else if (6>7) {
	print("Six is greater than seven")
} else {
	print("Five equals five")
}


# To use a conditional statement with our vectors use the ifelse( ) function
# As above, The function tests a logical condition in its first argument. 
# If the test is TRUE, ifelse() returns the second argument. If the test is FALSE, ifelse() returns the third argument.

# Syntax: ifelse(expression, true statement, false statement)

# Use ifelse() with relational and logical operators 

## EXERCISE: Quickly check which of the defendants are white men ##

ifelse(vec.race=="White" & vec.gender=="Male", "White Man", "Not White Man")


#### BASIC DATA FRAME MANIPULATION ####

# We made three separate data frames: one for defendants, one for charges, and one for sentencing results

df.defendant
df.charge
df.result

# Each of the 6 rows in the defendant table represents a single person along with their attributes
# Each of the 8 rows in the charge/result tables represents a single charge

# We know only Ms. White is older than 65. How old is she exactly, though?

# Look at one defendant (one row) and their age (value in one column) in two ways

# Index using square brackets
# syntax: df[rnum, cnum]

df.defendant[5,3]

# Using $ 
# syntax: df$colname

df.defendant$Age

# Since the charge and result tables have equivalent rows, use the cbind( ) function to pair the charge with its ouctome

# syntax: newdf <- cbind(df1, df2)

df.charres <- cbind(df.charge, df.result)
df.charres

# note that the ID variable has simply been duplicated because cbind( ) just appending columns
# the equivalent function for rows is rbind( )

# an easy way to subset data by column or row is to select by their sequntial position

#syntax: newdf <- olddf[c(position numbers)]

names(df.charres)

# excludes duplicate ID variable using indexing
df.charres <- df.charres[,-8]
# Or using the NULL command
# df.charres[,8] <- NULL
df.charres

# the equivalent to include non-duplicate variables would be:
# df.charres <- df.charres[c(1:7, 9:13)]
# be careful with this method, as the sequential positions change when you make deletions


# To combine the new charge/result table with the defendant table, we must use the merge( ) function, why?

# Syntax: merge(df1, df2, by = "colname")

df.clue <- merge(df.defendant, df.charres, by = "ID")

# We included a common ID label throughout. This will help you merge the separate dataframes together

# TIME PERMITTING
# This was an example of an inner join. There are three other common joins - left, right and outer
# Syntax for left join: merge(df1, df2, by = "colname", all.x = T)
# Syntax for right join: merge(df1, df2, by = "colname", all.y = T)
# Syntax for outer join: merge(df1, df2, by = "colname", all.x = T, all.y = T)

# Example
# Create subsets of the dataframes with different subgroups of IDs
df.def <- df.defendant[1:4,]
df.def

df.cha <- df.charres[4:8,]
df.cha

## Exercise : Try the different joins and explain what you see
# Inner join
df.def.cha1 <- merge(df.def, df.cha, by = "ID")

# Left join
df.def.cha2 <- merge(df.def, df.cha, by = "ID", all.x = T)

# Right join
df.def.cha3 <- merge(df.def, df.cha, by = "ID", all.y = T)

# Outer join
df.def.cha4 <- merge(df.def, df.cha, by = "ID", all.x = T, all.y = T)

# Checking for missing values in columes
# Use is.na( ) function

is.na(df.clue$Type)


# Creating new variable column that combines the strings Term and Type with the paste( ) function

#Sytax: df$newvar <- paste(df$var1, df$var2)

df.clue$Sentence <- paste(df.clue$Term, df.clue$Type)

# This adds a space between the two values being concatenated. Use the paste0 function if you don't want a space in the middle.
#Syntax: df$newvar <- paste0(df$var1, df$var2)

# You can also add your own separator
# Syntax: df$newvar <- paste(df$var1, df$var2, sep = ",")

## EXERCISE: How to make "NA NA" be an <NA> value? ##

# Hint: Use logical operators, is.na() and ifelse() functions

#put sentence term and sentence type together in a new character vector
df.clue$Sentence <- ifelse(is.na(df.clue$Term) & is.na(df.clue$Type), NA, paste(df.clue$Term, df.clue$Type))

# OR
df.clue$Sentence <- ifelse(df.Sentence == "NA NA", NA, df$Sentence)

#final created dataset
df.clue

#### TABLES AND PLOTS ####

# Play with the plot( ) and table( ) functions to see what you can learn from the data!

# Try these examples and explain what they are showing you

table(df.clue$Name)

table(df.clue$Name, df.clue$Sentence)

table(df.clue$Evidence, df.clue$Location)

plot(df.clue$Gender)

plot(df.clue$Age)

plot(df.clue$Gender, df.clue$Age)

# After lunch we'll use these tools on a real CCSAO dataset!

