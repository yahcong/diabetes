#k-交叉验证
rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
library("caret")
load("data/output/local_data_select.rda")

#load("data/output/train_data_NORM.rda")

#load("data/output/train_data_NORM_GLU.rda")
#load("data/output/MAX_GLU.rda")
#load("data/output/MIN_GLU.rda")

#train
library(randomForest)
set.seed(100)
library(caret)
#local_data=train_data_NORM
local_data=local_data_select
folds<-createFolds(y=local_data$GLU,k=10)#根据local_data的laber-GLU把数据集切分成10等份
re<-{}

for(i in 1:10){
  print(i)
  train_data<-local_data[-folds[[i]],]
  test_data<-local_data[folds[[i]],]
  set.seed(100)
  rf<-randomForest(GLU~.,data=train_data,ntree=100,proximity=TRUE)#GLU是因变量
  set.seed(100)
  predict_GLU=predict(rf,subset(test_data,select = -GLU))
  #predict_GLU=predict_GLU*(MAX_GLU-MIN_GLU)+MIN_GLU
  real_GLU=test_data$GLU
  #real_GLU=real_GLU**(MAX_GLU-MIN_GLU)+MIN_GLU
  re=c(re,RMSE(predict_GLU,real_GLU))
}
mean(re)#取k折交叉验证结果的均值作为评判模型准确率的结果
#NORM：1.423224
#select:1.421094