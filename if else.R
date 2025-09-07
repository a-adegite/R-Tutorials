# An if statement is written with the if keyword.
# It is used to specify a block of code to be executed if a condition is TRUE
# R uses curly brackets { } to define the scope in the code.

x <-  2
y <-  4

if (y < 2) {
  print(paste(y, "is less than two"))
} else {
  print(paste(y, "is greater two"))
}

a <-  100
b <-  50

if ( a == b) {
  print("a is equal to b")
} else if (a > b) {
  print("a is greater than b")
} else {
  print("a is less than b")
}

# If else can be used with and (&) and or (|)

if (x < 2 & a > 50) {
  print("Both Conditions are true")
} else {
  print("Both Conditions are false")
}

if (x > 2 | a > 50) {
  print("One of the conditions are true")
} else {
  print("Both Conditions are false")
}