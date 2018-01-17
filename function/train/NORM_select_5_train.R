rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/train_data_NORM.rda")

local_data=train_data_NORM
library(mice)
md.pattern(local_data)

#特征筛选
library(Boruta)
#在使用Boruta的时候不要使用有缺失值的数据集或极端值检查重要变量。
set.seed(100)
boruta.train_age_GLU <- Boruta(GLU~.-id, data = local_data, doTrace = 2)
#save(boruta.train,file="data/output/boruta.train.rda")
#load("data/output/boruta.train.rda")
save(boruta.train_age_GLU,file="data/output/boruta.train_age_GLU.rda")
load("data/output/boruta.train_age_GLU.rda")
boruta.train=boruta.train_age_GLU
print(boruta.train)
#Boruta对变量数据集中的意义给出了明确的命令。
#Boruta performed 99 iterations in 28.37547 mins.
#23 attributes confirmed important: A_G_NORM, age, ALB_NORM, ALT_NORM, AST_NORM and 18 more;
#5 attributes confirmed unimportant: BASO_NORM, EO_NORM, MONO_NORM, PDW_NORM, weekday;
#8 tentative attributes left: ALP_NORM, BUN_NORM, GLB_NORM, LYMPH_NORM, MPV_NORM and 3 more;


#现在，我们用图表展示Boruta变量的重要性。
#默认情况下，由于缺乏空间，Boruta绘图功能添加属性值到横的X轴会导致所有的属性值都无法显示。
#在这里我把属性添加到直立的X轴。
par(oma=c(2,0,0,0))
plot(boruta.train, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(boruta.train$ImpHistory),function(i)boruta.train$ImpHistory[is.finite(boruta.train$ImpHistory[,i]),i])
names(lz) <- colnames(boruta.train$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels),at = 1:ncol(boruta.train$ImpHistory), cex.axis = 0.7)
#蓝色的盒状图对应一个阴影属性的最小、平均和最大Z分数。
#红色、黄色和绿色的盒状图分别代表拒绝、暂定和确认属性的Z分数
#现在我们对实验性属性进行判定。
#实验性属性将通过比较属性的Z分数中位数和最佳阴影属性的Z分数中位数被归类为确认或拒绝
final.boruta <- TentativeRoughFix(boruta.train)
print(final.boruta)
#现在我们要得出结果了。让我们获取确认属性的列表。
getSelectedAttributes(final.boruta, withTentative = F)
# [1] "gender"      "age"         "AST_NORM"    "ALT_NORM"    "GGT_NORM"    "TP_NORM"     "ALB_NORM"   
# [8] "GLB_NORM"    "A_G_NORM"    "TG_NORM"     "CHOL_NORM"   "HDL_C_NORM"  "LDL_C_NORM"  "BUN_NORM"   
# [15] "CREA_NORM"   "UA_NORM"     "WBC_NORM"    "RBC_NORM"    "HGB_NORM"    "HCT_NORM"    "MCV_NORM"   
# [22] "MCH_NORM"    "MCHC_NORM"   "RDW_CV_NORM" "PLT_NORM"    "MPV_NORM"    "PCT_NORM"    "NEUT_NORM"  
# [29] "LYMPH_NORM" 
local_data_select=subset(local_data,
                         select = getSelectedAttributes(final.boruta, withTentative = F))
local_data_select$GLU=local_data$GLU

save(local_data_select,file="data/output/local_data_select.rda")
load("data/output/local_data_select.rda")
