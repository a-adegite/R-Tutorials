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

# To repeat vectors, use the rep() function
repeated <-  rep(c(1,2,3,5), each=2) # this repeat each item 2 times
repeated

# we can also repeat the entire sequence instead of the items in the vector by using times instead of each
repeat_times <- rep(c(1,2,3,5), times = 3)
repeat_times


# We can repeat each value independently
repeat_indepent <- rep(c(1,2,3), times = c(5,2,1)) # this says you want to repeat 1 5 times,
                                                   # repeat 2, 2 times
                                                   # repeat 3 once
repeat_indepent

# We can generate Sequenced Vectors by using :
seq_vector <-  1:10
seq_vector

seq(1,10, length=20) # creates 20 numbers evenly spaced between 1 and 10

# To make bigger or smaller steps in a sequence, use the seq() function:
# The seq() function has three parameters: from, to and by
# from is where the sequence starts, 
# to is where the sequence stops, 
# and by is the interval of the sequence.

sequence_one <- seq(from=0, to=100, by=10)
sequence_two <- seq(from=1, to=100)
sequence_one
sequence_two


any(sequence_one > 2) # this checks is any of the element in the vector are greater than 2. 
                      # It returns true if any element in the vector is greater than 2

all(sequence_one > 2) # this checks if all the element in the vector are greater than 2.
                      # It returns true if all the element in the vector is greater than 2

which(sequence_one > 80) # returns index of elements in a  vector greater than 80

sequence_one[5:10] # retrieves elements from index 5 to index 10
sequence_one[-5:-10] # retrieves all elements except from index 5 to index 10

(sequence_one < 5) & (sequence_one > 20) # For each element, check if it is less than 5 AND greater than 20.  

(sequence_one < 5) | (sequence_one > 20) # # For each element, check if it is less than 5 or greater than 20.

# Naming Vectors
named_vector <- c("Jane"=1, "Joan"=2, "Jack"=3, "Jill"=4)
named_vector

# you can retrieve the items in a named vector by using the name
named_vector["Jane"]

# you can still retrieve the items in a named vector by using the index
named_vector[1]

named_vector[c("Jill", "Jane")]
