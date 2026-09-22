library(ggplot2) # library() loads a package; ggplot2 is used for plotting

# Read in the metadata file
meta <- read.csv("data/pp_all_meta.csv", row.names = 1) # <- assigns the output to an object; read.csv() reads a CSV file; row.names = 1 uses column 1 as row names

# Read in the normalized gene expression values
normalized_counts <- read.csv("data/pp_all_normalized_counts.csv", row.names = 1) # read.csv() reads the file; row.names = 1 uses the first column as row names

# Read in the results of the differential gene expression analysis
results <- read.csv("data/pp_all_results.csv", row.names=1) # results is the object where the imported data is stored




ggplot(results, aes(
  x = pax6_log2FoldChange, # x = specifies what goes on the x axis
  y = -log10(pax6_padj), # y = specifies what goes on the y axis; -log10() transforms the p-value
  colour = pax6_threshold, # colour = maps a variable to the colour of the points
  alpha = pax6_baseMean # alpha = maps a variable to point transparency
)) +
  geom_point(size = 2.0, shape = 15) + # geom_point() adds points; size = point size; shape = point shape
  labs(
    x = "Log2Fold Change", # x = changes the x-axis label
    y = "-log10(Padjusted Value)", # y = changes the y-axis label
    title = "Radial Glia" # title = changes the plot title
  ) +
  theme_bw() + # theme_bw() applies a black-and-white theme
  theme(
    axis.title = element_text(size = rel(1.25)), # axis.title controls axis-title appearance; element_text() formats text; rel() sets size relative to default
    axis.text = element_text(size = rel(1.15)), # axis.text controls axis-number appearance
    plot.title = element_text(hjust=0.5), # plot.title controls title appearance; hjust = horizontal position; 0.5 = centred
    panel.grid.major.y = element_blank(), # element_blank() removes the major horizontal grid lines
    panel.grid.minor.y = element_blank(), # removes the minor horizontal grid lines
    panel.grid.major.x = element_blank(), # removes the major vertical grid lines
    panel.grid.minor.x = element_blank() # removes the minor vertical grid lines
  ) 


ggplot(results, aes(
  x = pax6_log2FoldChange, # x = variable plotted on the x axis
  y = -log10(pax6_padj), # y = variable plotted on the y axis; -log10() transforms the values
  colour = pax6_threshold # colour = variable controlling point colour
)) +
  geom_point(size = 2.0) + # adds points; size = controls point size
  labs(
    x = "Log2 fold change", # changes x-axis label
    y = "-Log10 p-value", # changes y-axis label
    title = "Radial Glia" # changes plot title
  ) +
  theme_bw() + # applies black-and-white theme
  theme(
    axis.title = element_text(size = rel(1.25)), # changes axis-title size
    axis.text = element_text(size = rel(1.15)), # changes axis-text size
    plot.title = element_text(size = rel(1.5), hjust=0.5), # changes title size and centres it
    panel.grid.major.y = element_blank(), # removes major horizontal grid lines
    panel.grid.minor.y = element_blank(), # removes minor horizontal grid lines
    panel.grid.major.x = element_blank(), # removes major vertical grid lines
    panel.grid.minor.x = element_blank(), # removes minor vertical grid lines
    legend.position = "none" # removes the legend
  ) +
  scale_color_manual(values = c("grey", "purple")) + # manually sets the point colours; c() combines the colours into a vector
  scale_x_continuous(limits = c(-3, 3.5)) # controls a continuous x axis; limits = sets the minimum and maximum


# Consistent formatting using custom themes
# This allows you to create a function that you can apply to all themes to make consistent
custom_theme <- function(){ # function() creates a function; {} contains the code that belongs to the function
  theme_bw()+ # applies the black-and-white theme
    theme(
      axis.title = element_text(size = rel(1.25)), # formats axis titles
      axis.text = element_text(size = rel(1.15)), # formats axis text
      plot.title = element_text(size = rel(1.5), hjust=0.5), # formats and centres the title
      panel.grid.major.y = element_blank(), # removes major horizontal grid lines
      panel.grid.minor.y = element_blank(), # removes minor horizontal grid lines
      panel.grid.major.x = element_blank(), # removes major vertical grid lines
      panel.grid.minor.x = element_blank(), # removes minor vertical grid lines
      legend.position = "none" # removes the legend
    )
}

volcano_IP <- ggplot( # <- saves the plot as an object called volcano_IP
  results, # data frame being used for the plot
  aes(
    x = tbr2_log2FoldChange, # x = variable plotted on x axis
    y = -log10(tbr2_padj), # y = variable plotted on y axis; -log10() transforms the values
    colour = tbr2_threshold # colour = variable controlling point colour
  )
) +
  geom_point(size = 2) + # adds points; size = point size
  labs(
    x = "Log2 fold change", # changes x-axis label
    y = "-log10(padjusted Value)", # changes y-axis label
    title = "Intermediate progenitors" # changes plot title
  ) +
  custom_theme() + # () runs/calls the custom_theme function
  scale_color_manual(values = c("grey", "purple")) + # manually sets colours; c() combines the values
  scale_x_continuous(limits = c(-3, 3.5)) # sets x-axis limits from -3 to 3.5

volcano_IP # displays the plot stored in volcano_IP

volcano_neu <-  ggplot( # <- saves the plot as an object called volcano_neu
  results, # data frame being used for the plot
  aes(
    x = neg_log2FoldChange, # x = variable plotted on x axis
    y = -log10(neg_padj), # y = variable plotted on y axis; -log10() transforms the values
    colour = neg_threshold # colour = variable controlling point colour
  )
) +
  geom_point(size = 2) + # adds points to the plot
  labs(
    x = "Log2 fold change", # changes x-axis label
    y = "-Log10 p-value", # changes y-axis label
    title = "Cortical neurons" # changes plot title
  ) +
  custom_theme() + # applies the custom theme function
  scale_colour_manual(values = c("grey", "purple")) + # manually sets point colours
  scale_x_continuous(limits = c(-1.5, 1.5)) # sets x-axis limits from -1.5 to 1.5

volcano_neu # displays the plot stored in volcano_neu
