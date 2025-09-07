# Operators are used to perform operations on variables and values.
# R divides the operators in the following groups:
# Arithmetic operators
# Assignment operators
# Comparison operators
# Logical operators
# Miscellaneous Operators

# Arithmetic Operators
# Arithmetic operators are used with numeric values to perform common mathematical operations

# + : addition
# - : subtraction
# * : multiplication
# / : division
# ^ : exponentiation
# %% : modulus
# %/% : floor division

# Assignment Operators
# Assignment operators are used to assign values to variables

# <- : assignment operator
my_var <- 3

# <<- : global assignment operator
my_var <<- 4

x <-  19
y <- 10

# Comparison Operators

# ==	Equal
print(x == y)

# !=	Not equal	
print(x != y)

# >	Greater than	
print(x > y)	

# <	Less than
print(x < y)	

# >=	Greater than or equal to
print(x >= y)

# <=	Less than or equal to	
print(x <= y)

# Logical Operators

# &	: Element-wise Logical AND operator. Returns TRUE if both elements are TRUE
# && : 	Logical AND operator. Returns TRUE if both statements are TRUE

# | : Element wise- Logical OR operator. Returns TRUE if one of the statements is TRUE
# || : Logical OR operator. Returns TRUE if one of the statements is TRUE

# ! : Logical NOT. Returns FALSE if statement is TRUE

# Miscellaneous Operators
# :	Creates a series of numbers in a sequence
print(1:10)

# %in%	Find out if an element belongs to a vector
seq <- c(1:10) # this creates a vector of 1 - 10
3 %in% seq # check if 3 is in the vector

# %*% : Matrix Multiplication
