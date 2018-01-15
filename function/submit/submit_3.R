rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/test_data_NORM.rda")

local_data=test_data_NORM
library(mice)
md.pattern(local_data)
local_data=na.omit(local_data)
#test
library(randomForest)
str(local_data)
set.seed(100)
load("model/model_randomForest_NORM.rda")
local_data$predict_GLU=predict(model_randomForest_NORM,local_data[,c(2:36)])

test_set=fread("data/d_test_A_20180102.csv")
result=merge(test_set[,1],subset(local_data,select = c(id,predict_GLU)),by="id",all=T)

result$predict_GLU[is.na(result$predict_GLU)]=mean(na.omit(result$predict_GLU))
predict_data=round(result$predict_GLU,3)
write.table(predict_data,file="data/submit3.csv",row.names = FALSE,col.names=FALSE)
