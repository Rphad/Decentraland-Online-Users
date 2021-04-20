#Libraries
library(ggplot2)
library(dplyr)
library(plotly)
library(hrbrthemes)
library(htmlwidgets)

# Load dataset from github
df <- read.csv('activity_history_10_days.csv');
#Converting the time units
df$TIME <- as.POSIXct(df$TIME/1000, origin = "1970-01-01", tz="UTC")

# Usual area chart
p <- df %>%
  ggplot( aes(x=TIME, y=PLAYERS)) +
  geom_area(fill="#FFC96B", alpha=0.5) +
  geom_line(color="#FF1D5A", alpha=0.7) +
  ylab("Online users") +
  theme_ipsum()

# Turn it interactive with ggplotly
p <- ggplotly(p)
p

# save the widget
saveWidget(p, file=paste0(getwd(), "/interactiveGraph.html"))%   
