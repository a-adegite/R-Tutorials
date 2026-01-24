# ggplot2 is a powerful data visualization package in R based on the "Grammar of Graphics"
# It allows you to build complex plots from data in a structured, layered approach

# The basic structure of a ggplot is:
# ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) + <GEOMS> + <OTHER_LAYERS>

# Components of ggplot2:

# 1. data      -> The data frame you are visualizing
# 2. aes()     -> Aesthetic mappings (e.g., x and y axes, color, size)
# 3. geom_*    -> Geometric objects (e.g., geom_point(), geom_bar(), geom_line()) 
#                 define what type of plot. Types of plot layers, like points, lines, bars, etc.
# 4. +         -> Layers are added using the '+' operator
# 5. themes, scales, facets, labels, etc. can be added to enhance the plot

# we load tidyverse
library(tidyverse)

# then we create a dataframe with an inbuilt R dataset
df <- ChickWeight 

head(df, 10)

df$Diet
# making a scatterplot with ggplot

ggplot(data=df) #This initializes the plot with the dataset ChickWeight.
aes(x=Time, y=weight) # The aes() function specifies our mappings. 
                      # Here, Time is mapped to the x-axis and weight is mapped to the y-axis.
geom_point(): # This adds the geometric layer that plots the data as points, 
              # making it a scatterplot.
labs():  # another layer that allows you to add labels
  
# putting it all together
# This plot shows how chick weight changes over time, grouped by different diets

ggplot(data = df,                             # 1. Specify the data source (a data frame named 'df')
       aes(x = Time,                          # 2. Map the 'Time' variable to the x-axis
           y = weight,                        #    Map 'weight' to the y-axis
           color =Diet)) +                   #    Use 'Diet' to determine point color (grouping variable)

geom_point(size = 3) +                      # 3. Add scatter plot points with increased size for visibility

labs(title = "Chick Weight Gain over Time by Diet",  # 4. Add a title and axis labels
     x = "Time",                            #    Label for the x-axis
     y = "Weight")                          #    Label for the y-axis


colnames(df)
# make a line plot
ggplot(data = df,                    # Initialize a ggplot object using the data frame 'df'
       aes(x = weight,               # Map the variable 'weight' to the x-axis
           y = Time)) +              # Map the variable 'Time' to the y-axis
  
  geom_line(linewidth = 0.3) +        # Add a line plot with thin lines (line width = 0.3)
  
  facet_wrap(. ~ Diet) +              # Create separate panels (facets) for each level of 'Diet'
  
  labs(title = "A line plot",         # Set the main title of the plot
       x = "weight in kilograms",     # Label the x-axis
       y = "time in minutes") +       # Label the y-axis
  
  theme_minimal(                      # Apply a clean, minimal theme to the plot
    base_size = 9,                    # Set the base font size to 9
    base_family = "Source sans pro"   # Set the font family to Source Sans Pro
  )


# make scatter plot
ggplot(data = df,
       aes(x = Time, 
           y = weight,
           color = Diet)) +
  geom_point() +
  labs(x="Time", y="Weight") +
  scale_x_continuous(limits = c(0,25)) + # adjust the scales by setting the x-axis limits to a range of 0-25
  scale_y_continuous(limits = c(50,400)) +
  scale_color_manual(breaks=factor(c(1,2,3,4)),
                     values=c("red", "green", "yellow", "orange")) # After setting colors to diet, this tells ggplot
                                                                   # that you want to set your colours yourself

# breaks = factor(c(1, 2, 3, 4))
# This specifies which factor levels of the color variable the scale applies to.
# Here, the plot expects the color variable to have four levels:
# 1, 2, 3, and 4
# Wrapping them in factor() ensures ggplot treats them as categories, not numbers.
# values = c("red", "green", "yellow", "orange")
# This assigns a specific color to each factor level
# The order matters:
# 1 is red
# 2 is green
# 3 is yellow
# 4 is orange
# Each value must match one break


# Select only columns where Diet is 4
diet_four <- dplyr::filter(df, Diet == 1 )

# make scatter plot
ggplot(data = diet_four,
       aes(x = Time, 
           y = weight,
           )) +
  geom_point() +
  labs(x="Time", y="Weight") +
  scale_x_continuous(limits = c(0,25)) + # adjust the scales by setting the x-axis limits to a range of 0-25
  scale_y_continuous(limits = c(50,400)) 

# making a box plot 
ggplot(data=df, aes(x=Diet, y=weight)) +
  geom_boxplot() +
  labs(title="boxplot", x="Diet", y="Weight")



# subplots can be created using facet_grid()
# facet_grid allows us to split our data into subplots based on categorical variables. 
# This allows us to see interactions between variables.

ggplot(data=df, aes(x=Time,y=weight)) +
  geom_point() +
  facet_grid(.~Diet) +
  theme_bw()

# facet_grid(. ~Diet) Creates a row of plots, one for each level of Diet.
# The dot (.) on the left of ~ means "don’t facet by rows".
# The Diet on the right of ~ means "facet by Diet across columns".
# So you'll get multiple plots in a single row, each showing chick weight vs. time for a different Diet group.


ggplot(data=df, aes(x=Time,y=weight)) +
  geom_point() +
  facet_grid(Diet ~.)

# facet_grid(Diet ~ .) Creates a column of plots, one for each level of Diet.
# Now, Diet is on the left of ~, meaning "facet by rows using Diet".
# The dot on the right of ~ means "don’t facet by columns".
# So this time you'll get multiple plots stacked vertically, each showing data for a different Diet.


# basically, 
# Code	                    Layout	             Faceting Direction
# facet_grid(. ~ Diet)	   One row          multiple columns	Facet horizontally
# facet_grid(Diet ~ .)	  One column        multiple rows	Facet vertically


ggplot(data=df, aes(x=Time,y=weight)) +
  geom_point() +
  facet_wrap(.~Diet)

# You can set a default theme by using theme_set() so that any graphics created automatically use the theme
theme_set(                                   # Set a global ggplot2 theme for all future plots
  theme_minimal(                             # Start with the minimal theme
    base_size = 12,                          # Set the base font size to 12
    base_family = "Arial"                    # Set the default font family to Arial
  ) +
    theme(                                     # Further customize specific theme elements
      plot.title = element_text(               # Target the plot title text
        face = "bold"                          # Make the plot title bold
      )
    )
)


