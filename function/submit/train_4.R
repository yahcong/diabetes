rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/local_data_select.rda")

local_data=local_data_select
library(mice)
md.pattern(local_data)


#划分训练集和测试集
sub <- sample(1:nrow(local_data_select),round(nrow(local_data_select)*0.7))
Training_Inner <- local_data_select[sub,]
Test_Inner <- local_data_select[-sub,]
local_data=Training_Inner

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

#预测
set.seed(100)
Test_Inner$predict_GLU <- round(predict(model_randomForest_NORM_select, subset(Test_Inner,select = -GLU)),3)
#分数
library(caret)
score_rmse=RMSE(Test_Inner$predict_GLU,Test_Inner$GLU)
#1.5600

#结论，去掉一些属性后，效果没啥区别？
