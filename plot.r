df <- read.csv('hist.csv');

df$HRTIME <- as.POSIXct(df$TIME/1000, origin = "1970-01-01", tz="UTC")

x <- df$HRTIME;
y <- df$PLAYERS;

png("plot.png", width=1800, height=900)

p <- plot(df$HRTIME, df$PLAYERS, 
     main="Decentraland players across time", 
     sub="Data aggregated and analysed by Rphad", 
     xlab = "Time (UTC)",
     ylab = "Number of players")

lines(x[order(x)], y[order(x)])

dev.off()