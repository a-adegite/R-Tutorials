library(tidyverse)
library(ggplot2)
library(viridis)
# a ggplot2 extension package that is helpful to prevent the overlap of labels. 
# It can be added as a layer, similar to geom_text.
library(ggrepel) 
library(cowplot)

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

# Start building the plot using the pax6_exp data frame
ggplot(
  pax6_exp,                                      # Data frame containing the PAX6 expression data
)+
  geom_point(                                    # Add individual points to the plot
    aes(                                         # Define how variables in the data map to visual properties
      x = group,                                 # Put experimental groups on the x-axis
      y = normalized_counts,                     # Put normalized expression counts on the y-axis
      colour = group                             # Colour each point according to its experimental group
    )
  )+
  geom_text_repel(                               # Add sample labels while automatically reducing label overlap
    aes(                                         # Map variables from the data to the text layer
      x = group,                                 # Position each label according to its group
      y = normalized_counts,                     # Position each label at its expression value
      label = samples                            # Use the sample name as the label
    )
  )+
  labs(                                          # Define plot labels
    title = "Pax6"                               # Set the title of the plot
  )+
  custom_theme()+                                # Apply your custom ggplot theme
  theme(                                         # Make additional theme modifications
    axis.text.x = element_text(                 # Modify the appearance of x-axis text
      angle = 45,                                # Rotate x-axis labels by 45 degrees
      hjust = 1,                                 # Horizontally justify the labels toward the right
      vjust = 1                                  # Vertically justify the labels toward the bottom
    )
  )+
  scale_x_discrete(                              # Customize the discrete x-axis
    name = "",                                   # Remove the x-axis title
    labels = c(                                  # Replace the original group names with readable labels
      " Pax6:WT" = "Radial glia",                # Rename Pax6:WT to Radial glia
      "Tbr2:WT" = "Preogenitors",                # Rename Tbr2:WT to Progenitors
      "neg:WT" = "Neurons"                       # Rename neg:WT to Neurons
    )
  )+
  scale_fill_viridis(                            # Apply a Viridis colour scale to the fill aesthetic
    discrete = TRUE,                             # Tell ggplot that the variable is categorical/discrete
    option = "viridis",                          # Use the standard Viridis colour palette
    begin = 0.2                                  # Start the palette at 20% of its colour range
  )


volcano_RG <- ggplot(
  result,
  aes(
    x = pax6_log2FoldChange,
    y = -log10(pax6_padj),
    colour = pax6_threshold
  )
)+
  geom_point()+
  labs(
    title = "Radial glia",
    x = "Log2 fold change",
    y = "-Log10 p-value"
  )+
  custom_theme()+
  scale_color_manual(values = c("grey", "purple"))+
  scale_x_continuous(limits = c(-3, 3.5))

# To add custom text to the plot, we can use additional functionality from the cowplot package, 
# draw_label() function, to add custom text to our figures. We use the ggdraw() function 
# to draw the ggplot2 image to the canvas, and then the draw_label() function to add the text on top.

volcano_RG <- ggplot(
  result,
  aes(
    x = pax6_log2FoldChange,
    y = -log10(pax6_padj),
    colour = pax6_threshold
  )
)+
  geom_point()+
  labs(
    title = "Radial glia",
    x = "Log2 fold change",
    y = "-Log10 p-value"
  )+
  custom_theme()+
  scale_color_manual(values = c("grey", "purple"))+
  scale_x_continuous(limits = c(-3, 3.5))

ggdraw(volcano_RG) +
  draw_label(
    "664 genes",
    size = 12,
    hjust = 0,
    vjust = 0,
    x = 0.15, 
    y = 0.82,
    fontface = "bold"
  )+
  draw_label("Down \n247 genes", 
             x = 0.15,
             y = 0.2,
             size = 12,
             hjust = 0,
             vjust = 0) +
  draw_label("Up \n417 genes", 
             x = 0.77,
             y = 0.2,
             size = 12,
             hjust = 0,
             vjust = 0)

# Create IP volcano plot
volcano_IP <- ggplot(
  result,
  aes(
    x = tbr2_log2FoldChange,
    y = -log10(tbr2_padj),
    colour = tbr2_threshold
  )
)+
  geom_point()+
  labs(
    title = "Intermediate progenitors",
    x = "Log2 fold change",
    y = "-Log10 p-value"
  )+
  custom_theme()+
  scale_color_manual(values = c("grey", "purple"))+
  scale_x_continuous(limits = c(-3,3.5))

volcano_neu <- ggplot(
  result,
  aes(
    x = neg_log2FoldChange,
    y = -log10(neg_padj),
    colour = neg_threshold
  )
)+
  geom_point()+
  labs(
    title = "cortical neurons",
    x = "Log2 fold change",
    y = "-Log10 p-value"
  )+
  custom_theme()+
  scale_color_manual(values = c("grey", "purple"))+
  scale_x_continuous(limits = c(-3,3.5))

# Annotating all figures
volcano_panel1 <- ggdraw(volcano_RG) +
  draw_label(
    "664 genes",
    size = 12,
    hjust = 0,
    vjust = 0,
    x = 0.15, 
    y = 0.82,
    fontface = "bold",
  )+
  draw_label(
    "Down \n247 genes",
    x = 0.15,
    y = 0.2,
    size = 12,
    hjust = 0,
    vjust = 0
  )+
  draw_label(
    "Up \n417 genes",
    x = 0.77,
    y = 0.2,
    size = 12,
    hjust = 0,
    vjust = 0
  ) 
        
volcano_panel2 <- ggdraw(volcano_IP)+
  draw_label(
    "405 genes",
    size = 12,
    hjust = 0,
    vjust = 0,
    x = 0.15,
    y = 0.82,
    fontface = "bold"
  )+
  draw_label(
    "Down \n164 genes",
    size = 12,
    hjust = 0,
    vjust = 0,
    x = 0.15,
    y = 0.2
  )+
  draw_label(
    "Up \n241 genes",
    size = 12,
    hjust = 0,
    vjust = 0,
    x = 0.77,
    y = 0.2
  )

volcano_panel3 <- ggdraw(volcano_neu)+
  draw_label(
    "33 genes",
    size = 12,
    hjust = 0,
    vjust = 0,
    x = 0.15,
    y = 0.82,
    fontface = "bold"
  )+
  draw_label(
    "Down \n21 genes",
    size = 12,
    vjust = 0,
    hjust = 0,
    x = 0.15,
    y = 0.2
  )+
  draw_label(
    "Up \n12 genes",
    size = 12,
    vjust = 0,
    hjust = 0,
    x = 0.8,
    y = 0.2
  )

volcano_grid <- plot_grid(
  volcano_panel1,
  volcano_panel2,
  volcano_panel3,
  ncol = 3
)

# Save plot
ggsave(
  plot = volcano_grid,
  filename = "results/fig4G.png",
  width = 14,
  height = 3,
  units = "in",
  device = png,
  dpi = 500
)

# Adding statistical comparisons
