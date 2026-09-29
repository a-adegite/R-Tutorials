library(cowplot)

# Create Figure 4abc
fig4abc <-  ggdraw() +
  draw_image("results/fig4ABC.png")

fig4abc

# Create Figure 4de
fig4de <- ggdraw() +
  draw_image("results/fig4DE.png")

fig4de

# Create Figure 4H
fig4h_down <- ggdraw() +
  draw_image("results/venn_down.png")

fig4h_up <- ggdraw() +
  draw_image("results/venn_up.png")

fig4h <- plot_grid(fig4h_down,
                   fig4h_up,
                   ncol = 2)

fig4h                   

fig4g <- ggdraw() +
  draw_image("results/fig4G.png")


fig4gh_aligned <- align_plots(
  fig4g, 
  fig4h, 
  aligh = "h", # alighs the plot horizontally
  axis = "t"   # aligns them along their top t axes
)

names(fig4gh_aligned) <- c("fig4g", "fig4h")

fig4gh <- plot_grid(fig4g,
                    fig4h,
                    ncol=1,
                    labels = c("G", "H"),
                    label_x = 0,
                    rel_heights = c(1.5,1))


fig4gh

# Read in Figure 4F
fig4f <- ggdraw() +
  draw_image("results/heatmap_figure.png")

# Combine images into the third row
fig4fgh <- plot_grid(fig4f,
                     fig4gh,
                     labels = c("F", ""),
                     rel_widths = c(0.7, 1),
                     nrow = 1)

# Check output
fig4fgh

# Save image to file
ggsave(filename = "results/fig4FGH.png", 
       plot = fig4fgh,
       units = "in", 
       width = 8.5,
       height = 13/2.5,
       dpi = 500)

# Read in bar plot images
fig4i <- ggdraw() +
  draw_image("results/PP_fig4I.png")

fig4j <- ggdraw() +
  draw_image("results/PP_fig4J.png")

# Combine images into the last row
fig4ij <- plot_grid(fig4i,
                    fig4j,
                    labels = c("I", "J"),
                    nrow = 1)

# Save image to file
ggsave(filename = "results/fig4IJ.png", 
       plot = fig4ij,
       units = "in", 
       width = 8.5,
       dpi = 500)    

# Now that we have all our rows saved to the same width, we can read them in and combine them into a figure
# Read in rows
fig4ABC <- ggdraw() +
  draw_image("results/fig4ABC.png")

fig4DE <- ggdraw() +
  draw_image("results/fig4DE.png")

fig4FGH <- ggdraw() +
  draw_image("results/fig4FGH.png")  

fig4IJ <- ggdraw() +
  draw_image("results/fig4IJ.png")


# Align rows
all_figs <- align_plots(fig4ABC, fig4DE, fig4FGH, fig4IJ,
                        align = 'v', 
                        axis = 'lr')

names(all_figs) <- c("fig4abc", "fig4de", "fig4fgh", "fig4ij")

# Arrange the rows of the figure
first_row <- plot_grid(
  all_figs$fig4abc,
  nrow = 1)

second_row <- plot_grid(
  all_figs$fig4de,
  nrow = 1)

third_row <- plot_grid(
  all_figs$fig4fgh,
  nrow = 1)

fourth_row <- plot_grid(
  all_figs$fig4ij,
  nrow = 1)


# Combine images into the full figure
fig4complete <- plot_grid(first_row,
                          second_row,
                          third_row,
                          fourth_row,
                          ncol = 1,
                          align = 'v',
                          axis = 'lr',
                          rel_heights = c(0.8,0.64,1.27,0.88),
                          rel_widths = c(1,1,1,1))

# Save final image
ggsave(filename = "results/figure4_completed.png",
       plot = fig4complete,
       width = 8.5,
       height = 13,
       units = "in",
       dpi = 500)