# load ggplot2
library(ggplot2)
library(plotly)


# ======================================
# read data
dat <- read.csv('~/Documents/Stats-140SL/spotifyChartsCOVIDUSA.csv')
dat
dat.nostring <- dat[,-c(1,2)]

# ======================================
# logistic regression 
lr <- glm(factor(label)~., data = dat.nostring, family = "binomial")
summary(lr)


# ======================================
# gbm
library(gbm)

# parameters
library(caret)
folds <- 8
train_control <- trainControl(method="repeatedcv", number=folds,
                              repeats=4,
                              classProbs = TRUE,
                              savePredictions = TRUE)

# loop, train find best tuning parameters,
# find best tuning parameters
# fit with best tune
ranks <- list()
for(i in 1:30){
  gbm.tune <- train(factor(label)~ ., data = dat.nostring, 
                   method = "gbm", 
                   trControl = train_control,
                   ## This last option is actually one
                   ## for gbm() that passes through
                   verbose = FALSE)$bestTune
  a <- summary(gbm(label=="after"~., data=dat.nostring, distribution="bernoulli",
              n.trees=gbm.tune$n.trees, interaction=gbm.tune$interaction.depth, 
              shrinkage=gbm.tune$shrinkage))
  ranks[[i]] <- a$var
  cat("iteration",i,"is done")
}

ranks.df <- data.frame(matrix(unlist(ranks), nrow=length(ranks), byrow=TRUE),stringsAsFactors=FALSE)

for(i in 1:13){
  print(table(ranks.df[,i]))
}

## find the max rankings
#for(i in ranks.df[1,]){
#  print(i)
#  print(table(which(ranks.df==i,arr.ind = 1)[,2]))
#}

cat(mean(dat$speechiness[dat$label=="before"]), mean(dat$speechiness[dat$label=="after"]))
cat(mean(dat$energy[dat$label=="before"]), mean(dat$energy[dat$label=="after"]))
cat(mean(dat$valence[dat$label=="before"]), mean(dat$valence[dat$label=="after"]))
cat(mean(dat$acousticness[dat$label=="before"]), mean(dat$acousticness[dat$label=="after"]))
cat(mean(dat$danceability[dat$label=="before"]), mean(dat$danceability[dat$label=="after"]))
