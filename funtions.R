# A function is a block of code which only runs when it is called.

# You can pass data, known as parameters, into a function.

# A function can return data as a result.

# To create a function, we use the keyword function()
# here we create a function and store it in a variable called greeting

greeting <- function() {
  print("Hello")
}

greeting() # we call the function by following the variable name with a parenthesis

# we can define a function with arguments
personalized_greetings <-  function(name) {
  print(paste("Hello", name))
}

personalized_greetings("Juwon")

# we can also have a default parameter
country <- function(country="Nigeria") {
  print(paste("I live in", country))
}

country() # if nothing is specified, it returns the default parameter
country("Ghana") # in this case, it returns the parameter Ghana


# using return. Return allows you to store a result in a variable and use it

add <-  function(a, b) {
 return(a + b)
}

a <- add(10,19)
print(a)