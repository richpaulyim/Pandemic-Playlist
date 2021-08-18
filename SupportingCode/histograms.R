library(ggplot2)
spotify = read.csv("spotifyChartsCOVIDUSA.csv")

variables = names(spotify)
variables = variables[c(3:4,6,8:14)]

#***
ggplot(spotify, aes(danceability, fill = label)) + geom_density(alpha = 0.5)
ggplot(spotify, aes(energy, fill = label)) + geom_density(alpha = 0.5)
ggplot(spotify, aes(loudness, fill = label)) + geom_density(alpha = 0.5)

# *** speechiness
ggplot(spotify, aes(speechiness, fill = label)) + geom_density(alpha = 0.5)
ggplot(spotify, aes(acousticness, fill = label)) + geom_density(alpha = 0.5)
ggplot(spotify, aes(instrumentalness, fill = label)) + geom_density(alpha = 0.5) #illegible
ggplot(spotify, aes(liveness, fill = label)) + geom_density(alpha = 0.5)
# ***
ggplot(spotify, aes(valence, fill = label)) + geom_density(alpha = 0.5)
# *** tempo
ggplot(spotify, aes(tempo, fill = label)) + geom_density(alpha = 0.5)

ggplot(spotify, aes(duration_ms, fill = label)) + geom_density(alpha = 0.5)

# kurtosis stuff
before = subset(spotify, label == "before")
after = subset(spotify, label == "after")
kurtosis(before$tempo)
kurtosis(after$tempo)
kurtosis(before$speechiness)
kurtosis(after$speechiness)
length(after$speechiness)
length(before$speechiness)
