# A matrix is a two dimensional data set with columns and rows.
# A column is a vertical representation of data, while a row is a horizontal representation of data.
# A matrix can be created with the matrix() function
#  Specify the nrow and ncol parameters to get the amount of rows and columns

grid_one <- matrix(1:12, ncol=3, nrow=4)
grid_one

# you can access items in a matrices using []

grid_one[1,2] # retrieves item in row one, column two

grid_one[2,] # retrieves items in row 2 and all columns

grid_one[,2] # retrieves items in all rows and column 2

# we can access more than one row
grid_one[c(1,3), 2]

# we can access more than one column
grid_one[, c(1,3)]

grid_one[1:2, 2:3]

# we can join matrices column wise using cbind()
grid_two <- matrix(1:10, ncol=2, nrow=5)
grid_three <- matrix(10:20, ncol=2, nrow=5)
merged_grid_col <-  cbind(grid_two, grid_three)
merged_grid_col

merged_grid_row <- rbind(grid_three, grid_two)
merged_grid_row

# you can check if an item is in a matrix
5 %in% merged_grid_row

# we can also remove some rows or columns
merged_grid_col[-1, -3]

# you can also check the dimension of a matrix
dim(merged_grid_col)

# this tells you th number of items in a matrix
length(merged_grid_col)

# this gives you the number of rows
nrow(merged_grid_col)

# this give you the number of columns
ncol(merged_grid_col)
merged_grid_col

# giving matrix names
colnames(merged_grid_col) <-  c("a", "b", "c", "d") # this rename the column names
merged_grid_col

# we can get the row names using rownames() and rename using rownames()
rownames(merged_grid_col) <- c("row a", "row b", "row c", "row d", "row e")
merged_grid_col

