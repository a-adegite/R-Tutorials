# Data types in R include
# numeric (1,22.5 3) this describes numbers that are integers or floating points
# integers (3) this is denoted with L
# character (this is basically strings)
# logical (in R booleans True or False are called logical)
# unlike python, R logical are always in uppercase TRUE or FALSE
# complex (9 + 3i, where "i" is the imaginary part) think complex numbers

# numeric
a <- 5
print(a)
class(a)

# character 
b <- "string"
print(b)
class(b)

# integers
# To create an integer variable, you must use the letter L after the integer value
c <- 3L # The L here tells R this is an integer and not a numeric datatype
print(c) # prints value stored in variable a
class(c) # checks what datatype is stored in variable a

# complex
d <- 4i
print(d)
class(d)



# Datatype Conversion
# You can convert from one type to another with the following functions:
# as.numeric() this changes the datatype to numeric
# as.character() this changes the datatype to character
# as.integer() this changes the datatype to integer
# as.complex() this changes the datatype to complex

 e <- as.character(a) # this will convert the number stored in a to a string
 print(e)
 class(e)
 
 # we can also convert a numeric datatype into a integer
 f <- as.integer(a)
 print(f)
 class(f)