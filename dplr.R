# handling missing values or NA

df <- data.frame(
  Name = c("John", "Jane", NA, "Joe"),
  Age = c(12, 34, 12, NA),
  BMI = c(33.0, 24.5, 19.0, 26.0)
)

df

# to check for missing value
is.na(df) # this returns a logical

# to check if there is any missing value, we use any

any(is.na(df)) # if there are missing values, you get true, if there aren't, you get false

# we can count the total number of missing values in the entire dataframe
sum(is.na(df))

# to count the number of missing value in a column, we use
sum(is.na(df$Name))



colSums(is.na(df))


# rows with NA can be removed
na.omit(df)

# remove row where Name is NA
df[!is.na(df$Name),]


df[!is.na(df$Name),] <- "Monica"
df
any(is.na(df))
df
