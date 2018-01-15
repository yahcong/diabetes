rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/train_data_NORM.rda")

local_data=train_data_NORM
library(mice)
md.pattern(local_data)
local_data=na.omit(local_data)
#train
library(randomForest)
str(local_data)
set.seed(100)
model_randomForest_NORM=randomForest(GLU ~ ., data = local_data[,c(2:37)],importance=TRUE,ntree=100)
save(model_randomForest_NORM,file="model/model_randomForest_NORM.rda")
load("model/model_randomForest_NORM.rda")
