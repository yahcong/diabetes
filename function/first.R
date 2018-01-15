rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")

sample = fread("data/d_sample_20180102.csv")
test_set= fread("data/d_test_A_20180102.csv")
train_set = fread("data/d_train_20180102.csv")

#有各个乙肝属性的数据，单独做测试？
train=train_set
colnames(train)[20]=c("Hepatitis_B")
train_set_Hepatitis_B=train_set[!is.na(train$Hepatitis_B)]
save(train_set_Hepatitis_B,file="data/output/train_set_Hepatitis_B.rda")

local_train=train[,c(1:19,25:42)]

dim(local_train)
#local_train=na.omit(local_train)
#dim(local_train)
names(local_train)
#[1] "id"                     "性别"                   "年龄"                   "体检日期"               "*天门冬氨酸氨基转换酶" 
#[6] "*丙氨酸氨基转换酶"      "*碱性磷酸酶"            "*r_谷氨酰基转换酶"      "*总蛋白"                "白蛋白"                
#[11] "*球蛋白"                "白球比例"               "甘油三酯"               "总胆固醇"               "高密度脂蛋白胆固醇"    
#[16] "低密度脂蛋白胆固醇"     "尿素"                   "肌酐"                   "尿酸"                   "白细胞计数"            
#[21] "红细胞计数"             "血红蛋白"               "红细胞压积"             "红细胞平均体积"         "红细胞平均血红蛋白量"  
#[26] "红细胞平均血红蛋白浓度" "红细胞体积分布宽度"     "血小板计数"             "血小板平均体积"         "血小板体积分布宽度"    
#[31] "血小板比积"             "中性粒细胞%"            "淋巴细胞%"              "单核细胞%"              "嗜酸细胞%"             
#[36] "嗜碱细胞%"              "血糖"                  
names(local_train)=c("id","gender","age","date","AST",
                     "ALT","ALP","GGT","TP","ALB",
                     "GLB","A_G","TG","CHOL","HDL_C",
                     "LDL_C","BUN","CREA","UA","WBC",
                     "RBC","HGB","HCT","MCV","MCH",
                     "MCHC","RDW_CV","PLT","MPV","PDW",
                     "PCT","NEUT","LYMPH","MONO","EO",
                     "BASO","GLU")

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
local_train$weekday=format(as.Date(local_train$date),'%w')
local_train$weekday=as.factor(local_train$weekday)

new_train = subset(local_train, select = -date )

#3给出各个变量的正常区间
new_train$AST_MAX=40
new_train$AST_MIN=8
new_train$ALT_MAX=40
new_train$ALT_MIN=5
new_train$ALP_MAX=150
new_train$ALP_MIN=40
new_train$GGT_MAX=50
new_train$GGT_MIN=7
new_train$TP_MAX=83
new_train$TP_MIN=50
new_train$ALB_MAX=54
new_train$ALB_MIN=34
new_train$GLB_MAX=35
new_train$GLB_MIN=20
new_train$A_G_MAX=2.5
new_train$A_G_MIN=1.1
new_train$TG_MAX=1.7
new_train$TG_MIN=0
new_train$CHOL_MAX=5.2
new_train$CHOL_MIN=0
new_train$HDL_C_MAX=1.55
new_train$HDL_C_MIN=0.91
new_train$LDL_C_MAX=3.6
new_train$LDL_C_MIN=2
new_train$BUN_MAX=8.2
new_train$BUN_MIN=2.9
new_train$CREA_MAX=104
new_train$CREA_MIN=45
new_train$UA_MAX=416
new_train$UA_MIN=142

new_train$WBC_MAX=10
new_train$WBC_MIN=4

new_train$RBC_MAX=5.5
new_train$RBC_MIN=3.5
new_train$HGB_MAX=160
new_train$HGB_MIN=110
new_train$HCT_MAX=50
new_train$HCT_MIN=35
new_train$MCV_MAX=95
new_train$MCV_MIN=82
new_train$MCH_MAX=31
new_train$MCH_MIN=27
new_train$MCHC_MAX=360
new_train$MCHC_MIN=320
new_train$RDW_CV_MAX=14.5
new_train$RDW_CV_MIN=11.5
new_train$PLT_MAX=300
new_train$PLT_MIN=100
new_train$MPV_MAX=11
new_train$MPV_MIN=7
new_train$PDW_MAX=8.2
new_train$PDW_MIN=2.9
new_train$PCT_MAX=0.1
new_train$PCT_MIN=0.3
new_train$NEUT_MAX=75
new_train$NEUT_MIN=40
new_train$LYMPH_MAX=50
new_train$LYMPH_MIN=20
new_train$MONO_MAX=10
new_train$MONO_MIN=3
new_train$EO_MAX=8
new_train$EO_MIN=0.4
new_train$BASO_MAX=1
new_train$BASO_MIN=0
new_train$GLU_MAX=6.11
new_train$GLU_MIN=3.89


#保存
save(new_train,file="data/new_train.rda")
load("data/new_train.rda")


correlations=cor(local_train[,-1],use="everything")
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
correlations=cor(local_train_cor)
corrplot(corr = correlations)


#观察数据点之间的距离
#数据标准化
local_train_scaled = scale(local_train[,c(3:36)])
View(local_train_scaled)
#查看一下标准化后的数据
describe(local_train_scaled)

