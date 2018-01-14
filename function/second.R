rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")

load("data/new_train.rda")
import_var1=new_train[,c(2:8,36)]
import_var2=new_train[,c(9:18,36)]
import_var3=new_train[,c(19:36)]

#gbm
library(caret)
fitControl <- trainControl( method = "repeatedcv", number = 4, repeats = 4)
model_gbm_1 <- train(`blood sugar` ~ ., data = import_var1, method = "gbm", trControl = fitControl,verbose = FALSE)
summary(model_gbm_1)
save(model_gbm_1,file="model/model_gbm_1.rda")

model_gbm_2 <- train(`blood sugar` ~ ., data = import_var2, method = "gbm", trControl = fitControl,verbose = FALSE)
summary(model_gbm_2)
save(model_gbm_2,file="model/model_gbm_2.rda")

model_gbm_3 <- train(`blood sugar` ~ ., data = import_var3, method = "gbm", trControl = fitControl,verbose = FALSE)
summary(model_gbm_3)
save(model_gbm_3,file="model/model_gbm_3.rda")

model_gbm <- train(`blood sugar` ~ ., data = new_train, method = "gbm", trControl = fitControl,verbose = FALSE)
summary(model_gbm)
save(model_gbm,file="model/model_gbm.rda")

import_var_select=subset(new_train, select = c(id,age,gender,Triglycerides,`Erythrocyte_mean hemoglobinConcentration`,
                                               `Lymphocytes%`,`*r-glutamyl converting enzyme`,`*Alanine aminotransferase`,
                                               `*Aspartate aminotransferase`,Urea,Hemoglobin,`*Alkaline phosphatase`,
                                               `White blood cell count`,`Uric acid`,`averageVolume redBloodCells`,`blood sugar`))
train_import_var_select=import_var_select
save(train_import_var_select,file="data/output/train/train_import_var_select.rda")
load("data/output/train/train_import_var_select.rda")
model_gbm_select <- train(`blood sugar` ~ ., data = import_var_select[,c(2:16)], method = "gbm", trControl = fitControl,verbose = FALSE)
summary(model_gbm_select)
save(model_gbm_select,file="model/model_gbm_select.rda")
#为什么性别的影响几乎没有？