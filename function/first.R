rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")

sample = fread("data/d_sample_20180102.csv")
test_set= fread("data/d_test_A_20180102.csv")
train_set = fread("data/d_train_20180102.csv")

#有各个乙肝属性的数据，单独做测试？
train=train_set
colnames(train)[20]<-c("Hepatitis_B")
train_set_Hepatitis_B=train_set[!is.na(train$Hepatitis_B)]
save(train_set_Hepatitis_B,file="data/output/train_set_Hepatitis_B.rda")

local_train=train[,c(1:19,25:42)]

dim(local_train)
local_train=na.omit(local_train)
dim(local_train)
names(local_train)=c("id","gender","age","date","*Aspartate aminotransferase","*Alanine aminotransferase","*Alkaline phosphatase",
                     "*r-glutamyl converting enzyme","*Total protein","albumin","*globulin","Albumin globulin ratio","Triglycerides",
                     "Total cholesterol","High-density lipoprotein cholesterol","Low-density lipoprotein cholesterol","Urea","Creatinine",
                     "Uric acid","White blood cell count","Red blood cell count","Hemoglobin","Hematocrit","averageVolume redBloodCells",
                     "averageAmount redBloodCellsHemoglobin","Erythrocyte_mean hemoglobinConcentration","RedBloodCell volumeDistribution width",
                     "Platelet count","Average platelet volume","PlateletVolume distribution Width","Thrombocytopenia","Neutrophil%",
                     "Lymphocytes%","Monocytes%","Eosinophil%","Basophil%","blood sugar")
#特征分析
str(local_train)
table(local_train$gender)
#??   男   女 
#1 2283 1655 
local_train=local_train[local_train$gender!="??"]
table(local_train$gender)
#  男   女 
#2283 1655
local_train$gender=as.factor(local_train$gender)

#date
table(local_train$date)
#date都是2017/10，对样本没有多少影响，故去掉date这个属性
new_train <- subset(local_train, select = -date )
save(new_train,file="data/new_train.rda")
load("data/new_train.rda")


correlations<- cor(local_train[,-1],use="everything")
#pairs_data=local_train[,c(10:20)]
#pairs(~.,data=pairs_data,main="Scatterplot Matrix")

#采用Hmisc中的包
#对数据集进行描述
library(Hmisc)
describe(local_train)

#绘制相关系数图
library('corrplot')
local_train_cor=as.data.frame(local_train[30:37])
names(local_train_cor)=c(paste0("x",30:37))
correlations<- cor(local_train_cor)
corrplot(corr = correlations)


#观察数据点之间的距离
#数据标准化
local_train_scaled <- scale(local_train[,c(3:36)])
View(local_train_scaled)
#查看一下标准化后的数据
describe(local_train_scaled)

