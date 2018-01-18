rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/test_data_NORM.rda")
#load("data/output/test_local_data_select.rda")
local_data=test_data_NORM

#train
library(randomForest)
str(local_data)
set.seed(100)
load("model/model_randomForest_NORM_outlier.rda")

#预测
local_data$predict_GLU=round(predict(model_randomForest_NORM_outlier,local_data),3)
predict_data=round(local_data$predict_GLU,3)
write.table(predict_data,file="data/NORM_outlier.csv",row.names = FALSE,col.names=FALSE)
