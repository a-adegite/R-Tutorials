library(tidyverse)
df <- mtcars
head(df)

# select() allows you to Select specific columns of a data frame
# Multiple packages in R can have functions of the same name, which causes confusion.
# In that case, we have to specify the package that a function in from. 
# For example, instead of using select(), we would use dplyr::select() 
# this tells R that we are using the select() from dplyr and not from any other package.

# to use it we say dplyr::select(dataframe,colname1, colname2, colname3)
sub_df <- dplyr::select(df, mpg, cyl, gear)
sub_df


# you could go ahead and load just dplyr and use the select() without referencing the package name
# this is possible since you just loaded dplyr and not tidyverse
library(dplyr)
select(df, gear, cyl, mpg)

# we can select columns that contains a particular character
select(df, disp, contains("c")) # would select any column that contains c

select(df, contains("ca")) # would select any column that contains ca


# we can use filter()
# filter select specific rows of a data frame based on conditions
# to use, you do filter(df, condition)
filtered <- dplyr::filter(df, mpg >30)
head(filtered)


# we can add new columns by using mutate()
# mutate() add new columns by modifying existing ones
# to use we do mutate(df, new_column_name = modifications)
df <- dplyr::mutate(df, kpl=mpg * 0.425144)
head(df)

# we can add new columns by using transmute()
# transmute() adds new columns by modifying existing ones
# but only returns the new (or explicitly selected) columns
# to use we do transmute(df, new_column_name = modifications)
dplyr::transmute(df, kpl = mpg * 0.425144)


# The function summarize() calculates summary statistics and returns a new, smaller data frame.
summary <- summarise(
  df,                            # The data frame you want to summarize
  mean_mpg = mean(mpg),          # Creates a new column 'mean_mpg' containing the mean of the 'mpg' column
  min_mpg  = min(mpg)            # Creates a new column 'min_mpg' containing the minimum of the 'mpg' column
)

summary
# The result is stored in a new data frame called 'summary'
# This summary will have just one row (if df is not grouped), and two columns: 'mean_mpg' and 'min_mpg'

head(df)
# we can also group_by()
# group_by()
# we can group by gears
grouped_df <- group_by(df, gear)
grouped_df

# we can summarize grouped data
# this will give you the mean, median, min and max for each group
grouped_summary <-  summarise(grouped_df,
                              mean_mpg = mean(mpg),
                              median_mpg = median(mpg),
                              min_mpg = min(mpg),
                              max_mpg = max(mpg))
grouped_summary

# we also have the pipe operator denoted as %>%
# The pipe operator (%>%) allows you to pass the output of one 
# function directly into the next function. 

# instead of writing nested function like this
summarize(group_by(filter(df, mpg > 20), cyl), avg_mpg = mean(mpg))

# we can use %>% to achieve the same result

filtered_data <- df %>%
  filter(mpg > 20) %>%
  group_by(cyl) %>%
  summarise(average_mpg = mean(mpg))
filtered_data

# Using the pipe operator makes your code easier to read from top to bottom
# as it mirrors the logical sequence of data transformation steps.

# For cars with mpg greater than 20, I want to see only the mpg, cyl, and disp columns.

df_n <- df %>%
  filter(mpg > 20) %>%
  select(mpg, cyl, disp)
df_n

# Find the average mpg for cars with hp greater than 100, grouped by cyl.

df_w <- df %>%
  filter(hp > 100) %>%     
  group_by(cyl) %>%
  summarise(avg_mpg = mean(mpg))

  
df_w

# Group by cyl, create a new column hp_to_wt_ratio (hp / wt) for each group, 
# and calculate the maximum hp_to_wt_ratio for each group.
df_a <- df %>%
  group_by(cyl) %>%
  mutate(hp_to_wt_ratio = hp / wt ) %>%
  summarise(max_hp_to_wt_ratio = max(hp_to_wt_ratio))
df_a

# this would only select or filter by disp column containing just 140 and 160
a <- df %>%
  filter(disp %in% c(140,160))


head(df)

# this basically allow you sort by columns 
b <- arrange(df, gear)
head(b, n=9)

# we can also rename columns by using rename()
# rename() workd by doing this rename(dataframe, new_name=old_name)
g <- rename(df, "horse power" =hp)
head(g)


# we can also perform random sampling using sample_n() and sample_frac()
# sample_n(df, n) randomly selects 'n' rows from the data frame
# sample_frac(df, frac) randomly selects a fraction of rows (e.g., 0.5 for 50%)
# both functions can take an optional 'replace = TRUE' for sampling with replacement

# example using sample_n()
sample_n(df, 5)  # randomly selects 5 rows

# example using sample_frac()
sample_frac(df, 0.2)  # randomly selects 20% of rows

# set.seed() can be used before sampling to make results reproducible
set.seed(123)  # for reproducibility
sampled_n <- sample_n(df, 5)  # randomly selects 5 rows
head(sampled_n)


set.seed(123)
sampled_frac <- sample_frac(df, 0.2)  # randomly selects 20% of rows
head(sampled_frac)

