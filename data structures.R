# Data structures are used to store and organize values.
# R provides many built-in data structures. Each is used to handle data in different ways:
# Vectors
# Lists
# Matrices
# Arrays
# Data Frames

# Vectors
# A vector is simply a list of items that are of the same type.
# To combine the list of items to a vector, 
# use the c() function and separate the items by a comma.

vector_one <- c("Jane", "John", "James", "June")
print(vector_one)

# Vector with numerical values in a sequence
numbers <- 1:10
print(numbers)

# Vectors can also be created with decimals in a sequence
decimals <- 1.5: 11.5
print(decimals)

# Vector of logical values
log_values <- c(TRUE, FALSE, TRUE, FALSE)
log_values

# we can check the length of a vector by using length()
length(numbers) # this should give you 10

# vectors can be sorted using the function sort()
unordered_vector <- c(4, 2, 7, 8, 8, 3, 0, 19, 11, 5)
unordered_vector 
sort(unordered_vector)

# Vectors can be accessed using the square bracket
ordered_vector <- sort(unordered_vector)
ordered_vector[1]
ordered_vector[2]

# to access a items in position 4 and 10
ordered_vector[c(4,10)]

# You can also use negative index numbers to access all items except the ones specified
ordered_vector[-10] # this gives you all items except the item at position 10

# We can change the item in a vector at a particular position
# Here we change the item at position one
ordered_vector[1] <-  100
ordered_vector

To repeat vectors, use the rep() function