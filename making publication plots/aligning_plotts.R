library(cowplot)
library(tidyverse)
library(RColorBrewer)
library(viridis)
library(scales)


df = read.csv("data/pp_all_normalized_counts.csv", row.names = 1)

meta = read.csv("data/pp_all_meta.csv", row.names = 1)

expression_plot <- pivot_longer(df,
                                cols = 2:25,
                                names_to = "samples",
                                values_to = "normalized_counts")

# Join metadata for visualizing groups or features
expression_plot <- left_join(x = expression_plot, 
                             y = meta, 
                             by = "samples")

# Extract normalized counts for specific genes to plot
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

# Re-factor the levels to correspond to the same order as the Pax6 plot
eomes_exp$group <- factor(eomes_exp$group, levels = c("Pax6:WT", "Tbr2:WT", "neg:WT"))

tubb3_exp$group <- factor(tubb3_exp$group, levels = c("Pax6:WT", "Tbr2:WT", "neg:WT"))

prdm16_exp$group <- factor(prdm16_exp$group, levels = c("Pax6:WT", "Tbr2:WT", "neg:WT"))


# Create the ggplot2 objects

## Custom theme
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

## object for pax6
boxplot_pax6 <- ggplot(pax6_exp) +
  geom_boxplot(aes(x=group, 
                   y=normalized_counts, 
                   fill=group)) +
  ggtitle("Pax6") +
  custom_theme() +
  theme(axis.text.x = element_text(angle = 45, 
                                   vjust = 1, 
                                   hjust = 1)) +
  scale_x_discrete(name = "",
                   labels=c("Pax6:WT" = "Radial glia",
                            "neg:WT" = "Neurons", 
                            "Tbr2:WT" = "Progenitors")) +
  scale_y_continuous(name = "Normalized counts") +
  scale_fill_viridis(discrete = TRUE,
                     option = "viridis",
                     begin = 0.2 )

## object for tbr2
boxplot_tbr2 <- ggplot(eomes_exp) +
  geom_boxplot(aes(x=group, 
                   y=normalized_counts, 
                   fill=group)) +
  ggtitle("Tbr2/Eomes") +
  custom_theme() +
  theme(axis.text.x = element_text(angle = 45, 
                                   vjust = 1, 
                                   hjust = 1)) +
  scale_x_discrete(name = "",
                   labels=c("Pax6:WT" = "Radial glia",
                            "neg:WT" = "Neurons", 
                            "Tbr2:WT" = "Progenitors")) +
  scale_y_continuous(name = "Normalized counts") +
  scale_fill_viridis(discrete = TRUE,
                     option = "viridis",
                     begin = 0.2 )

## object for tubb3
boxplot_tubb3 <- ggplot(tubb3_exp) +
  geom_boxplot(aes(x=group, 
                   y=normalized_counts, 
                   fill=group)) +
  ggtitle("Tubb3") +
  custom_theme() +
  theme(axis.text.x = element_text(angle = 45, 
                                   vjust = 1, 
                                   hjust = 1)) +
  scale_x_discrete(name = "",
                   labels=c("Pax6:WT" = "Radial glia",
                            "neg:WT" = "Neurons", 
                            "Tbr2:WT" = "Progenitors")) +
  scale_y_continuous(name = "Normalized counts") +
  scale_fill_viridis(discrete = TRUE,
                     option = "viridis",
                     begin = 0.2 )

## object for prdm16
boxplot_prdm16 <- ggplot(prdm16_exp) +
  geom_boxplot(aes(x=group, 
                   y=normalized_counts, 
                   fill=group)) +
  ggtitle("Prdm16") +
  custom_theme() +
  theme(axis.text.x = element_text(angle = 45, 
                                   vjust = 1, 
                                   hjust = 1)) +
  scale_x_discrete(name = "",
                   labels=c("Pax6:WT" = "Radial glia",
                            "neg:WT" = "Neurons", 
                            "Tbr2:WT" = "Progenitors")) +
  scale_y_continuous(name = "Normalized counts") +
  scale_fill_viridis(discrete = TRUE,
                     option = "viridis",
                     begin = 0.2 )

## Aligning plots
boxplot_grid <- plot_grid( # Combine multiple plots into a single grid
  boxplot_pax6,            # Boxplot for PAX6
  boxplot_tbr2,            # Boxplot for TBR2
  boxplot_tubb3,           # Boxplot for TUBB3
  ncol = 3                 # Arrange the plots in 3 columns (side by side)
)

# Save plot to pdf
ggsave(
  plot = boxplot_grid,                  # Specify the plot to save
  filename = "results/boxplot_figure.pdf", # Set the file name and location
  device = pdf,                         # Save the figure as a PDF file
  width = 6,                            # Set the figure width to 6 inches
  units = "in",                         # Specify that the width is measured in inches
  dpi = 300                             # Set the resolution to 300 dots per inch
)

## we can use cowplot to bring in the images created outside R
# to do that, we use ggdraw() function to create a canvas to draw on
# draw_image() function to draw the image on the canvas

fig4a <- ggdraw() +
  draw_image("results/PP_fig4A.png")

fig4b <- ggdraw() +
  draw_image("results/PP_fig4B.png")

fig4c <- ggdraw() +
  draw_image("results/PP_fig4C.png")


# align_plots() is used to align multiple plots
# here, we are aligning figures 4A, 4B, 4C, 4D and 4E
# align = "v" means we want to align the plots vertically
# axis = "l" means we want to align the left axes of the plots

top_half <- align_plots(
  fig4a,                  # Figure 4A
  fig4b,                  # Figure 4B
  fig4c,                  # Figure 4C
  boxplot_grid,           # Figure 4D: grid containing the boxplots
  boxplot_prdm16,         # Figure 4E: PRDM16 boxplot
  align = "v",            # align the plots in the vertical direction
  axis = "l"              # Align the left (l) axes of all plots
)


# align_plots() returns the aligned plots as a list
# we give each plot a name so we can access them easily later

names(top_half) <- c(
  "fig4a",                # Name the first aligned plot
  "fig4b",                # Name the second aligned plot
  "fig4c",                # Name the third aligned plot
  "fig4d",                # Name the fourth aligned plot
  "fig4e"                 # Name the fifth aligned plot
)


# arrange the first row of the figure
# plot_grid() is used to arrange multiple plots together
# labels adds the labels A, B and C to the three plots
# nrow = 1 means that the three plots will be arranged in one row

first_row <- plot_grid(
  top_half$fig4a, top_half$fig4b, top_half$fig4c,
  labels = c("A", "B", "C"),
  nrow = 1
)  


# arrange the second row of the figure
# here, we arrange figures 4D and 4E side by side
# labels adds the labels D and E to the two plots
# rel_widths controls the relative width of each plot
# here, Figure 4D has a relative width of 1 and Figure 4E has a relative width of 0.3
# nrow = 1 means that the two plots will be arranged in one row

second_row <- plot_grid(
  top_half$fig4d, top_half$fig4e,
  labels = c("D", "E"),
  rel_widths = c(1, .3),
  nrow = 1
)


# save the second row to a file
# filename specifies the location and name of the output file
# plot specifies the plot we want to save
# units = "in" means the width and height are measured in inches
# width = 8.5 means the figure will be 8.5 inches wide
# height = 13/5 means the figure will be 2.6 inches high
# dpi = 500 specifies the resolution of the saved image

ggsave(
  filename = "results/fig4DE.png", 
  plot = second_row,
  units = "in", 
  width = 8.5,
  height = 13/5,
  dpi = 500
)  


# create the complete figure by combining the first and second rows
# ncol = 1 means the two rows will be arranged in one column
# this places the first row above the second row

plot_grid(
  first_row, 
  second_row, 
  ncol = 1
)
