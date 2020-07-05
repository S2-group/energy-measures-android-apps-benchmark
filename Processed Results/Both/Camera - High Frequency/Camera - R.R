library(tidyverse)
library(plotly)
library(IRdisplay)

data <- Camera_Raw
data$Phone <- factor(data$Phone, levels=c("Mi 9T", "Nexus 5X", "Nexus 5X Monsoon"))

# Violin plot with ggplot2
p <- data %>% ggplot(aes(x=Phone, y =Joule))  + 
  geom_violin() + 
  geom_boxplot(width=0.1)

p + ggtitle("Camera - high frequency") +
  ylab("Energy in Joule") + xlab("Phone")
