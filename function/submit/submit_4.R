rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/output/test_data_NORM.rda")

local_data=test_data_NORM
# test_local_data_select=subset(local_data,select = c(gender,age,AST_NORM,ALT_NORM,ALP_NORM,GGT_NORM,   
#                                                TP_NORM,ALB_NORM,A_G_NORM,TG_NORM,CHOL_NORM,HDL_C_NORM,
#                                                LDL_C_NORM,CREA_NORM,UA_NORM,WBC_NORM,RBC_NORM,HGB_NORM,   
#                                                HCT_NORM,MCV_NORM,MCH_NORM,MCHC_NORM,RDW_CV_NORM,MPV_NORM,  
#                                                PCT_NORM,NEUT_NORM,LYMPH_NORM))

test_local_data_select=subset(local_data,select = c(age, ALB_NORM, ALT_NORM, AST_NORM, CREA_NORM))

save(test_local_data_select,file="data/output/test_local_data_select.rda")
load("data/output/test_local_data_select.rda")

#train
library(randomForest)
str(local_data)
set.seed(100)
load("model/model_randomForest_NORM_select.rda")

#预测
test_local_data_select$predict_GLU=round(predict(model_randomForest_NORM_select,test_local_data_select),3)
predict_data=round(test_local_data_select$predict_GLU,3)
write.table(predict_data,file="data/test_local_data_select.csv",row.names = FALSE,col.names=FALSE)


