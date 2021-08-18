# load ggplot2
library(ggplot2)
library(plotly)

# read data
dat <- read.csv('spotifyChartsCOVIDUSA.csv')

# svd
principal <- data.frame(svd(data[,-c(1,2,16)])$u[,c(1,2,3)])
# pca
principal <- princomp(data[,-c(1,2,16)])$scores
colnames(principal) <- c("Comp.1","Comp.2","Comp.3")

labels <- dat['label']


# make scatterplots
# labels
colors <- c("before", "after")

# generating 3d scatterplot: special day ***
y <- list(title="Special Day", titlefont=f)
x <- list(title="Total Duration", titlefont=f)


# construct figure
figsd <- plot_ly(data=principal,x=~Comp.1, y=~Comp.2, type="scatter", 
                 mode="markers",color=colors[(labels=="before")+1], width = 900, height = 700, colors=c("Red", "Green")) 
figsd


# generating 3d scatterplot
fig <- plot_ly(data=principal,x=~Comp.1, y=~Comp.2, z=~Comp.3, type="scatter3d", mode="markers",color=colors[(labels=="before")+1], 
               xlab="Page Values", autosize = T, width = 900, height = 700, colors=c("Red", "Green"), marker=list(size=2))
fig

# generating 3d scatterplot
fig <- plot_ly(data=dat,x=~energy, y=~valence, z=~speechiness, type="scatter3d", mode="markers",color=colors[(labels=="before")+1], 
               xlab="Page Values", autosize = T, width = 900, height = 700, colors=c("Red", "Green"), marker=list(size=2))
fig
