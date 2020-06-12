library(tidyverse)
library(plotly)
library(IRdisplay)

data <- Display_Raw

# Violin plot with ggplot2
p <- data %>% ggplot(aes(x="", y = Standard))  + 
  geom_violin() + 
  geom_boxplot(width=0.1) +
  theme(axis.title.x = element_blank())

p + ggtitle("Display") +
  ylab("Energy in Joule")
