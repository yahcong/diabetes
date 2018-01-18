rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/test_clean_data.rda")

local_data=test_clean_data

Qutlier = function(x){
  #x=local_data$GLU
  q1<-quantile(x, 0.001,na.rm = T)        #取得时1%时的变量值  
  q99<-quantile(x, 0.999,na.rm = T)    #replacement has 1 row, data has 0 说明一个没换  
  #print(q1)
  #print(q99)
  x[x<q1&!is.na(x)] = q1  
  x[x>q99&!is.na(x)] = q99
  return(x)
}

test_qutlier_data=local_data[,c(1:3)]
test_qutlier_data=cbind(test_qutlier_data,as.data.frame(lapply(local_data[,c(4:35)],Qutlier)))

save(test_qutlier_data,file="data/output/test_qutlier_data.rda")
load("data/output/test_qutlier_data.rda")


