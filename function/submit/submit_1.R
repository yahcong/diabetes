rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/new_test.rda")
load("model/model_gbm_select.rda")
sample = fread("data/d_sample_20180102.csv")

#去掉有缺失值的数据226个
import_var_select=subset(new_test, select = c(id,age,gender,Triglycerides,`Erythrocyte_mean hemoglobinConcentration`,
                                               `Lymphocytes%`,`*r-glutamyl converting enzyme`,`*Alanine aminotransferase`,
                                               `*Aspartate aminotransferase`,Urea,Hemoglobin,`*Alkaline phosphatase`,
                                               `White blood cell count`,`Uric acid`,`averageVolume redBloodCells`))
test_set=na.omit(import_var_select)
test_set$BloodSugar=predict(model_gbm_select,test_set[,c(2:15)])
result=merge(new_test[,1],test_set[,c(1,16)],by="id",all=T)
result$BloodSugar[is.na(result$BloodSugar)]=mean(na.omit(result$BloodSugar))
predict_data=round(result$BloodSugar,3)
write.table(predict_data,file="data/submit1.csv",row.names = FALSE,col.names=FALSE)
