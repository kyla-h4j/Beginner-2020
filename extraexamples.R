###we need some new packages for this

library(lubridate) #analyzing dates
library(dplyr) #manipulating data

df.sent <- read.csv("Sentencing.csv", header = TRUE)
names(df.sent) <- tolower(names(df.sent)) # set col names to lower to avoid typos

###Example 1###

#How has the average age of those charged with UUW - Unlawful Use of Weapon changed over time?

#add incident years
df.sent$incident_date <- mdy_hms(df.sent$incident_begin_date)
df.sent$incident_year <- year(df.sent$incident_date)

#keep UUW - Unlawful Use of Weapon only
df.uuw.only <- df.sent[df.sent$updated_offense_category == "UUW - Unlawful Use of Weapon",]

#What years do we have sufficient data?
with(df.uuw.only, aggregate(age_at_incident, list(incident_year), length))

#look only at 2011 to 2019
df.uuw.only <- df.uuw.only[(df.uuw.only$incident_year > 2010) & (df.uuw.only$incident_year < 2020) & (!is.na(df.uuw.only$incident_year)),]

#remove missing ages
df.uuw.only <- df.uuw.only[!is.na(df.uuw.only$age_at_incident),]

result <- with(df.uuw.only, aggregate(age_at_incident, list(incident_year), mean))

plot(result[,1], result[,2], type="l", main="Average Age of those charged with Unlawful Use of Weapon", xlab="Year", ylab="Average Age (Years)")


###Example 2###

#Making a plot of average sentence length over time!

sub.def <- df.sent[ , c("case_participant_id", "sentence_type", "commitment_type", "commitment_term", "commitment_unit", "sentence_date")]

#keep only prison sentences
df <- sub.def[sub.def$sentence_type == "Prison",]
df <- df[!duplicated(df),] #removes duplicated rows

#convert sentence units to days
df$sentence_unit <- case_when(
  df$commitment_unit == "Year(s)" ~ 365, #365 days in a year
  df$commitment_unit == "Months" ~ 30, #30 days in a month
  df$commitment_unit == "Days" ~ 1, #1 day in a day
  TRUE ~ 0 #ignore other units
)

#convert sentence date to years
df$sentence_date <- mdy_hms(df$sentence_date)
df$sentence_year <- year(df$sentence_date)

#calculate sentence length
df$sentence_length <- as.numeric(as.character(df$commitment_term)) * df$sentence_unit

#how does this look?
hist(df$sentence_length)

#filter out extremely long sentence and sentences we did not calculate
df <- df[(df$sentence_length > 0) & (df$sentence_length < 100 * 365) & (!is.na(df$sentence_length)),]

#how does this look?
hist(df$sentence_length)

#look only at 2011-2019
df <- df[(df$sentence_year > 2010) & (df$sentence_year < 2020),]

#get average sentence length by year
result2 <- with(df, aggregate(sentence_length, list(sentence_year), mean))
plot(result2[,1], result2[,2]/365, type="l", main="Average Sentence Length", xlab="Year", ylab="Sentence Length (Years)")



