# Data Frames are data displayed in a format as a table.
# Data Frames can have different types of data inside it. 
#While the first column can be character, the second and third can be numeric or logical. 
# However, each column should have the same type of data.
# we use the data.frame() function to create a data frame

df <- data.frame(
  Name = c("Jane", "John", "Doe", "Philip", "Beau", "Francis", "Cole"),
  Age = c(12, 13, 14, 20, 12, 16, 18),
  Department = c("Marketing", "Informatics", "Data Analysis", "Sales", "Data Analysis", "Informatics", "Sales")
)

df # prints out our dataframe

View(df) # Opens our dataframe like a spreadsheet viewer

head(df) # checks the first 6 rows of our dataframe

tail(df) # checks the last 6 rows of our dataframe

summary(df) # gives a quick summary of the dataframe

# We can access the column in a dataframe using df[[column name]] or df$columnname

df[["Age"]]

df$Age

# We can add more rows to the dataframe
df <- rbind(df, c("Tolu", 14, "Sales", 4))
df

# we can add a column
df$Id <- c(01,02, 03, 04, 05, 06,07) 
df

# Another way to ass column is to use cbind()
df <- cbind(df, "Year of birth" = c(2010, 2000, 2001, 2002, 2015, 2014, 2020, 2013))
df

# to remove columns 

df[-8,] # this removes the 8th row

df[-c(2,4), ] # this removes the 2nd and 4th row

# we can remove column by index
df[, -1] # removes the first column

df[, -c(3,6)] # removes the third and sixth column

# to check the amount of rows and columns, we use dim
dim(df) 

ncol(df) # gives you the number of columns in a dataframe

nrow(df) # gives you the number of rows in a dataframe

colnames(df) # gets column names

rownames(df) # get row names


# you can also combine dataframes row wise using rbind()
Data_Frame1 <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame2 <- data.frame (
  Training = c("Stamina", "Stamina", "Strength"),
  Pulse = c(140, 150, 160),
  Duration = c(30, 30, 20)
)

New_Data_Frame <- rbind(Data_Frame1, Data_Frame2)
New_Data_Frame

# you can use the cbind() function to combine two or more data frames in R horizontally
Data_Frame3 <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame4 <- data.frame (
  Steps = c(3000, 6000, 2000),
  Calories = c(300, 400, 300)
)

New_Data_Frame1 <- cbind(Data_Frame3, Data_Frame4)
New_Data_Frame1