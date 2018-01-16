rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/clean_data.rda")

local_data=clean_data
#library(mice)
#md.pattern(local_data)

library(mice)  
imp<-mice(local_data,seed=1234)  
#利用complete（）函数可观察m个插补数据集中的任意一个，格式为：complete(imp,action=#)
na_clean_Data=complete(imp,action=3)
save(na_clean_Data,file="data/output/na_clean_Data.rda")
load("data/output/na_clean_Data.rda")