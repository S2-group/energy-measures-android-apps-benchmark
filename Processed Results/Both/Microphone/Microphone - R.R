library(tidyverse)
library(plotly)
library(IRdisplay)

data <- Microphone_Raw
data$Phone <- factor(data$Phone, levels=c("Mi 9T", "Nexus 5X"))

# Violin plot with ggplot2
p <- data %>% ggplot(aes(x=Phone, y =Joule))  + 
  geom_violin() + 
  geom_boxplot(width=0.1)

p + ggtitle("Microphone") +
  ylab("Energy in Joule") + xlab("Phone")
