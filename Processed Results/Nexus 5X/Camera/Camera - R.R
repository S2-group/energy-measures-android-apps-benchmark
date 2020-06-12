library(tidyverse)
library(plotly)
library(IRdisplay)

data <- Camera_Raw
data$Frequency <- factor(data$Frequency, levels=c("Low", "Medium", "High"))

# Violin plot with ggplot2
p <- data %>% ggplot(aes(x=Frequency, y =Joule))  + 
  geom_violin() + 
  geom_boxplot(width=0.1)

p + ggtitle("Camera") +
  ylab("Energy in Joule") + xlab("Frequency")
