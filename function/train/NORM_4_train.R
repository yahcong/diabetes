rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/max_min_set.rda")

train_data_NORM=max_min_set[,c(1,2,3,38)]
local_data=max_min_set
#str(local_data)
#names(local_data)
# [1] "id"         "gender"     "age"        "AST"        "ALT"        "ALP"        "GGT"        "TP"         "ALB"       
# [10] "GLP"        "A_G"        "TG"         "CHOL"       "HDL_C"      "LDL_C"      "BUN"        "CREA"       "UA"        
# [19] "WBC"        "RBC"        "HGB"        "HCT"        "MCV"        "MCH"        "MCHC"       "RDW_CV"     "PLT"       
# [28] "MPV"        "PDW"        "PCT"        "NEUT"       "LYMPH"      "MONO"       "EO"         "BASO"       "GLU"       
# [37] "weekday" ...

#数据/(MAX_MIN)
train_data_NORM$AST_NORM=(local_data$AST-local_data$AST_MIN)/(local_data$AST_MAX-local_data$AST_MIN)
train_data_NORM$ALT_NORM=(local_data$ALT-local_data$ALT_MIN)/(local_data$ALT_MAX-local_data$ALT_MIN)
train_data_NORM$ALP_NORM=(local_data$ALP-local_data$ALT_MIN)/(local_data$ALP_MAX-local_data$ALT_MIN)
train_data_NORM$GGT_NORM=(local_data$GGT-local_data$GGT_MIN)/(local_data$GGT_MAX-local_data$GGT_MIN)
train_data_NORM$TP_NORM=(local_data$TP-local_data$TP_MIN)/(local_data$TP_MAX-local_data$TP_MIN)
train_data_NORM$ALB_NORM=(local_data$ALB-local_data$ALB_MIN)/(local_data$ALB_MAX-local_data$ALB_MIN)
train_data_NORM$GLB_NORM=(local_data$GLB-local_data$GLB_MIN)/(local_data$GLB_MAX-local_data$GLB_MIN)
train_data_NORM$A_G_NORM=(local_data$A_G-local_data$A_G_MIN)/(local_data$A_G_MAX-local_data$A_G_MIN)
train_data_NORM$TG_NORM=(local_data$TG-local_data$TG_MIN)/(local_data$TG_MAX-local_data$TG_MIN)
train_data_NORM$CHOL_NORM=(local_data$CHOL-local_data$CHOL_MIN)/(local_data$CHOL_MAX-local_data$CHOL_MIN)
train_data_NORM$HDL_C_NORM=(local_data$HDL_C-local_data$HDL_C_MIN)/(local_data$HDL_C_MAX-local_data$HDL_C_MIN)
train_data_NORM$LDL_C_NORM=(local_data$LDL_C-local_data$BUN_MIN)/(local_data$LDL_C_MAX-local_data$LDL_C_MIN)
train_data_NORM$BUN_NORM=(local_data$BUN-local_data$BUN_MIN)/(local_data$BUN_MAX-local_data$BUN_MIN)
train_data_NORM$CREA_NORM=(local_data$CREA-local_data$CREA_MIN)/(local_data$CREA_MAX-local_data$CREA_MIN)
train_data_NORM$UA_NORM=(local_data$UA-local_data$UA_MIN)/(local_data$UA_MAX-local_data$UA_MIN)
train_data_NORM$WBC_NORM=(local_data$WBC-local_data$WBC_MIN)/(local_data$WBC_MAX-local_data$WBC_MIN)
train_data_NORM$RBC_NORM=(local_data$RBC-local_data$RBC_MIN)/(local_data$RBC_MAX-local_data$RBC_MIN)
train_data_NORM$HGB_NORM=(local_data$HGB-local_data$HGB_MIN)/(local_data$HGB_MAX-local_data$HGB_MIN)
train_data_NORM$HCT_NORM=(local_data$HCT-local_data$HCT_MIN)/(local_data$HCT_MAX-local_data$HCT_MIN)
train_data_NORM$MCV_NORM=(local_data$MCV-local_data$MCV_MIN)/(local_data$MCV_MAX-local_data$MCV_MIN)
train_data_NORM$MCH_NORM=(local_data$MCH-local_data$MCH_MIN)/(local_data$MCH_MAX-local_data$MCH_MIN)
train_data_NORM$MCHC_NORM=(local_data$MCHC-local_data$MCHC_MIN)/(local_data$MCHC_MAX-local_data$MCHC_MIN)
train_data_NORM$RDW_CV_NORM=(local_data$RDW_CV-local_data$RDW_CV_MIN)/(local_data$RDW_CV_MAX-local_data$RDW_CV_MIN)
train_data_NORM$PLT_NORM=(local_data$PLT-local_data$PLT_MIN)/(local_data$PLT_MAX-local_data$PLT_MIN)

train_data_NORM$MPV_NORM=(local_data$MPV-local_data$MPV_MIN)/(local_data$MPV_MAX-local_data$MPV_MIN)
train_data_NORM$PDW_NORM=(local_data$PDW-local_data$PDW_MIN)/(local_data$PDW_MAX-local_data$PDW_MIN)
train_data_NORM$PCT_NORM=(local_data$PCT-local_data$PCT_MIN)/(local_data$PCT_MAX-local_data$PCT_MIN)
train_data_NORM$NEUT_NORM=(local_data$NEUT-local_data$NEUT_MIN)/(local_data$NEUT_MAX-local_data$NEUT_MIN)
train_data_NORM$LYMPH_NORM=(local_data$LYMPH-local_data$LYMPH_MIN)/(local_data$LYMPH_MAX-local_data$LYMPH_MIN)
train_data_NORM$MONO_NORM=(local_data$MONO-local_data$MONO_MIN)/(local_data$MONO_MAX-local_data$MONO_MIN)
train_data_NORM$EO_NORM=(local_data$EO-local_data$EO_MIN)/(local_data$EO_MAX-local_data$EO_MIN)
train_data_NORM$BASO_NORM=(local_data$BASO-local_data$BASO_MIN)/(local_data$BASO_MAX-local_data$BASO_MIN)
#GLU
train_data_NORM$GLU=local_data$GLU
#age
max_age=max(train_data_NORM$age)
min_age=min(train_data_NORM$age)
train_data_NORM$age=(train_data_NORM$age-min_age)/(max_age-min_age)
save(train_data_NORM,file="data/output/train_data_NORM.rda")
load("data/output/train_data_NORM.rda")


#对GLU归一化
train_data_NORM_GLU=train_data_NORM
MAX_GLU=6.11
MIN_GLU=3.89
save(MAX_GLU,file="data/output/MAX_GLU.rda")
load("data/output/MAX_GLU.rda")
save(MIN_GLU,file="data/output/MIN_GLU.rda")
load("data/output/MIN_GLU.rda")
train_data_NORM_GLU$GLU_NORM=local_data$GLU/(MAX_GLU-MIN_GLU)
save(train_data_NORM_GLU,file="data/output/train_data_NORM_GLU.rda")
load("data/output/train_data_NORM_GLU.rda")

