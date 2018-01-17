#k-交叉验证
rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
library("caret")
load("data/output/local_data_select.rda")
#load("data/output/train_data_NORM_age_GLU.rda")

#train
library(xgboost)
set.seed(100)
library(caret)

local_data=local_data_select
folds<-createFolds(y=local_data$GLU,k=10)#根据local_data的laber-GLU把数据集切分成10等份
re<-{}

for(i in 1:10){
  print(i)
  train_data<-local_data[-folds[[i]],]
  test_data<-local_data[folds[[i]],]
  model_NORM_xgboost <- xgboost(data = data.matrix(subset(train_data,select=-GLU)),
                                label = train_data$GLU,
                                eta = 0.1,
                                max_depth = 10,
                                nround=500,
                                subsample = 1,
                                #colsample_bytree = 1
                                min_child_weight=5,
                                #gamma=10,
                                seed = 1
                                
  )
  rf<-randomForest(GLU~.,data=train_data,ntree=100,proximity=TRUE)#GLU是因变量
  result=round(predict(model_NORM_xgboost, data.matrix(subset(train_data,select=-GLU))))
  re=c(re,RMSE(result,test_data$GLU))
}
mean(re)#取k折交叉验证结果的均值作为评判模型准确率的结果
