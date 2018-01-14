rm(list=ls())
library(data.table)
setwd("F:/DataMining/R/diabetes")
load("data/new_test.rda")
load("model/model_gbm.rda")
sample = fread("data/d_sample_20180102.csv")

#去掉有缺失值的数据226个
local_data=new_test
#3 attributes confirmed unimportant: `*Alkaline phosphatase`, `Basophil%`, `Monocytes%`;
local_data=subset(local_data,select = -c(`*Alkaline phosphatase`, `Basophil%`, `Monocytes%`))

test_set=na.omit(local_data)
test_set$BloodSugar=predict(model_gbm,test_set)
result=merge(new_test[,1],subset(test_set,select = c(id,BloodSugar)),by="id",all=T)
result$BloodSugar[is.na(result$BloodSugar)]=median(na.omit(result$BloodSugar))
predict_data=round(result$BloodSugar,3)
write.table(predict_data,file="data/submit1.csv",row.names = FALSE,col.names=FALSE)
