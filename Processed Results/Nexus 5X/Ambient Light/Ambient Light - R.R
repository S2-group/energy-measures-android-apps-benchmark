library(tidyverse)
library(plotly)
library(IRdisplay)

data <- Ambient_Light_Raw

# Violin plot with ggplot2
p <- data %>% ggplot(aes(x="", y = Standard))  + 
  geom_violin() + 
  geom_boxplot(width=0.1) +
  theme(axis.title.x = element_blank())

p + ggtitle("Ambient light sensor") +
  ylab("Energy in Joule")
