rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")

load("data/new_train.rda")

local_data=new_train
#3 attributes confirmed unimportant: `*Alkaline phosphatase`, `Basophil%`, `Monocytes%`;
local_data=subset(local_data,select = -c(`*Alkaline phosphatase`, `Basophil%`, `Monocytes%`))
#gbm
library(caret)
fitControl <- trainControl( method = "repeatedcv", number = 4, repeats = 4)
model_gbm <- train(`blood sugar` ~ ., data = local_data, method = "gbm", trControl = fitControl,verbose = FALSE)
summary(model_gbm)
save(model_gbm,file="model/model_gbm.rda")
load("model/model_gbm.rda")
