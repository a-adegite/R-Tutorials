# Compared to matrices, arrays can have more than two dimensions.
# We can use the array() function to create an array
# We use the dim parameter to specify the dimensions

array_items <- 1:10
array_one <- array(array_items, dim=c(5,1,2)) # this creates a 2 dimensional array with 5 rows and 1 columns
array_one

array_item_two <- seq(1,20)
array_two <- array(array_item_two, dim=c(2,5,2))
array_two

# accessing items in an array
# array[row position, column position, matrix level]
# suppose we would like to get layer one
array_two[,,1]

array_two[,,2] # this gets layer 2

# to get item in layer 1 row 1, column 2
array_two[1, 2, 1]

dim(array_two) # tells you the dimension of the array in row, column, depth

length(array_two)


colnames(array_two) <- c("a", "b", "c", "d", "e") # rename the matrix columns
array_two
