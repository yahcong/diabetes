rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")

sample = fread("data/d_sample_20180102.csv")
test_set= fread("data/d_test_A_20180102.csv")
train_set = fread("data/d_train_20180102.csv")

local_train=train_set[,c(1:19,25:42)]

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
correlations<- cor(local_train[,-1],use="everything")
pairs_data=local_train[,c(10:20)]
pairs(~.,data=pairs_data,main="Scatterplot Matrix")
