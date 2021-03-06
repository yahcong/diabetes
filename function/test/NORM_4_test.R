rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/test_max_min_set.rda")

test_data_NORM=test_max_min_set[,c(1,2,3,37)]
local_data=test_max_min_set

#数据/(MAX_MIN)
test_data_NORM$AST_NORM=(local_data$AST-local_data$AST_MIN)/(local_data$AST_MAX-local_data$AST_MIN)
test_data_NORM$ALT_NORM=(local_data$ALT-local_data$ALT_MIN)/(local_data$ALT_MAX-local_data$ALT_MIN)
test_data_NORM$ALP_NORM=(local_data$ALP-local_data$ALT_MIN)/(local_data$ALP_MAX-local_data$ALT_MIN)
test_data_NORM$GGT_NORM=(local_data$GGT-local_data$GGT_MIN)/(local_data$GGT_MAX-local_data$GGT_MIN)
test_data_NORM$TP_NORM=(local_data$TP-local_data$TP_MIN)/(local_data$TP_MAX-local_data$TP_MIN)
test_data_NORM$ALB_NORM=(local_data$ALB-local_data$ALB_MIN)/(local_data$ALB_MAX-local_data$ALB_MIN)
test_data_NORM$GLB_NORM=(local_data$GLB-local_data$GLB_MIN)/(local_data$GLB_MAX-local_data$GLB_MIN)
test_data_NORM$A_G_NORM=(local_data$A_G-local_data$A_G_MIN)/(local_data$A_G_MAX-local_data$A_G_MIN)
test_data_NORM$TG_NORM=(local_data$TG-local_data$TG_MIN)/(local_data$TG_MAX-local_data$TG_MIN)
test_data_NORM$CHOL_NORM=(local_data$CHOL-local_data$CHOL_MIN)/(local_data$CHOL_MAX-local_data$CHOL_MIN)
test_data_NORM$HDL_C_NORM=(local_data$HDL_C-local_data$HDL_C_MIN)/(local_data$HDL_C_MAX-local_data$HDL_C_MIN)
test_data_NORM$LDL_C_NORM=(local_data$LDL_C-local_data$BUN_MIN)/(local_data$LDL_C_MAX-local_data$LDL_C_MIN)
test_data_NORM$BUN_NORM=(local_data$BUN-local_data$BUN_MIN)/(local_data$BUN_MAX-local_data$BUN_MIN)
test_data_NORM$CREA_NORM=(local_data$CREA-local_data$CREA_MIN)/(local_data$CREA_MAX-local_data$CREA_MIN)
test_data_NORM$UA_NORM=(local_data$UA-local_data$UA_MIN)/(local_data$UA_MAX-local_data$UA_MIN)
test_data_NORM$WBC_NORM=(local_data$WBC-local_data$WBC_MIN)/(local_data$WBC_MAX-local_data$WBC_MIN)
test_data_NORM$RBC_NORM=(local_data$RBC-local_data$RBC_MIN)/(local_data$RBC_MAX-local_data$RBC_MIN)
test_data_NORM$HGB_NORM=(local_data$HGB-local_data$HGB_MIN)/(local_data$HGB_MAX-local_data$HGB_MIN)
test_data_NORM$HCT_NORM=(local_data$HCT-local_data$HCT_MIN)/(local_data$HCT_MAX-local_data$HCT_MIN)
test_data_NORM$MCV_NORM=(local_data$MCV-local_data$MCV_MIN)/(local_data$MCV_MAX-local_data$MCV_MIN)
test_data_NORM$MCH_NORM=(local_data$MCH-local_data$MCH_MIN)/(local_data$MCH_MAX-local_data$MCH_MIN)
test_data_NORM$MCHC_NORM=(local_data$MCHC-local_data$MCHC_MIN)/(local_data$MCHC_MAX-local_data$MCHC_MIN)
test_data_NORM$RDW_CV_NORM=(local_data$RDW_CV-local_data$RDW_CV_MIN)/(local_data$RDW_CV_MAX-local_data$RDW_CV_MIN)
test_data_NORM$PLT_NORM=(local_data$PLT-local_data$PLT_MIN)/(local_data$PLT_MAX-local_data$PLT_MIN)

test_data_NORM$MPV_NORM=(local_data$MPV-local_data$MPV_MIN)/(local_data$MPV_MAX-local_data$MPV_MIN)
test_data_NORM$PDW_NORM=(local_data$PDW-local_data$PDW_MIN)/(local_data$PDW_MAX-local_data$PDW_MIN)
test_data_NORM$PCT_NORM=(local_data$PCT-local_data$PCT_MIN)/(local_data$PCT_MAX-local_data$PCT_MIN)
test_data_NORM$NEUT_NORM=(local_data$NEUT-local_data$NEUT_MIN)/(local_data$NEUT_MAX-local_data$NEUT_MIN)
test_data_NORM$LYMPH_NORM=(local_data$LYMPH-local_data$LYMPH_MIN)/(local_data$LYMPH_MAX-local_data$LYMPH_MIN)
test_data_NORM$MONO_NORM=(local_data$MONO-local_data$MONO_MIN)/(local_data$MONO_MAX-local_data$MONO_MIN)
test_data_NORM$EO_NORM=(local_data$EO-local_data$EO_MIN)/(local_data$EO_MAX-local_data$EO_MIN)
test_data_NORM$BASO_NORM=(local_data$BASO-local_data$BASO_MIN)/(local_data$BASO_MAX-local_data$BASO_MIN)
#GLU
test_data_NORM$GLU=local_data$GLU
#age
max_age=max(test_data_NORM$age)
min_age=min(test_data_NORM$age)
test_data_NORM$age=(test_data_NORM$age-min_age)/(max_age-min_age)
save(test_data_NORM,file="data/output/test_data_NORM.rda")
load("data/output/test_data_NORM.rda")




