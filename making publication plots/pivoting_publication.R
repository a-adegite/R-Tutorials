# When submitting a manuscript for publication, we often aim for the highest impact journal to which 
# we feel there is a decent probability of acceptance. However, often our manuscripts are not 
# accepted at the first choice journal, and we need to pivot the format and figures to meet the 
# guidelines of the next chosen journal. We will discuss coding features which can ease the 
# resubmission process, many of which we have introduced previously, including:
  
# Creating a personal theme
# Creating a personal color palette
# Incorporating variables for plot features likely to change during the resubmission process. 
# Plotting features likely to change between journals include:
  
# text font type
# text font style
# text size
# figure label designation (A, Figure B, FigC, d., etc.)
# figure resolution
# figure size
# output file type (tiff, svg, eps, etc.)

# Altering the theme
# Theme changes from journals to journals, it is always best practice to create a function that allows
# easy transitioning to a different set of requirements

# Adding journal requirements to theme with variables
# Define likely to change variables at beginning of plotting script
font <- "Helvetica"
text_size <- 6
line_size <- 0.5

# Create custom theme with variables
custom_theme <- function(){ 
  theme_bw() +
    theme(text = element_text(family = font,
                              size = text_size),
          line = element_line(size = line_size),
          axis.title = element_text(size = rel(1.25)),
          axis.text = element_text(size = rel(1.15)),
          plot.title = element_text(size = rel(1.5),
                                    hjust = 0.5),
          panel.grid = element_blank(),
          legend.position = "none")
}

# Altering personal color palettes
# Define new palette
personal_boxplot_palette <- c("#440154FF", "#228C8DFF", "#FDE725FF")

# ggplot2 code to remain the same
ggplot(pax6_exp) +
  geom_boxplot(aes(x=group, 
                   y=normalized_counts, 
                   fill=group)) +
  ggtitle("Pax6") +
  personal_theme() +
  theme(axis.text.x = element_text(angle = 45, 
                                   vjust = 1, 
                                   hjust = 1)) +
  scale_x_discrete(name = "",
                   labels=c("Pax6:WT" = "Radial glia",
                            "neg:WT" = "Neurons", 
                            "Tbr2:WT" = "Progenitors")) +
  scale_y_continuous(name = "Normalized counts") +
  scale_fill_manual(values = personal_boxplot_palette)


# Incorporating variables for plot features likely to change

# Define likely to change features as variables at beginning of the plotting script
# Theme elements
font <- "Helvetica"
text_size <- 6
line_size <- 0.5

# Figure elements
res <- 300
full_width <- 8.5
full_height <- 13
meas_units <- "in"
output_filetype <- "svg"
fig_lab_size <- 9
fig_lab_pos_x <- 0
fig_lab_pos_y <- 1
label_type <- "AUTO"

# Example code using pre-defined variables

# Create annotations for all desired volcano plots, and save them to variables
volcano_panel1 <- ggdraw(volcano_RG) + 
  draw_label("664 genes", 
             x = 0.15, 
             y = 0.82,
             hjust = 0,
             vjust = 0,
             fontface = "bold",
             size = text_size,
             fontfamily = font)

# other panels...

# Align volcano plots and label with A, B, C
volcano_grid <- plot_grid(volcano_panel1,
                          volcano_panel2,
                          volcano_panel3,
                          ncol = 3,
                          labels = label_type,
                          label_size = fig_lab_size,
                          label_x = fig_lab_pos_x,
                          label_y = fig_lab_pos_y)

# Save image
ggsave(plot = volcano_grid,
       filename = "results/volcano_figure.png",
       width = full_width,
       height = full_height/2.5,
       units = meas_units,
       dpi = res)