rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/train_data_NORM.rda")
#划分训练集和测试集
sub <- sample(1:nrow(train_data_NORM),round(nrow(train_data_NORM)*0.7))
Training_Inner <- train_data_NORM[sub,]
Test_Inner <- train_data_NORM[-sub,]
local_data=Training_Inner


#local_data=train_data_NORM
library(mice)
md.pattern(local_data)
#train
library(randomForest)
str(local_data)
set.seed(100)
model_randomForest_NORM=randomForest(GLU ~ ., data = local_data[,c(2:37)],importance=TRUE,ntree=100)
save(model_randomForest_NORM,file="model/model_randomForest_NORM.rda")
load("model/model_randomForest_NORM.rda")

#预测
set.seed(100)

local_data$predict_GLU=round(predict(model_randomForest_NORM,local_data[,c(2:36)]),3)
#分数
library(caret)
score_rmse=RMSE(local_data$predict_GLU,local_data$GLU)
#0.6181

#预测
set.seed(100)

Test_Inner$predict_GLU <- round(predict(model_randomForest_NORM, Test_Inner[,c(2:36)]),3)
#分数
library(caret)
score_rmse=RMSE(Test_Inner$predict_GLU,Test_Inner$GLU)
#1.4785

