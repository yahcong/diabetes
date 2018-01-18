rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/train_data_NORM.rda")

local_data=train_data_NORM
#train
library(randomForest)
str(local_data)
set.seed(100)

model_randomForest_NORM_outlier=randomForest(GLU ~ ., data = local_data,importance=TRUE,ntree=80)
save(model_randomForest_NORM_outlier,file="model/model_randomForest_NORM_outlier.rda")
load("model/model_randomForest_NORM_outlier.rda")

#预测
set.seed(100)
local_data$predict_GLU=round(predict(model_randomForest_NORM_outlier,subset(local_data,select = -GLU)),3)
#分数
library(caret)
score_rmse=RMSE(local_data$predict_GLU,local_data$GLU)
#0.6104
