# The plot() function in R is used to draw points (or lines) on a diagram.
# It takes two main parameters: the x-coordinates and the y-coordinates.

# Plot a single point where x = 3 and y = 4
plot(3, 4)   # This creates a scatterplot with one point (3,4).
# By default, R also adds axis scales around the point.

# Plot two points: (1,3) and (8,10)
plot(c(1, 8), c(3, 10))   # The first vector c(1,8) gives x-values.
# The second vector c(3,10) gives y-values.
# This results in two plotted points.

# Plot multiple points with five pairs of coordinates:
# (1,3), (2,7), (3,8), (4,9), (5,12)
plot(c(1, 2, 3, 4, 5), c(3, 7, 8, 9, 12)) 
# Here, the first vector is the x-values and the second vector is the y-values.

# For better readability and organization, store values in variables
x <- c(1, 2, 3, 4, 5)     # Define a vector of x-coordinates
y <- c(3, 7, 8, 9, 12)    # Define a vector of y-coordinates

# Plot the points using the variables
plot(x, y)   # This produces the same result as the previous command,
# but is cleaner, easier to read, and more manageable when
# working with larger datasets.

# Plot numbers from 1 to 10 on the y-axis against their index (1 to 10) on the x-axis
plot(1:10)   
# By default, this creates a scatter plot of points (1,1), (2,2), ..., (10,10).
# The x-values are 1:10 and the y-values are also 1:10.

# Plot the same numbers, but connect them with a line instead of just points
plot(1:10, type="l")  
# The argument type="l" tells R to draw lines instead of points.
# This produces a line graph that goes from (1,1) to (10,10).

# Add labels and a title to make the plot more informative
plot(1:10, type="l", xlab="height", ylab="count", main="Graph of height against count", col="tomato") 
# type="l": makes it a line graph
# xlab="height": labels the x-axis as "height"
# ylab="count": labels the y-axis as "count"
# main="Graph of height against count": adds a title to the plot
# col="tomato": makes the line coloured 

# Use cex=number to change the size of the points 
# (1 is default, while 0.5 means 50% smaller, and 2 means 100% larger)
plot(1:10, col="blue", cex=1.5)

# Use pch with a value from 0 to 25 to change the point shape format:

plot(1:40, col="red", pch=23, cex=1.5)

plot(1:40, col="red", pch=20, cex=1.5)



# Making a line graph

plot(1:100, col="skyblue", type="l", lwd=4, lty=3)
# plot(1:100): creates a sequence of numbers from 1 to 100
# col="skyblue": changes the color of the line to sky blue
# type="l": tells R to draw a line instead of just points
# lwd=4: increases the line width (default is 1, so 4 means much thicker)
# the lty parameter controls the style of the line.
# lty=3: makes the line dotted
# Demonstrating different line styles with lty parameter

# lty = 0 : blank (no line)
# lty = 1 : solid line (default)
# lty = 2 : dashed line
# lty = 3 : dotted line
# lty = 4 : dot-dash line
# lty = 5 : long-dash line
# lty = 6 : two-dash line

# display more than one line in a graph
# use the plot() function together with the lines() function
line1 <- c(1,2,4,5,6,8,7)
line2 <- c(2,3,4,5,7,8,9)
plot(line1, type="l", col="blue")
lines(line2, type="l", col="red")


# Scatter Plots
# A scatter plot is a type of plot used to display the relationship between two numerical variables
# It needs two vectors of same length
# one for the x-axis (horizontal) and one for the y-axis (vertical)

x <- c(5,7,8,7,2,2,9,4,11,12,9,6)
y <- c(99,86,87,88,111,103,87,94,78,77,85,86)

plot(x, y, main="Observation of Cars", xlab="Car Age", ylab="Car Speed")


# Day 1 data (12 cars)
# x1 = ages of cars, y1 = speeds of cars
x1 <- c(5,7,8,7,2,2,9,4,11,12,9,6)
y1 <- c(99,86,87,88,111,103,87,94,78,77,85,86)

# Day 2 data (15 cars)
# x2 = ages of cars, y2 = speeds of cars
x2 <- c(2,2,8,1,15,8,12,9,7,3,11,4,7,14,12)
y2 <- c(100,105,84,105,90,99,90,95,94,100,79,112,91,80,85)

# Plot both datasets on the same graph
# First plot Day 1 data:
# x1 and y1 define car ages vs. speeds
# main = adds a title to the plot
# xlab and ylab = axis labels
# col="red" = points will be red
# cex=2 = makes points larger (default is 1)
plot(x1, y1, 
     main="Observation of Cars", 
     xlab="Car age", 
     ylab="Car speed", 
     col="red", 
     cex=2)

# Add Day 2 data to the same plot:
# points() adds extra points without erasing the first plot
# col="blue" = Day 2 points in blue
# cex=2 = same larger size as Day 1 points
points(x2, y2, col="blue", cex=2)


# Creating pie charts
# Define the values for the pie chart
pie_values <- c(10, 20, 5, 25, 40) # Each number represents the size of a slice

# The pie() function takes the numeric vector and
# divides the circle proportionally to the values
pie(pie_values)

# Define the values (proportions for each slice)
x <- c(10,20,30,40)

# Define the labels for each slice
labels <-  c("tax", "Petroleum", "Agriculture","Security")

# Define colors for each slice
colors <- c("blue", "yellow", "green", "black")

# Create the pie chart
# x = slice values
# init.angle = 90 rotates the start position of the pie to the top (12 o’clock)
# labels = adds labels to each slice
# main = adds a title to the chart
# col = assigns colors to each slice
pie(x, init.angle = 90, label=labels, main="Revenue", col=colors)

# Add a legend to identify colors
# "bottomleft" = position of the legend
# labels = text inside the legend
# fill = colors corresponding to each label
legend("bottomleft", labels, fill = colors, cex=0.8)

# The legend can be positioned as either:
  
# bottomright
# bottom 
# bottomleft
# left
# topleft
# top
# topright 
# right 
# center

# A bar chart can be created using barplot()
# x-axis values

# Categories for the x-axis (bar labels)
x <- c("A", "B", "C", "D")

# Heights of the bars (y-axis values)
y <- c(2, 4, 6, 8)

# Create the bar chart
# - y = heights of bars
# - names.arg = labels to display below each bar
barplot(y, names.arg = x, col="tomato", density=20)

# Categories (x-axis labels)
x <- c("E", "F", "G", "H")

# Heights of bars
y <- c(10, 13, 20, 30)

# Create bar chart
# - names.arg = labels under each bar
# - width = controls the thickness of each bar
barplot(y, names.arg = x, width = c(2, 4, 6, 8))