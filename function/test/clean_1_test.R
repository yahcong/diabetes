rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
test_set= fread("data/d_test_A_20180102.csv")

#有各个乙肝属性的数据，单独做测试？
train=test_set
colnames(train)[20]=c("Hepatitis_B")
train_set_Hepatitis_B=test_set[!is.na(train$Hepatitis_B)]
save(train_set_Hepatitis_B,file="data/output/train_set_Hepatitis_B.rda")
local_train=train[,c(1:19,25:41)]

names(local_train)
#[1] "id"                     "性别"                   "年龄"                   "体检日期"               "*天门冬氨酸氨基转换酶" 
#[6] "*丙氨酸氨基转换酶"      "*碱性磷酸酶"            "*r_谷氨酰基转换酶"      "*总蛋白"                "白蛋白"                
#[11] "*球蛋白"                "白球比例"               "甘油三酯"               "总胆固醇"               "高密度脂蛋白胆固醇"    
#[16] "低密度脂蛋白胆固醇"     "尿素"                   "肌酐"                   "尿酸"                   "白细胞计数"            
#[21] "红细胞计数"             "血红蛋白"               "红细胞压积"             "红细胞平均体积"         "红细胞平均血红蛋白量"  
#[26] "红细胞平均血红蛋白浓度" "红细胞体积分布宽度"     "血小板计数"             "血小板平均体积"         "血小板体积分布宽度"    
#[31] "血小板比积"             "中性粒细胞%"            "淋巴细胞%"              "单核细胞%"              "嗜酸细胞%"             
#[36] "嗜碱细胞%"                            
names(local_train)=c("id","gender","age","date","AST",
                     "ALT","ALP","GGT","TP","ALB",
                     "GLB","A_G","TG","CHOL","HDL_C",
                     "LDL_C","BUN","CREA","UA","WBC",
                     "RBC","HGB","HCT","MCV","MCH",
                     "MCHC","RDW_CV","PLT","MPV","PDW",
                     "PCT","NEUT","LYMPH","MONO","EO",
                     "BASO")
#特征分析
#1性别
str(local_train)
table(local_train$gender)
#??   男   女 
#1 2283 1655 
local_train=local_train[local_train$gender!="??"]
table(local_train$gender)
#  男   女 
#2283 1655
local_train$gender=as.factor(local_train$gender)

#2 日期
table(local_train$date)
#date都是2017/10， 变为周的属性:0_6
#local_train$weekday=format(as.Date(local_train$date),'%w')
#local_train$weekday=as.factor(local_train$weekday)

new_train = subset(local_train, select = -date )
test_clean_data=new_train
save(test_clean_data,file="data/output/test_clean_data.rda")
load("data/output/test_clean_data.rda")
