rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")

sample = fread("data/d_sample_20180102.csv")
test_set= fread("data/d_test_A_20180102.csv")

#有各个乙肝属性的数据，单独做测试？
test=test_set
colnames(test)[20]=c("Hepatitis_B")
test_set_Hepatitis_B=test_set[!is.na(test$Hepatitis_B)]
save(test_set_Hepatitis_B,file="data/output/test_set_Hepatitis_B.rda")

local_test=test[,c(1:19,25:41)]

dim(local_test)
#local_test=na.omit(local_test)
#dim(local_test)
names(local_test)
#[1] "id"                     "性别"                   "年龄"                   "体检日期"               "*天门冬氨酸氨基转换酶" 
#[6] "*丙氨酸氨基转换酶"      "*碱性磷酸酶"            "*r_谷氨酰基转换酶"      "*总蛋白"                "白蛋白"                
#[11] "*球蛋白"                "白球比例"               "甘油三酯"               "总胆固醇"               "高密度脂蛋白胆固醇"    
#[16] "低密度脂蛋白胆固醇"     "尿素"                   "肌酐"                   "尿酸"                   "白细胞计数"            
#[21] "红细胞计数"             "血红蛋白"               "红细胞压积"             "红细胞平均体积"         "红细胞平均血红蛋白量"  
#[26] "红细胞平均血红蛋白浓度" "红细胞体积分布宽度"     "血小板计数"             "血小板平均体积"         "血小板体积分布宽度"    
#[31] "血小板比积"             "中性粒细胞%"            "淋巴细胞%"              "单核细胞%"              "嗜酸细胞%"             
#[36] "嗜碱细胞%"                               
names(local_test)=c("id","gender","age","date","AST",
                     "ALT","ALP","GGT","TP","ALB",
                     "GLB","A_G","TG","CHOL","HDL_C",
                     "LDL_C","BUN","CREA","UA","WBC",
                     "RBC","HGB","HCT","MCV","MCH",
                     "MCHC","RDW_CV","PLT","MPV","PDW",
                     "PCT","NEUT","LYMPH","MONO","EO",
                     "BASO")

#特征分析
#1性别
str(local_test)
table(local_test$gender)
#??   男   女 
#1 2283 1655 
local_test=local_test[local_test$gender!="??"]
table(local_test$gender)
#  男   女 
#2283 1655
local_test$gender=as.factor(local_test$gender)

#2 日期
table(local_test$date)
#date都是2017/10， 变为周的属性:0_6
local_test$weekday=format(as.Date(local_test$date),'%w')
local_test$weekday=as.factor(local_test$weekday)

new_test = subset(local_test, select = -date )

#3给出各个变量的正常区间
new_test$AST_MAX=40
new_test$AST_MIN=8
new_test$ALT_MAX=40
new_test$ALT_MIN=5
new_test$ALP_MAX=150
new_test$ALP_MIN=40
new_test$GGT_MAX=50
new_test$GGT_MIN=7
new_test$TP_MAX=83
new_test$TP_MIN=50
new_test$ALB_MAX=54
new_test$ALB_MIN=34
new_test$GLB_MAX=35
new_test$GLB_MIN=20
new_test$A_G_MAX=2.5
new_test$A_G_MIN=1.1
new_test$TG_MAX=1.7
new_test$TG_MIN=0
new_test$CHOL_MAX=5.2
new_test$CHOL_MIN=0
new_test$HDL_C_MAX=1.55
new_test$HDL_C_MIN=0.91
new_test$LDL_C_MAX=3.6
new_test$LDL_C_MIN=2
new_test$BUN_MAX=8.2
new_test$BUN_MIN=2.9
new_test$CREA_MAX=104
new_test$CREA_MIN=45
new_test$UA_MAX=416
new_test$UA_MIN=142

new_test$WBC_MAX=10
new_test$WBC_MIN=4

new_test$RBC_MAX=5.5
new_test$RBC_MIN=3.5
new_test$HGB_MAX=160
new_test$HGB_MIN=110
new_test$HCT_MAX=50
new_test$HCT_MIN=35
new_test$MCV_MAX=95
new_test$MCV_MIN=82
new_test$MCH_MAX=31
new_test$MCH_MIN=27
new_test$MCHC_MAX=360
new_test$MCHC_MIN=320
new_test$RDW_CV_MAX=14.5
new_test$RDW_CV_MIN=11.5
new_test$PLT_MAX=300
new_test$PLT_MIN=100
new_test$MPV_MAX=11
new_test$MPV_MIN=7
new_test$PDW_MAX=8.2
new_test$PDW_MIN=2.9
new_test$PCT_MAX=0.1
new_test$PCT_MIN=0.3
new_test$NEUT_MAX=75
new_test$NEUT_MIN=40
new_test$LYMPH_MAX=50
new_test$LYMPH_MIN=20
new_test$MONO_MAX=10
new_test$MONO_MIN=3
new_test$EO_MAX=8
new_test$EO_MIN=0.4
new_test$BASO_MAX=1
new_test$BASO_MIN=0



#保存
save(new_test,file="data/new_test.rda")
load("data/new_test.rda")
