library(tidyverse)
library(ggplot2)
library(viridis)
# a ggplot2 extension package that is helpful to prevent the overlap of labels. 
# It can be added as a layer, similar to geom_text.
library(ggrepel) 
library(cowplot)
library(ggpubr)

df <- read.csv("data/pp_all_normalized_counts.csv", row.names = 1)

metadata <-  read.csv("data/pp_all_meta.csv", row.names = 1)

result <- read.csv("data/pp_all_results.csv", row.names = 1)

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


boxplot_pax6 <- ggplot(
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
    x = "Normalized counts"
  )+
  custom_theme()+
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)
  )+
  scale_x_discrete(
    name= "",
    labels = c(
      "Pax6:WT" = "Radial glia",
      "Tbr2:WT" = "Progenitors",
      "neg:WT" = "Neurons"
    )
  )+
  scale_fill_viridis(discrete = TRUE, option = "viridis", begin = 0.2)


# Drawing significance plots
ggdraw(boxplot_pax6)+
  draw_label(
    "*",
    x = 0.55,
    y = 0.62
  )+
  draw_label(
    "***",
    x = 0.82,
    y = 0.44
  )

# The above code achieves our goal, but it requires some trial and error with x- and y-coordinates.
# Alternatively, the ggpubr package allows a quicker and easier method to add statistical annotations to a plot.
# The ggpubr package extends ggplot2’s functionality and provides statistical comparisons between groups and customizable annotations.

# Create ggpubr stat table
# Create ggpubr stat table
stat.test <- tibble::tribble(                    # Create a tibble/data frame called "stat.test"
  
  ~group1, ~group2, ~p.adj, ~p.adj.signif,     # Define the column names:
  # group1 = first group
  # group2 = second group
  # p.adj = adjusted p-value
  # p.adj.signif = significance symbol
  
  "Pax6:WT", "Tbr2:WT", 0.003, "**",            # Compare Pax6:WT vs Tbr2:WT; p = 0.003; show **
  "Pax6:WT", "neg:WT", 0.0007, "**",            # Compare Pax6:WT vs neg:WT; p = 0.0007; show **
  "Tbr2:WT", "neg:WT", 0.01, "*"                # Compare Tbr2:WT vs neg:WT; p = 0.01; show *
)


boxplot_pax6 <- ggplot(                           # Create a ggplot and save it as "boxplot_pax6"
  pax6_exp,                                       # Use the "pax6_exp" data frame
  
  aes(                                            # Define how variables are mapped to the plot
    x = group,                                    # Put "group" on the x-axis
    y = normalized_counts,                        # Put "normalized_counts" on the y-axis
    fill = group                                  # Give each group a different colour
  )
) +
  
  geom_boxplot() +                                # Create a boxplot for each group
  
  labs(                                           # Add labels/title to the graph
    title = "Pax6",                               # Set the plot title to "Pax6"
    x = "Normalized counts"                       # Label the x-axis "Normalized counts"
  ) +
  
  custom_theme() +                                # Apply your previously defined custom theme
  
  theme(                                          # Modify specific visual elements
    axis.text.x = element_text(                  # Change the appearance of x-axis text
      angle = 45,                                 # Rotate x-axis labels by 45 degrees
      hjust = 1,                                  # Horizontally align the rotated labels
      vjust = 1                                   # Vertically align the rotated labels
    )
  ) +
  
  scale_x_discrete(                               # Control the categorical x-axis
    name = "",                                    # Remove the x-axis title
    labels = c(                                   # Rename the labels displayed on the x-axis
      "Pax6:WT" = "Radial glia",                 # Display "Radial glia" instead of "Pax6:WT"
      "Tbr2:WT" = "Progenitors",                  # Display "Progenitors" instead of "Tbr2:WT"
      "neg:WT" = "Neurons"                        # Display "Neurons" instead of "neg:WT"
    )
  ) +
  
  scale_fill_viridis(                             # Set the colours using the viridis palette
    discrete = TRUE,                              # Use separate colours for categorical groups
    option = "viridis",                           # Use the viridis colour palette
    begin = 0.2                                   # Start the palette at 20% of its range
  ) +
  
  stat_pvalue_manual(                             # Add statistical significance to the plot
    stat.test,                                    # Use the statistical results in "stat.test"
    label = "p.adj.signif",                       # Display *, ** etc. instead of actual p-values
    y.position = 55,                              # Place the significance annotations around y = 55 units
    step.increase = 0.15                          # Increase spacing between multiple comparisons by 0.15units
  )
