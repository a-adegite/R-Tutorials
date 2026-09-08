library(ggplot2)
library(tidyverse)

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

expression_plot <- pivot_longer(normalized_counts,
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

View(pax6_exp)


# boxplot
ggplot(
  data = pax6_exp,
  aes(
    x = group,
    y = normalized_counts,
    fill = group
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
  scale_y_continuous(limits = c(0,100), breaks = c(20, 40, 60, 80, 100)) 


