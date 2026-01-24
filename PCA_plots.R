# 0. load packages
library(ggplot2)   # for plotting
library(dplyr)     # for data manipulation (optional but handy)
library(tibble)    # for nicer data frames (optional)

# 1. prepare the example data: numeric variables only
data(iris)
# Keep species for coloring, and numeric columns for PCA
iris_num <- iris %>% select(-Species)

# 2. run PCA with prcomp
# center = TRUE subtracts the mean; scale. = TRUE divides by the standard deviation (important if variables are on different scales)
pca_res <- prcomp(iris_num, center = TRUE, scale. = TRUE)

# 3. examine the result (important pieces)
summary(pca_res)           # shows proportion of variance explained by each PC
pca_res$rotation           # the loadings (eigenvectors) - variables × PCs
pca_res$x                  # the principal component scores (observations × PCs)

# 4. make a tidy data.frame of the scores and add the Species column for coloring
scores_df <- as.data.frame(pca_res$x) %>%
  rownames_to_column(var = "Sample") %>%
  bind_cols(Species = iris$Species)

# 5. compute percent variance for axis labels
var_perc <- (pca_res$sdev^2) / sum(pca_res$sdev^2) * 100
pc1_pct <- round(var_perc[1], 1)
pc2_pct <- round(var_perc[2], 1)

# 6. basic PCA scatter plot (PC1 vs PC2) with ggplot2
p <- ggplot(scores_df, aes(x = PC1, y = PC2, color = Species)) +
  geom_point(size = 3, alpha = 0.9) +
  stat_ellipse(aes(fill = Species), geom = "polygon", alpha = 0.15, show.legend = FALSE) +
  labs(
    x = paste0("PC1 (", pc1_pct, "%)"),
    y = paste0("PC2 (", pc2_pct, "%)"),
    title = "PCA of Iris (PC1 vs PC2)"
  ) +
  theme_minimal(base_size = 14)

print(p)

# 7. scree plot (variances explained)
scree_df <- data.frame(
  PC = paste0("PC", seq_along(var_perc)),
  Variance = var_perc
)
ggplot(scree_df, aes(x = PC, y = Variance)) +
  geom_col() +
  geom_line(aes(group = 1)) +
  geom_point() +
  labs(x = "Principal Component", y = "Percent variance explained", title = "Scree Plot") +
  theme_minimal()

# 8. biplot-like overlay: add variable loadings as arrows on the PC1/PC2 scatter
# scale the loadings for plotting (so arrows fit the scatter)
loadings <- as.data.frame(pca_res$rotation[, 1:2])
loadings$var <- rownames(loadings)
# choose a scaling factor (to make arrows visible). A common choice is to multiply by a constant:
mult <- 3  # adjust if arrows too short / too long
loadings <- loadings %>% mutate(arrow_x = PC1 * mult, arrow_y = PC2 * mult)

ggplot(scores_df, aes(x = PC1, y = PC2, color = Species)) +
  geom_point(size = 2) +
  geom_segment(data = loadings, aes(x = 0, y = 0, xend = arrow_x, yend = arrow_y),
               arrow = arrow(length = unit(0.2, "cm")), colour = "black") +
  geom_text(data = loadings, aes(x = arrow_x, y = arrow_y, label = var),
            hjust = 0.5, vjust = -0.5, size = 4) +
  labs(x = paste0("PC1 (", pc1_pct, "%)"), y = paste0("PC2 (", pc2_pct, "%)"),
       title = "PCA biplot (loadings as arrows)") +
  theme_minimal(base_size = 14)
