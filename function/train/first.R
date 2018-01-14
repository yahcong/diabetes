rm(list=ls())
library(data.table)
library(caret)
setwd("F:/DataMining/R/diabetes")
load("data/output/train/train_import_var_select.rda")
load("model/model_gbm_select.rda")

local_train=train_import_var_select
local_train$BloodSugar=predict(model_gbm_select,local_train[,c(2:15)])
MSE_score=RMSE(local_train$BloodSugar,local_train$`blood sugar`)^2
MSE_score
