welcome_message <- "Welcome to R tutorials" 

print(welcome_message)

# we can have multiline strings
str <- "Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."

print(str) # the \n is added to indicate a new line

# if you don't want the escape character \n to show, you use cat()
cat(str)

vowels <- "aeiou"
nchar(vowels) # this tells you the number of letters that makes up the string

# we can also search for strings withing a string using grepl()

# grepl() gives you a logical output 
# this will return true if R is found in the variable welcome_message
grepl("R", welcome_message) 

# you can combine strings using paste()
str1 <- "Python"
str2 <- "is Cool"
word <- paste(str1,str2)
print(word)