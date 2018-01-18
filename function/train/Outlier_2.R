rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/clean_data.rda")

local_data=clean_data


#GLU  
#1.异常值识别 
par(mfrow=c(1,2))#将绘图窗口划为1行两列，同时显示两图  
dotchart(local_data$GLU)#绘制单变量散点图,多兰图  
pc=boxplot(local_data$GLU,horizontal=T)#绘制水平箱形图  

#2.盖帽法
#整行替换数据框里99%以上和1%以下的点，将99%以上的点值=99%的点值；小于1%的点值=1%的点值。

#异常数据处理  
q1<-quantile(local_data$GLU, 0.001)        #取得时1%时的变量值  
q99<-quantile(local_data$GLU, 0.999)       #replacement has 1 row, data has 0 说明一个没换  
local_data[local_data$GLU<q1,]$GLU<-q1  
local_data[local_data$GLU>q99,]$GLU<-q99  
summary(local_data$GLU)                    #盖帽法之后，查看数据情况  
fix(local_data)#表格形式呈现数据  

#AST
#1.异常值识别 
par(mfrow=c(1,2))#将绘图窗口划为1行两列，同时显示两图  
dotchart(local_data$AST)#绘制单变量散点图,多兰图  
pc=boxplot(local_data$AST,horizontal=T)#绘制水平箱形图  

#2.盖帽法
#整行替换数据框里99%以上和1%以下的点，将99%以上的点值=99%的点值；小于1%的点值=1%的点值。

#异常数据处理  
q1<-quantile(local_data$AAST, 0.001)        #取得时1%时的变量值  
q99<-quantile(local_data$AST, 0.999,na.rm = T)    #replacement has 1 row, data has 0 说明一个没换  
local_data[local_data$AST<q1,]$AST<-q1  
local_data[local_data$AST>q99&!is.na(local_data$AST),]$AST<-q99
summary(local_data$AST)                    #盖帽法之后，查看数据情况  

Qutlier = function(x){
  q1<-quantile(x, 0.001,na.rm = T)        #取得时1%时的变量值  
  q99<-quantile(x, 0.999,na.rm = T)    #replacement has 1 row, data has 0 说明一个没换  
  #print(q1)
  #print(q99)
  x[x<q1&!is.na(x)] = q1  
  x[x>q99&!is.na(x)] = q99
  return(x)
}

qutlier_data=local_data[,c(1:3)]
qutlier_data=cbind(qutlier_data,as.data.frame(lapply(local_data[,c(4:36)],Qutlier)))
save(qutlier_data,file="data/output/qutlier_data.rda")
load("data/output/qutlier_data.rda")
#GLU验证
par(mfrow=c(1,2))#将绘图窗口划为1行两列，同时显示两图  
dotchart(qutlier_data$GLU)#绘制单变量散点图,多兰图  
pc=boxplot(qutlier_data$GLU,horizontal=T)#绘制水平箱形图  

