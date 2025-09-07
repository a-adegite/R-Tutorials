# Unlike vectors which contains just one data type, list can contain different data type
# # list can be created using list()

list_one <-  list(100, "true", FALSE)
typeof(list_one) # tells you the internal storage type of an object  
                 # basically how R represents that object in memory.

class(list_one) # tells you the high-level classification of an object

# items in the list can also be accessed by
list_one[1]

# we can also change the item in a list

list_one[2] <- "blackcurrant"
list_one

# To find out how many items a list has, use the length() function
length(list_one)

# we can check if a specified item is present in a list using %in%

"blackcurrant" %in% list_one # return TRUE if the item is present in the list and FALSE if it isn't

# we can add an item to the end of the list using append()

list_one <- append(list_one, "blackmirror")
list_one

# you can also append at a particular index by using after=index
list_one <- append(list_one, "DareDevil", after=1) # appends after index 1
list_one

# you can remove items in a list by using negative index
list_one[-2]

# you can also slice through the items in a list
list_one[1:2] # retrieves the first 2 items


# we can merge two list into one

list_a <- list("a", "s", "d", "f", "g")
list_b <- list("a", "e", "i", "o")
merged_list <- c(list_a, list_b)
merged_list

# We can also name a list
named_list <- list("Name"="Juwon", "Age"=20, "Country"="Nigeria")
named_list

# we can retrieve items in the list using either index or name

# using index
named_list[1]

# using name
named_list["Name"]

# another way to retrieve items in a list using name is
named_list$Name
