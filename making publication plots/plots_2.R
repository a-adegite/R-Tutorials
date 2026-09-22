library(ggplot2)
library(tidyverse)
library(RColorBrewer)
library(viridis)
# library(scales)
library(cowplot)

df = read.csv("data/pp_all_normalized_counts.csv", row.names = 1)
meta = read.csv("data/pp_all_meta.csv", row.names = 1)
head(df)
View(df)


custom_theme <- function(){
  theme_bw()+
    theme(
      axis.title = element_text(size = rel(1.25)),
      axis.text = element_text(size = rel(1.15)),
      plot.title = element_text(size = rel(1.5), hjust=0.5),
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      legend.position = "none"
    )
}

expression_plot <- pivot_longer(df,
                                cols = 2:25,
                                names_to = "samples",
                                values_to = "normalized_counts")

# Join metadata for visualizing groups or features
expression_plot <- left_join(x = expression_plot, 
                             y = meta, 
                             by = "samples")

View(expression_plot)

### Extract normalized counts for specific genes to plot
pax6_exp <- expression_plot %>%
  filter(geneSymbol == "Pax6" &
           genotype == "WT")

eomes_exp <- expression_plot %>%
  filter(geneSymbol == "Eomes" &
           genotype == "WT")

tubb3_exp <- expression_plot %>%
  filter(geneSymbol == "Tubb3" &
           genotype == "WT")

prdm16_exp <- expression_plot %>%
  filter(geneSymbol == "Prdm16" &
           genotype == "WT")     

pax6_exp$group <- factor(pax6_exp$group, levels = c("Pax6:WT", "Tbr2:WT", "neg:WT"))
eomes_exp <- factor(eomes_exp$group, levels = c("Pax6:WT", "Tbr2:WT", "neg:WT"))
tubb3_exp <- factor(tubb3_exp$group, levels = c("Pax6:WT", "Tbr2:WT", "neg:WT"))
prdm16_exp <- factor(prdm16_exp$group, levels = c("Pax6:WT", "Tbr2:WT", "neg:WT"))

View(pax6_exp)


# boxplot
ggplot(
  data = pax6_exp,
  aes(
    x = group,
    y = normalized_counts,
    fill = group,
    linetype = group
  )
)+
  geom_boxplot()+
  labs(
    title = "Pax6",
    x = "group",
    y = "normalized_counts"
  )+
  custom_theme()+
  theme(
    # this allows to ajust the text on the x axis. the element_text controls the text on the x axis
    # angle = 45 rotates the labels by 45 degrees.
    # hjust and vjust control the horizontal and vertical alignment.
    # hjust = horizontal justification
    # hjust = 0 = left-aligned
    # hjust = 0.5 = centered
    # hjust = 1 = right-aligned
    
    # vjust = vertical justification.
    
    # vjust = 0 = top
    # vjust = 0.5 = middle
    # vjust = 1 = bottom
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)
  )+
  
  # Plots can be customized using scales and colors
  # Scales controls the content that is displayed on the plot
  # scale_x_discrete() is used when the x-axis contains categories or groups.
  scale_x_discrete(
    # labels allows you to change the names displayed on the x-axis 
    # without changing the original values in your data. 
    # The value on the left is the original name in the data, 
    # while the value on the right is the new name displayed on the plot.
    labels = c(
      "Pax6:WT" = "Radial Glia",
      "Tbr2:WT" = "Neurons",
      "neg:WT" = "Progenitors"
    ) 
  )+
  # This control the y axis scale.
  # limits specifies the minimum and maximum values of the y-axis. 
  # Here, the y-axis starts at 0 and ends at 100.
  # breaks specifies where the tick marks and numbers # should appear on the y-axis. 
  # Here, the tick marks will appear at 20, 40, 60, 80 and 100.
  scale_y_continuous(limits = c(0,50), breaks = c(10, 20, 30, 40, 50))+
  # Let's you choose colour for eachc category
  scale_fill_manual(values = c("firebrick4", "lightsteelblue", "yellow2"))

# RColorBrewer allows you to selecte a predefine colour palettes
# To check all available colour pallete we use
display.brewer.all() # Check the available color palettes

# The palettes are separated into three sections based on the type of data:
# Sequential palettes (top): For sequential data, with lighter colors for low values and darker colors for high values.
# Qualitative palettes (middle): For categorical data, where the color does not denote differences in magnitude or value.
# Diverging palettes (bottom): For data with emphasis on mid-range values and extremes.

# For the boxplot, we can choose how many colours from the palette to remove
# display.brwer.pal is basically saying show me the colors in a particular ColorBrewer palette.
# 5 means show me 3 colours from the palette
# Set1 is the name of the palette
# There are different categories/group for each palette
# Qualitative palettes categories include
# "Accent"
# "Dark2"
# "Set1"
# "Set2"

# Sequential palettes
# "Blues"
# "BuGn"
# "BuPu"

# Diverging palettes
# "RdYlBu"
# "RdYlGn"
# "Spectral"
display.brewer.pal(5, "Set1")

# Finding color-blind friendly palettes
display.brewer.all(colorblindFriendly = TRUE)

display.brewer.pal(3, "Dark2")

# To use this palette in our plots, we need to define it with brewer.pal()  and save it in a variable

palette <- brewer.pal(3, "Dark2")
palette

# to use the palette
ggplot(
  pax6_exp,
  aes(
    x = group,
    y = normalized_counts,
    color = group
  )
)+
  geom_boxplot()+
  labs(
    title = "Pax6",
    y = "Normalized_counts"
  )+
  custom_theme()+
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust =1)
  )+
  scale_x_discrete(
    labels = c(
      "Pax6:WT" = "Radial Glia",
      "Tbr2:WT" = "Neurons",
      "neg:WT" = "Progenitors"
    ) 
  )+
  scale_color_manual(values = palette)

# When we created our plot, we used the fill argument within the aes() function; 
# therefore, to change the colors of these groups, we need to use the scale_fill_manual(). 
# If we had used the color argument within the aes() function, we would use the scale_color_manual().

# Viridis palettes
# The viridis R package contain palettes that represent good choices for color-blind friendly palettes 
# and printing in gray scale. The developers provide additional information about each of the eight color 
# palettes available, including how it is visualized with different types of color-blindness and in gray scale.

ggplot(
  pax6_exp,
  aes(
    x = group,
    y = normalized_counts,
    fill = group
  )
)+
  geom_boxplot()+
  labs(
    title = "Pax6",
    y = "Normalized counts",
  )+
  custom_theme()+
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)
  )+
  scale_x_discrete(
    labels = c(
      "Pax6:WT" = "Radial Glia",
      "Tbr2:WT" = "Neurons",
      "neg:WT" = "Progenitors"
    ) 
  )+
  scale_fill_viridis(discrete = TRUE)

# We could specify the palette manually using the hexadecimal code. 
# The hexadecimal codes for each color can be identified using the viridis_pal() 
# and show_col() functions from the scales package.
show_col(viridis_pal(option = "viridis")(30))
         

# It creates a color palette generator.
# Think of it as give me a function that can generate colors from the Viridis palette
viridis_pal(option = "viridis") # This creates the function

# What does option = "viridis" mean?
# Viridis has several different palette options.
# For example:
# viridis_pal(option = "viridis")
# viridis_pal(option = "magma")
# viridis_pal(option = "plasma")
# You're saying:
# option = "viridis"
# "Use the standard viridis palette."
# So:
viridis_pal(option = "viridis")
# means:
# Create a Viridis color generator using the viridis palette.
viridis_pal(option = "viridis")(30) # Means generate 30 colours from the viridis palette
# show_col() # displays the colours in hex codes

ggplot(
  pax6_exp,
  aes(
    x = group,
    y = normalized_counts,
    fill = group
  )
)+
  geom_boxplot()+
  labs(
    title = "Pax6",
    y = "Normalized counts",
  )+
  custom_theme()+
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)
  )+
  scale_x_discrete(
    labels = c(
      "Pax6:WT" = "Radial Glia",
      "Tbr2:WT" = "Neurons",
      "neg:WT" = "Progenitors"
    ) 
  )+
  scale_fill_viridis(discrete = TRUE, option = "viridis", begin = 0.2)
