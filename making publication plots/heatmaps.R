library(pheatmap)
library(tidyverse)
library(cowplot)

# Loads ggplotify.
# This package allows plots produced by other plotting systems,
# such as pheatmap, to be converted into ggplot objects.
library(ggplotify)

normalized_counts <- read.csv("data/pp_all_normalized_counts.csv", row.names = 1)
results <- read.csv("data/pp_all_results.csv", row.names = 1)
meta <-  read.csv("data/pp_all_meta.csv", row.names = 1)

# Get Pax6 sig genes
pax6_sig_genes <- results %>%
  rownames_to_column("ensembl_id") %>%
  filter(pax6_padj < 0.05) %>%
  pull(ensembl_id)

# Filter heatmap for only the radial glia (Pax6 samples)
heatmap_normCounts <- normalized_counts[ , colnames(normalized_counts)[str_detect(colnames(normalized_counts), "Pax6")]]

# Filter for the sig genes
heatmap_normCounts <- heatmap_normCounts[which(rownames(heatmap_normCounts) %in% pax6_sig_genes), ]

# Copy metadata to new variable
heatmap_meta <- meta

# Assign sample names to be row names
rownames(heatmap_meta) <- heatmap_meta$samples

# subset metadata to match samples in count data
heatmap_meta <- heatmap_meta[which(colnames(heatmap_normCounts) %in% heatmap_meta$samples),]

# Select only the genotype column for annotations
heatmap_meta <- heatmap_meta %>%
  select(genotype)

# Re-level factors
heatmap_meta$genotype <-  factor(heatmap_meta$genotype, levels = c("WT", "KO"))

# Colors for heatmap

# The colorRampPalette() function in R creates a continuous
# color gradient function from a given set of base colors.
#
# This creates 6 colours progressing from:
#
#   blue -> white -> red
#
# Blue represents relatively low expression,
# white represents intermediate expression,
# and red represents relatively high expression.
#
# IMPORTANT:
# Because scale = "row" is used below, these colours represent
# relative expression within each gene rather than absolute
# expression across all genes.

# colorRampPalette(c(...))
#   -> creates a function capable of generating a colour gradient.
#
# (6)
#   -> asks that function to generate exactly 6 colours.
#
# The resulting vector of colours is stored in: 
# heatmap_colors

heatmap_colors <- colorRampPalette(c("blue", "white", "red"))(6)

# Colors for denoting annotations
annot_colors <- list(genotype = c(KO = "#F8766D", WT = "#00BFC4"))


# Creates a list containing the colours used for metadata
# annotations.
#
# genotype =
#   tells pheatmap that these colours belong to the
#   'genotype' annotation column.
#
# KO = "#F8766D"
#   -> assigns a specific colour to knockout samples.
#
# WT = "#00BFC4"
#   -> assigns a specific colour to wild-type samples.
#
# The names KO and WT MUST match the actual values in:
# heatmap_meta$genotype.


heatmap <- pheatmap(
  heatmap_normCounts,                   # The expression matrix to visualize.
                                        # Rows = genes
                                        # Columns = samples
  color = heatmap_colors,               # Specifies the colours used to represent expression values.
  annotation_col = heatmap_meta,        # Adds sample-level annotations above/beside the heatmap.
                                        # Each row of heatmap_meta corresponds to a sample.
                                        # The annotation is displayed for the columns of the
                                        # expression matrix.
  annotation_colors = annot_colors,     # Tells pheatmap which colours to use for each annotation.
                                        # In this case:
                                        #   WT -> #00BFC4
                                        #   KO -> #F8766D
  show_rownames = FALSE,                # Do not display gene names on the heatmap.
                                        # This is useful when there are many genes because showing
                                        # thousands of gene names would make the plot unreadable.
  show_colnames = FALSE,                # Do not display sample names.
                                        # This keeps the heatmap visually cleaner.
  border_color = "white",               # Sets the border between individual heatmap cells to white.
  scale = "row",                        # STANDARDIZES EACH GENE/ROW INDEPENDENTLY.
                                        #
                                        # For every gene:
                                        #
                                        #       expression - mean(expression)
                                        # Z = ----------------------------
                                        #             SD(expression)
                                        #
                                        # This means the heatmap shows relative expression patterns
                                        # across samples for each gene.
                                        #
                                        # It does NOT show the original normalized expression values.
  treeheight_col = 25,                  # Sets the height of the column dendrogram to 25.
                                        #
                                        # The dendrogram represents clustering of samples based on
                                        # their expression profiles.
  cellwidth = 20,                       # Sets the width of each heatmap cell.
  cellheight = 0.40,                    # Sets the height of each heatmap cell.
                                        #
                                        # A small value is useful when there are many genes.
  fontsize = 9,                         # Sets the general font size used in the heatmap.
  annotation_names_col = FALSE,         # Hides the name of the annotation column.
                                        #
                                        # Without this, you might see:
                                        #
                                        # genotype
                                        #
                                        # above the annotation.
  annotation_legend = FALSE             # Removes the annotation legend.
                                        #
                                        # Therefore, the WT/KO colour key will not be displayed.
)


# To add text annotation, we turn the pheatmap image into a ggplot using ggplotify
heatmap <- as.ggplot(heatmap)

# Adding white space to add annotations to the top, right, bottom, and left margins
heatmap <- heatmap + 
  theme(plot.margin = unit(c(1,0.5,0.5,0.5), "cm"))       
# plot.margin controls the amount of empty space between the plot and the edges of the overall plotting area.
# It takes 4 values (Top, Right, Bottom, Left)

# unit(c(1, 0.5, 0.5, 0.5), "cm") specfies the size of each margin in the order (top, right, bottom, left)
# Create margins of 1 cm at the top and 0.5 cm on the right, bottom, and left.

# Adding in annotations with cowplot 
heatmap_figure <- ggdraw(heatmap) +  
  draw_label("Radial glia", 
             x = 0.4, 
             y = 0.97,
             size = 14,
             hjust = 0,
             vjust = 0) +
  draw_label("Prdm16 cKO", 
             x = 0.24, 
             y = 0.91,
             size = 12,
             hjust = 0,
             vjust = 0,
             fontface = "italic") +
  draw_label("Prdm16 WT", 
             x = 0.58, 
             y = 0.91,
             size = 12,
             hjust = 0,
             vjust = 0,
             fontface = "italic") +
  draw_label("Up-regulated genes",
             angle = 90,
             size = 9,
             x = 0.03,
             y = 0.5,
             hjust = 0,
             vjust = 0) +
  draw_label("Down-regulated genes",
             angle = 90,
             size = 9,
             x = 0.03,
             y = 0.09,
             hjust = 0,
             vjust = 0) +
  draw_label("Genotype",
             size = 9,
             x = 0.09,
             y = 0.8,
             hjust = 0,
             vjust = 0)

heatmap_figure

# Save image
ggsave(filename = "results/heatmap_figure.png",
       plot = heatmap_figure,
       units = "in", 
       width = 4, 
       height = 5.15, 
       dpi = 500)    