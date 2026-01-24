# Factors are used to categorize data. Examples of factors are:
# Demography: Male/Female
# Music: Rock, Pop, Classic, Jazz
# Training: Strength, Stamina

# to create a factor, use the factor() function and add a vector as argument

movies_genre <-  factor(c("science fiction", "horror", "comedy", "horror", "thriller", "science fiction"))
movies_genre # this will print out all the m ovie genre and the levels of each movie genre

# to get the levels alone, we use levels
levels(movies_genre)

# Use the length() function to find out how many items there are in the factor:
length(movies_genre)

# To access the items in a factor, refer to the index number, using [] brackets
movies_genre[2]

# To change the value of a specific item, refer to the index number
movies_genre[1] <- "thriller"

movies_genre
