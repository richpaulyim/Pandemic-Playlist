data$label01 <- ifelse(data$label == "before", 0, 1) #to incorporate into cor plot

#summary stat of all numerical variables
library(psych)
a <- round(as.matrix(psych::describe(data[, -c(1, 2, 5, 7, 15, 16, 17)])), 2)
a <- a[, -c(1, 2)]
a

#summary stat of ordinal/binary variables
table(data$key)
table(data$mode)
table(data$time_signature)
table(data$label) #how does this change after covid hits?
#percent change  = after-before/before *100
(364 - 401) /401 *100

#cor plot of numerical variables and binary response variable
cor <- round(cor(data[, -c(1, 2, 16)]), 2)
cor
library(corrplot)
corrplot(cor, method = "color", addCoef.col = "black", number.cex = .7, tl.cex=0.8)
