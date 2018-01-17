rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/test_data_NORM.rda")

local_data=test_data_NORM
#特征筛选
library(Boruta)
load("data/output/boruta.train_age_GLU.rda")
boruta.test=boruta.train_age_GLU
print(boruta.test)

#画图
par(oma=c(2,0,0,0))
plot(boruta.test, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(boruta.test$ImpHistory),function(i)boruta.test$ImpHistory[is.finite(boruta.test$ImpHistory[,i]),i])
names(lz) <- colnames(boruta.test$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels),at = 1:ncol(boruta.test$ImpHistory), cex.axis = 0.7)
#蓝色的盒状图对应一个阴影属性的最小、平均和最大Z分数。
#红色、黄色和绿色的盒状图分别代表拒绝、暂定和确认属性的Z分数
#现在我们对实验性属性进行判定。
#实验性属性将通过比较属性的Z分数中位数和最佳阴影属性的Z分数中位数被归类为确认或拒绝
final.boruta <- TentativeRoughFix(boruta.test)
print(final.boruta)
#现在我们要得出结果了。让我们获取确认属性的列表。
getSelectedAttributes(final.boruta, withTentative = F)
# [1] "gender"      "age"         "AST_NORM"    "ALT_NORM"    "GGT_NORM"    "TP_NORM"     "ALB_NORM"   
# [8] "GLB_NORM"    "A_G_NORM"    "TG_NORM"     "CHOL_NORM"   "HDL_C_NORM"  "LDL_C_NORM"  "BUN_NORM"   
# [15] "CREA_NORM"   "UA_NORM"     "WBC_NORM"    "RBC_NORM"    "HGB_NORM"    "HCT_NORM"    "MCV_NORM"   
# [22] "MCH_NORM"    "MCHC_NORM"   "RDW_CV_NORM" "PLT_NORM"    "MPV_NORM"    "PCT_NORM"    "NEUT_NORM"  
# [29] "LYMPH_NORM" 
test_local_data_select=subset(local_data,
                         select = getSelectedAttributes(final.boruta, withTentative = F))

save(test_local_data_select,file="data/output/test_local_data_select.rda")
load("data/output/test_local_data_select.rda")
