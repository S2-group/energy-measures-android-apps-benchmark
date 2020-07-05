library(tidyverse)
library(plotly)
library(IRdisplay)

data <- Local_Storage_Raw
data$Phone <- factor(data$Phone, levels=c("Mi 9T", "Nexus 5X", "Nexus 5X Monsoon"))

# Violin plot with ggplot2
p <- data %>% ggplot(aes(x=Phone, y =Joule))  + 
  geom_violin() + 
  geom_boxplot(width=0.1)

p + ggtitle("Local storage - low frequency") +
  ylab("Energy in Joule") + xlab("Phone")
