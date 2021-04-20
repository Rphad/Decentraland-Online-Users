#Loading the CSV
df <- read.csv('activity_history.csv');

#Converting the time units
df$HRTIME <- as.POSIXct(df$TIME, origin = "1970-01-01", tz="UTC")

#Storing the columns in x and y vectors for easier reading & plotting
x <- df$HRTIME;
y <- df$PLAYERS;

#Defining the properties of the plot image
png("plot.png", width=1800, height=900)

#plot
p <- plot(df$HRTIME, df$PLAYERS, 
     main="Decentraland players across time", 
     sub="Data aggregated and analysed by Rphad", 
     xlab = "Time (UTC)",
     ylab = "Number of players")

#Adding lines between points for better reading
lines(x[order(x)], y[order(x)])

#Closing device, thus saving the file
dev.off()
