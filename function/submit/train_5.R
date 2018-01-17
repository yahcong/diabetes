rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/local_data_select.rda")

local_data=local_data_select
#train
library(randomForest)
str(local_data)
set.seed(100)

model_randomForest_NORM_select=randomForest(GLU ~ ., data = local_data,importance=TRUE,ntree=80)
save(model_randomForest_NORM_select,file="model/model_randomForest_NORM_select.rda")
load("model/model_randomForest_NORM_select.rda")

#预测
set.seed(100)
local_data$predict_GLU=round(predict(model_randomForest_NORM_select,subset(local_data,select = -GLU)),3)
#分数
library(caret)
score_rmse=RMSE(local_data$predict_GLU,local_data$GLU)
#0.6104
