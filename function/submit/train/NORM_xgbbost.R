library(xgboost)
rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/test_local_data_select.rda")

local_data=test_local_data_select
#训练
model_NORM_xgboost <- xgboost(data = data.matrix(local_data[,c(1:6)]),
                label = local_data$GLU,
                eta = 0.1,
                max_depth = 10,
                nround=500,
                subsample = 1,
                #colsample_bytree = 1
                min_child_weight=5,
                #gamma=10,
                seed = 1
                
)
save(model_NORM_xgboost,file="model/model_NORM_xgboost.rda")
load("model/model_NORM_xgboost.rda")

#预测
local_data$predict_GLU <- round(predict(model_NORM_xgboost, data.matrix(local_data[,c(1:36)])),3)
#分数
library(caret)
score_rmse=RMSE(local_data$predict_GLU,local_data$GLU)
#0.0198219

#预测
Test_Inner$predict_GLU <- round(predict(model_NORM_xgboost, data.matrix(Test_Inner[,c(1:36)])),3)
#分数
library(caret)
score_rmse=RMSE(Test_Inner$predict_GLU,Test_Inner$GLU)
#1.4075
