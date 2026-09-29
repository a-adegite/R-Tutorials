library(ggvenn)
library(VennDiagram)

results <- read.csv("data/pp_all_results.csv", row.names = 1)

up_pax6 <- results[which(results$pax6_threshold & results$pax6_log2FoldChange > 0),]
up_tbr2 <- results[which(results$tbr2_threshold & results$tbr2_log2FoldChange > 0),]

down_pax6 <- results[which(results$pax6_threshold & results$pax6_log2FoldChange < 0),]
down_tbr2 <- results[which(results$tbr2_threshold & results$tbr2_log2FoldChange < 0),]

# Create list of up-regulated genes
up_list <- list(
  PAX6 = rownames(up_pax6),
  TBR2 = rownames(up_tbr2)
)

# Create list of down-regulated genes
down_list <- list(
  PAX6 = rownames(down_pax6),
  TBR2 = rownames(down_tbr2)
)

# Takes a list or a dataframe
ggvenn(up_list)

ggvenn(down_list)

length(intersect(up_list$PAX6, up_list$TBR2))

# Check overlap for upregulated set
length(which(row.names(up_pax6) %in% row.names(up_tbr2)))

# Check overlap for downregulated set
length(which(row.names(down_pax6) %in% row.names(down_tbr2)))

ggvenn(
  up_list,
  stroke_color = "grey",
  stroke_size = 1.5,
  show_percentage = FALSE,
  auto_scale = TRUE,
  fill_color = c("salmon", "lightblue"),
  set_name_size = 5,
  text_size = 4,
  set_name_color = c("salmon", "lightblue"),
  )+
  labs(
    title = "Overlap of up-regulated genes"
  )+
  theme(plot.title = element_text(hjust = 0.5, size = rel(1.5)))


down_venn <- ggvenn(
  down_list,
  stroke_color = "grey",
  set_name_color = c("salmon", "lightblue"),
  fill_color = c("salmon", "lightblue"),
  text_size = 4,
  set_name_size = 5,
  show_percentage = FALSE,
  auto_scale = TRUE

)+
  labs(
    title = "Overlap of down-regulated genes"
  )+
  theme(
    plot.title = element_text(hjust = 0.5, size = rel(1.5))
  )

ggsave(
  filename = "results/venn_down.png",
  device = png,
  plot = down_venn,
  dpi = 300
)

# Using Venn Diagram package
# Come back to this
venn.diagram(x = up_list, 
             filename = "results/venn_up.png",
             output = TRUE,
             main = "Overlap of up-regulated genes",
             main.fontfamily = "sans",
             main.cex = 0.75,
             height = 600 , 
             width = 600 , 
             resolution = 300,
             compression = "lzw",
             lwd = 2,
             col= "gray",
             fill = c("salmon", "lightblue"),
             cex = 0.5,
             fontfamily = "sans",
             category.names = c("PAX6" , "TBR2"),
             cat.cex = 0.7,
             cat.fontface = "bold",
             cat.default.pos = "outer",
             cat.pos = 0,
             cat.dist = c(0.06,0.097),
             cat.fontfamily = "sans",
             cat.col = c("salmon", "lightblue"))
